//
//  MapViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 1/4/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import "MapViewController.h"
#import "ParkPlaceMark.h"
#import "ASIHTTPRequest.h"
#import "Fish.h"
#import "NSArray+ReplaceNull.h"
#import "JSON.h"
#import "NetworkReachability.h"
#import "DetailViewController.h"
#import "World_FisherAppDelegate.h"
#import "SNAdsManager.h"
#import "GameFishViewController.h"
#import "MapListViewController.h"
@implementation MapViewController
@synthesize mapView,mapList;

@synthesize location, fishArray;
@synthesize downloadQueue, responseString, url;
@synthesize mapAnnotations;
@synthesize detailViewController;
@synthesize segmentedControl;

- (void)dealloc {
    [super dealloc];
	[mapView release];
	[fishArray release];
	[downloadQueue release];
	[responseString release];
	[url release];
	[mapAnnotations release];
	[detailViewController release];
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *buttonNames = [NSArray arrayWithObjects:
                            @"Map", @"List",nil];
    self.segmentedControl = [[UISegmentedControl alloc]
                             initWithItems:buttonNames];
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.segmentedControl.momentary = YES;
    [self.segmentedControl addTarget:self action:@selector(segmentAction:)
                    forControlEvents:UIControlEventValueChanged];

    
    self.navigationItem.titleView = segmentedControl;
    
    
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	static int count = 1;
	NSString *urlString = [NSString stringWithFormat:@"http://www.semanticdevlab.com/world_hunter/admin/mycatch-json.php?count=%d", count];
	NSLog(@"%@", urlString);
	self.url = [[NSURL alloc] initWithString:urlString];
	downloadQueue = [[NSOperationQueue alloc] init];
	[self loadAnnotationData];
	self.mapAnnotations = [[NSMutableArray alloc]init];
	self.mapView.delegate=self;
	
	World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
	location = appDelegate.currentPosition.coordinate;	
	
//	ParkPlaceMark *placemark=[[ParkPlaceMark alloc] init];
	
	MKCoordinateRegion region =  {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES];
	
}
-(void) segmentAction: (UISegmentedControl *) segmentedControl
{
    // Update the label with the segment number
    NSString *segmentNumber = [NSString stringWithFormat:@"%0d",
                               segmentedControl.selectedSegmentIndex];
    if ([segmentNumber isEqualToString:@"0"]) {
        NSLog(@"helloworld");
        
        
    }else if ([segmentNumber isEqualToString:@"1"])
    {
        NSLog(@"second");
      self.mapList = [[MapListViewController alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            
            self.mapList = [[MapListViewController alloc] initWithNibName:@"MapListViewController-ipad" bundle:nil];
        else
            self.mapList = [[MapListViewController alloc] initWithNibName:@"MapListViewController" bundle:nil];
        
        
        
//        [self.navigationController pushViewController:gameFish animated:YES];
////        MapViewController *map = [[MapViewController alloc] init];
       [self.navigationController pushViewController:self.mapList animated:YES];
        
    }
}
- (void)viewWillDisappear:(BOOL)animated{
	NSLog(@"View will disappear");
}
-(void)viewWillAppear:(BOOL)animated{

  self.segmentedControl.selectedSegmentIndex = 0;

}
- (void)loadAnnotationData
{
	// Check if the remote server is available
	NetworkReachability *reachManager = [NetworkReachability sharedReachability];
	[reachManager setHostName:@"www.google.com"];
	NetworkStatus remoteHostStatus = [reachManager remoteHostStatus];
	if (remoteHostStatus == NotReachable)
	{	
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"Network is not reachable! \nRetry?" 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		return;
	}
	else if (remoteHostStatus == ReachableViaWiFiNetwork)
	{
		[self.downloadQueue setMaxConcurrentOperationCount:4];
	}
	else if (remoteHostStatus == ReachableViaCarrierDataNetwork)
	{
		[self.downloadQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
	}
		NSLog(@"inside load Annotation data");
	[self fetchURLData];
}
- (void)fetchURLData{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:self.url];
	[request setDelegate:self];
	NSOperationQueue *queue = self.downloadQueue;
	[queue addOperation:request];
	[request release];
	[pool drain];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"inside pinish");
	if (responseString)
		[responseString release];
	responseString = [[NSString alloc] initWithString:[request responseString]];
	fishArray = [[NSMutableArray alloc] init];
	NSLog(@"response is %@",responseString);	
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
	for(NSDictionary *dic in array)
	{
		Fish *fish = [[Fish alloc] init];
		fish.name = [dic objectForKey:@"catch_name"];
		fish.lat = [[dic objectForKey:@"latitude"] doubleValue];
		fish.lng = [[dic objectForKey:@"longitude"] doubleValue];
		NSLog(@" Fish Name : %@ latitude -> %f",fish.name, fish.lat);
		NSLog(@" longitude -> %f ", fish.lng);
		[fishArray addObject:fish];
		
		ParkPlaceMark *placemarks = [[ParkPlaceMark alloc] initWithLat:fish.lat lon:fish.lng];
		placemarks.title = fish.name;
		[mapAnnotations addObject:placemarks];
		
		[fish release];
		//TODO:check this code
		[placemarks release];
	}
    [self.mapView addAnnotations:mapAnnotations];
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"This is the error %@", [error description]);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Unable to Fetch data fom server. \n Please try again in a while" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.mapView = nil;

	self.fishArray = nil;
	
}

