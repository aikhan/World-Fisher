//
//  MapAppViewController.m
//  MapApp
//
//  Created by Anam on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapAppViewController.h"
#import "ParkPlaceMark.h"
#import "DetailViewController.h"
#import "DeviceMetricsHelper.h"
#import "JSON.h"

#define GET_CATCH_FISH_URL @"http://www.semanticdevlab.com/world_hunter/admin/getxml.php"
//#define UPDATE_PICKUP_LINE_URL @"http://www.semanticnotion.com/pickuplines/update_service.php"

@implementation MapAppViewController
@synthesize fishes,afish,mapAnnotations,locationManager;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	mapView=[[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	//mapView.showsUserLocation=TRUE;
	mapView.mapType = MKMapTypeHybrid;
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
	
	
	
	mapView.delegate=self;
	[self.view insertSubview:mapView atIndex:0];
	self.mapAnnotations = [[[NSMutableArray alloc]init]autorelease];
	afish = [Fish sharedModel];
		
	[self parseUrl:GET_CATCH_FISH_URL];

	
	locationManager=[[CLLocationManager alloc] init];
	
	if ([CLLocationManager locationServicesEnabled]) {
		locationManager.delegate=self;
		locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
		
		[locationManager startUpdatingLocation];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Location services disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	
	
	
		
}


							
- (void)parseUrl:(NSString *)url
{
	
	NSURL *xmlUrl = [NSURL URLWithString:url];
	[self beginParsing:xmlUrl];
}

- (void)beginParsing:(NSURL *)xmlUrl
{
	
	NSURLRequest *request = [NSURLRequest requestWithURL:xmlUrl];
	// clear existing connection if there is one
	if (connectionInProgress) {
		[connectionInProgress cancel];
		[connectionInProgress release];
	}
	
	[xmlData release];
	xmlData = [[NSMutableData alloc] init];
	
	// asynchronous connection
	connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}


							
#pragma mark -
#pragma mark NSXMLParser Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[xmlData appendData:data];
	
	
	
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(catchFishParser)
	[catchFishParser release];
    catchFishParser = [[[NSXMLParser alloc] initWithData:xmlData]autorelease];
    [catchFishParser setDelegate:self];
	[catchFishParser setShouldResolveExternalEntities:NO];
	[catchFishParser parse];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
		
	[connectionInProgress release];
	connectionInProgress = nil;
	
	[xmlData release];
	xmlData = nil;
	
	NSLog(@"connection failed: %@", [error localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	
	
	if([elementName isEqualToString:@"markers"]) {
		//Initialize the array.
			fishes = [[NSMutableArray alloc] init];
	}
	else if([elementName isEqualToString:@"marker"]) {
		
				
		//Initialize the fish.
		afish = [[Fish alloc] init];
		
		
	}
	
	
	
}
							
							
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
		if(!currentElementValue)
			currentElementValue = [[NSMutableString alloc] initWithString:string];
		else
			[currentElementValue appendString:string];
		
		
}
							
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	if([elementName isEqualToString:@"markers"])
		return;
	
	if([elementName isEqualToString:@"marker"]) {
		
		[fishes addObject:afish];
		
		double locationLatitude =  afish.lat;
		double locationLongitude = afish.lng;
		ParkPlaceMark *placemarks = [[ParkPlaceMark alloc] initWithLat:locationLatitude lon:locationLongitude];
		placemarks.title = afish.name;
		
		[mapAnnotations addObject:placemarks];
		
       [mapView addAnnotations:mapAnnotations];
		
		[afish release];
		afish = nil;
	}
	else
		[afish setValue:currentElementValue forKey:elementName];
	[currentElementValue release];
	currentElementValue = nil;
}
					
							


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	
	MKPinAnnotationView *test=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"parkingloc"]autorelease];
	test.userInteractionEnabled=TRUE;
	 test.canShowCallout = YES;
	// test.animatesDrop = YES;
	//
	
	if ([[annotation title] isEqualToString:@"Current Location"] )
	{
		//currentLocationAnnotationImageView.image = [UIImage imageNamed:@"green.png"];
		[test setPinColor:MKPinAnnotationColorPurple];
	}
	else
	{
		//currentLocationAnnotationImageView.image = [UIImage imageNamed:@"pic.png"];
		[test setPinColor:MKPinAnnotationColorRed];
	}
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
	test.rightCalloutAccessoryView = rightButton;
	
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
	
	DetailViewController *detailViewController;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        detailViewController=[[DetailViewController alloc] initWithNibName:@"DetailViewController-ipad" bundle:nil];
    else
    detailViewController=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
	detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
	
	detailViewController.annotationDetails = selectedObject;
	// [self.navigationController pushViewController:detailViewController animated:YES];
	[self presentModalViewController:detailViewController animated:YES];
	[detailViewController release];
	
	
    //do your show details thing here...
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	location=newLocation.coordinate;
	
	
	
	ParkPlaceMark *placemark=[[ParkPlaceMark alloc] initWithCoordinate:location];
	placemark.title = @"Current Location";
	[mapView addAnnotation:placemark];
	
	MKCoordinateRegion region =  {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES];
	
	locationManager.delegate = nil;
	[locationManager stopUpdatingLocation];
		
}



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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
