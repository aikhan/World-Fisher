//
//  StandardInfoFeedViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 12/26/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "StandardInfoFeedViewController.h"
#import "ASIHTTPRequest.h"
#import "NetworkReachability.h"
#import "RefreshTableViewHeader.h"
#import "JSON.h"
#import "DeviceMetricsHelper.h"
#import "StandardInfoFeedModelObject.h"
#import "NSArray+ReplaceNull.h"
#import "Constants.h"
#import "MyCatch.h"
#import "CoreDataDAO.h"
#import "RichListCell.h"
#import "World_FisherAppDelegate.h"
#import "MBProgressHUD.h"

#define RetryYesNo 1



@implementation StandardInfoFeedViewController
@synthesize myTableView;
@synthesize responseString;
@synthesize reloading=_reloading;
@synthesize url;
@synthesize richListArray;
@synthesize downloadQueue;
@synthesize imageView;
@synthesize dataArray;
@synthesize urlString;

#ifdef UNIT_TESTING
@synthesize requestFinished, requestFailed,rowCount,networkAvailable;
#endif
#pragma mark -
#pragma mark Init method

-(id) init 
{
	if ((self = [super init]))
	{
		// it will initialise only
	}
	self.richListArray = nil;
	self.urlString = @"";
	return self;
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
	NSLog(@"View will appear standard info feed");
    [self.myTableView deselectRowAtIndexPath:[myTableView indexPathForSelectedRow] animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
        
	//self.myTableView.rowHeight = 76.0;
	//Customizing Navigation Controller
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.alpha = 0.75;
	[self performSelector:@selector(showNavigationBar) withObject:nil afterDelay:1.0];
	self.imageView.image = [UIImage imageNamed:@"staybg@2x.png"];
	[self.view insertSubview:imageView aboveSubview:self.view];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"staybg@2x.png"]]];
	////////////////////
	
	//Customizing TableView
	myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	myTableView.backgroundColor = [UIColor clearColor];
	UIView *containerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)] autorelease];
	self.myTableView.tableHeaderView = containerView;
    self.myTableView.tableFooterView = containerView;
	[self loadDataFromCoreData];
	[self performSelectorOnMainThread:@selector(loadDataFromCoreData) withObject:nil waitUntilDone:NO];
	//[self showLoadingView];
     World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate showLoadingView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

	[self reloadFeed];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
	//[self hideLoadingView];
	
}
- (void)showNavigationBar{
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return NO;
}
- (void)viewDidUnload 
{
	//TODO make other objects nil here
	
	imageView = nil;
}
- (void)loadView {
	[super loadView];
	self.url = [[NSURL alloc] initWithString:urlString];
	
	self.myTableView.rowHeight = 76.0;
	myTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	myTableView.delegate = self;
	myTableView.dataSource = self;
	[self.view addSubview:myTableView];
	

	downloadQueue = [[NSOperationQueue alloc] init];
	
    self.myTableView.rowHeight = 76.0;
    NSIndexPath* selection = [self.myTableView indexPathForSelectedRow];
    if (selection)
    {
        [self.myTableView deselectRowAtIndexPath:selection animated:YES];
    }
	
}

/*- (void)loadDataFromCoreData{
		
}
 */
#pragma mark -
#pragma mark Reload methods


- (void)reloadFeed
{
	
	//[self showLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate showLoadingView];
#ifdef UNIT_TESTING
	networkAvailable = YES;
	
#endif	
	// Check if the remote server is available
	NetworkReachability *reachManager = [NetworkReachability sharedReachability];
	[reachManager setHostName:@"www.google.com"];
	NetworkStatus remoteHostStatus = [reachManager remoteHostStatus];
	if (remoteHostStatus == NotReachable)
	{
#ifdef UNIT_TESTING
		networkAvailable=NO;
#endif	
		
		[[NSNotificationCenter defaultCenter] removeObserver:self];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
														message:@"Network is not reachable! \nRetry?" 
													   delegate:self 
											  cancelButtonTitle:@"No" 
											  otherButtonTitles:@"Yes", nil];
        alert.tag = RetryYesNo;
		[alert show];
		[alert release];
		//[self.myTableView reloadData];
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
	[self fetchURLData];
}
#pragma mark -
#pragma mark Connection Delegates

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Implement it child classes");
}

- (void)fetchURLData{
	
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	[request setDelegate:self];
	
	NSOperationQueue *queue = self.downloadQueue;
	[queue addOperation:request];
	
	[request release];
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
#ifdef UNIT_TESTING
	
	self.requestFailed = YES;
	
#endif
	
	//[self hideLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate stopLoadingView];
	NSError *error = [request error];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:[NSString stringWithFormat:@"The connection failed with this error: %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	
	
	if ([self.richListArray count]>0) {
		
		UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil 
														 message:@"Network is not reachable!\n Your last saved data will display here." 
														delegate:nil 
											   cancelButtonTitle:@"OK" 
											   otherButtonTitles:nil];
		
		[alert1 show];
		[alert1 release];
		[self.myTableView reloadData];
	}
	else {
		UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:nil 
														 message:@"No Saved Data Found." 
														delegate:nil 
											   cancelButtonTitle:@"OK" 
											   otherButtonTitles:nil];
		[alert2 show];
		[alert2 release];
	}
	
	[alert release];
	
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger count = [richListArray count];
	return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"RichListCell";
	
	RichListCell *cell = (RichListCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		cell =  [[[RichListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
	}
	cell.backgroundView = [[[UIImageView alloc] init] autorelease];
	cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
	UIImage *rowBackground;
	UIImage *selectionBackground;
	rowBackground = [UIImage imageNamed:@"4.png"];
	selectionBackground = [UIImage imageNamed:@"highlight.png"];
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	StandardInfoFeedModelObject *modelObject = (StandardInfoFeedModelObject *)[richListArray objectAtIndex:indexPath.row];
	cell.modelObject = modelObject;
	[cell updateCell];
	cell.alpha = 0.0f;
	
#ifdef UNIT_TESTING
	rowCount++;	
# endif	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSLog(@"Did select row");
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
/*- (void)showLoadingView
{
    if (!loadingView)
    {
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight)];
        loadingView.opaque = NO;
        loadingView.backgroundColor = [UIColor darkGrayColor];
        loadingView.alpha = 0.5;
		
        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spinningWheel startAnimating];
        spinningWheel.center = myTableView.center;
        [loadingView addSubview:spinningWheel];
        [spinningWheel release];
    }
    
    [self.view addSubview:loadingView];
}

- (void)hideLoadingView
{
    [loadingView removeFromSuperview];
}
*/
- (void)dealloc 
{
	
	[url release];
	[urlString release];
	[loadingView release];
	[myTableView release];
	[responseString release];
	[richListArray release];
	[dataArray release];
	[downloadQueue release];
	[imageView release];
	
	
	[super dealloc];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (alertView.tag == RetryYesNo) {
        if (buttonIndex == 0) {
            NSLog(@"No");
            [appDelegate stopLoadingView];
            [self loadDataFromCoreData];
            
        }
        else{
            NSLog(@"Yes");
        [appDelegate stopLoadingView];
        [self reloadFeed];
        }
    }
    
}

@end