/*- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	location=newLocation.coordinate;
	
	
	
	ParkPlaceMark *placemark=[[ParkPlaceMark alloc] initWithCoordinate:location];
	placemark.title = @"Current Location";
	[mapView addAnnotation:placemark];
	
	MKCoordinateRegion region =  {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = newLocation.coordinate;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES];
	
	
}

*/

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	
	NSLog(@"entered didfailwith error %d %@",[error code],[error localizedDescription]);
	
	if ([error code] == kCLErrorDenied){  
		
		[manager stopUpdatingLocation];
	}
	if ([error code] == kCLErrorLocationUnknown){ 
		
		for (int i = 0; i<5; i++) {
			[manager startUpdatingLocation];
		}
		
		[manager stopUpdatingLocation];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to detect current location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
	
}

#pragma mark -
#pragma mark MapKit methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;  //return nil to use default blue dot view
	MKPinAnnotationView *test=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"parkingloc"]autorelease];
	test.userInteractionEnabled=TRUE;
	test.canShowCallout = YES;
	test.animatesDrop = YES;
	//
	
	if ([[annotation title] isEqualToString:@"Current Location"] )
	{
		//currentLocationAnnotationImageView.image = [UIImage imageNamed:@"green.png"];
//		[test setPinColor:MKPinAnnotationColorPurple];
        test.enabled = NO;
	}
	else
	{
		//currentLocationAnnotationImageView.image = [UIImage imageNamed:@"pic.png"];
		[test setPinColor:MKPinAnnotationColorRed];
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		test.rightCalloutAccessoryView = rightButton;
	}
	

	
	return test;
	
    /*MKAnnotationView *currentLocationAnnotationImageView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"thisAnnotation"];
	 
	 currentLocationAnnotationImageView.canShowCallout = YES;
	 UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	 
	 currentLocationAnnotationImageView.rightCalloutAccessoryView = rightButton;
	 return currentLocationAnnotationImageView;*/
	
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
	ParkPlaceMark *selectedObject =[[ParkPlaceMark alloc] initWithCoordinate:view.annotation.coordinate];
	selectedObject.title = view.annotation.title;
	NSLog(@"Annotation title : %@", selectedObject.title);
	
	if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController-ipad" bundle:nil];
    else
    self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
	self.detailViewController.Latitude = view.annotation.coordinate.latitude;
	self.detailViewController.Longitude = view.annotation.coordinate.longitude;
	NSLog(@"longitude %lf", self.detailViewController.Longitude);
	NSLog(@"latitude %lf", view.annotation.coordinate.latitude);
	self.detailViewController.annotationDetails = selectedObject;
	[self.navigationController pushViewController:self.detailViewController animated:YES];

}

@end
