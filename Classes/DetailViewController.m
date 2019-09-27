//
//  DetailViewController.m
//  MapApp
//
//  Created by Anam on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Fish.h"
#import "FishDetailImageController.h"
#import "ASIHTTPRequest.h"
#import "NetworkReachability.h"
#import "NSArray+ReplaceNull.h"
#import "JSON.h"
#import "MBProgressHUD.h"
@implementation DetailViewController
@synthesize fishDescription,titleLabel,fishImage,fishImageView;
@synthesize latitudeValue,newURL;
@synthesize annotationDetails;
@synthesize Latitude;
@synthesize Longitude;
@synthesize imageScroll,description;

@synthesize url, downloadQueue, imageURLString, responseString, downloadedImage;
//@"http://www.world-fisher.com/fish/get_mycatch?lng=abc&lat=abc"
//http://www.world-fisher.com/fish/get_mycatch.php?lng=45.124588&lat=78.256485
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
	self.navigationController.title = annotationDetails.title;
	//titleLabel.text = annotationDetails.title;
	fishDescription.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient-black-grey.png"]]; 
	
	NSLog(@"Annotation title %@", annotationDetails.title);
	NSString *urlString = [NSString stringWithFormat:
						   @"http://www.semanticdevlab.com/world_hunter/admin/get_mycatch.php?lng=%f&lat=%f", self.Longitude, self.Latitude];
	NSLog(@"urlstring : %@", urlString);
	self.url = [[NSURL alloc] initWithString:urlString];
	downloadQueue = [[NSOperationQueue alloc] init];
	[self loadFishData];
	self.fishImageView.hidden = YES;
	
}
-(void)viewWillAppear:(BOOL)animated{
[self loadFishData];

}
-(void)viewDidAppear:(BOOL)animated{

    [self loadFishData];

}
- (void)loadFishData{
	
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
	NSLog(@"inside load Fish data");
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
//	if (responseString)
//		[responseString release];
	self.responseString = [[NSString alloc] initWithString:[request responseString]] ;
	NSLog(@"response is %@",responseString);	
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
	for(NSDictionary *dic in array)
	{
		fishDescription.text = [dic objectForKey:@"catch_details"];
		self.imageURLString = [dic objectForKey:@"image"];
		NSLog(@"%@ space", self.imageURLString);
		self.imageURLString = [self.imageURLString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSRange subStrRange = [imageURLString rangeOfString:@"http:"];
		BOOL myBool =  (subStrRange.location != NSNotFound);
		if(!myBool)
		{
			self.imageURLString = [NSString stringWithFormat:@"http://%@", self.imageURLString];
			NSLog(@"NSLOGGED URL = %@", self.imageURLString);
		}
		[self downloadImage];
		[self showLoadingView];
		
       // [self.fishImageView addSubview:scrollingWheel];
	}
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"This is the error %@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection time out \n Server may be very busy. \nPlease try again in a while" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)photoTapped {
    FishDetailImageController *detailViewController;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
         detailViewController=[[FishDetailImageController alloc] initWithNibName:@"FishDetailImageController-ipad" bundle:nil];
    else
    detailViewController=[[FishDetailImageController alloc] initWithNibName:@"FishDetailImageController" bundle:nil];
	detailViewController.image = self.downloadedImage;
	 [self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
	
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
}


- (void)dealloc {
    [super dealloc];
	[downloadQueue release];
	[url release];
	[imageURLString release];
	[responseString release];
	[downloadedImage release];
}
#pragma mark -
#pragma mark Image Downloader

- (void)downloadImage
{
	if (downloader == nil)
	{
		downloader = [[ImageDownloader alloc] init];
		downloader.delegate = self;
	}
	
	downloader.imageURLString = self.imageURLString;
	//downloader.imageHeight = 48;
	
	[downloader startDownload];
}


- (void)imageDownloader:(ImageDownloader *)downloader didDownloadImage:(UIImage *)image
{
	//self.image = image;
	if (image == nil) {
		NSLog(@"image is nil WTF");
	}
	NSLog(@"Hello inside didDownloadImage");
	[self.fishImageView setImage:image forState:UIControlStateNormal];
    [self.fishImageView setImage:image forState:UIControlStateSelected];
    [self.fishImageView setImage:image forState:UIControlStateHighlighted];
	self.fishImageView.hidden = NO;
	self.downloadedImage = image;
	[self hideLoadingView];
}

- (void)imageDownloader:(ImageDownloader *)downloader didFailWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fish Image cannot be downloaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	[self hideLoadingView];

}

#pragma mark -
#pragma mark Loading View

- (void)showLoadingView
{
    if (!loadingView)
    {
		//[self.navigationController setNavigationBarHidden:YES animated:YES];
        loadingView = [[UIView alloc] initWithFrame:self.fishImageView.frame];
        loadingView.opaque = NO;
        loadingView.backgroundColor = [UIColor darkGrayColor];
        loadingView.alpha = 0.5;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = @"Loading";
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		
//        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [spinningWheel startAnimating];
//        spinningWheel.center = CGPointMake(130, 50);
//        [loadingView addSubview:spinningWheel];
//        [spinningWheel release];
    }
    
  //  [self.view addSubview:loadingView];
}

- (void)hideLoadingView
{
	//[self.navigationController setNavigationBarHidden:NO animated:YES];
   // [loadingView removeFromSuperview];
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
