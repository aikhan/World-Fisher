    //
//  MyCatchViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 12/18/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "MyCatchViewController.h"
#import "Constants.h"
#import "AddNewCatchViewController.h"
#import "CatchDetailsViewController.h"

#import "CoreDataDAO.h"
#import "StandardInfoFeedModelObject.h"
#import "MyCatch.h"
#import "RichListCell.h"
#import "JSON.h"
#import "NetworkReachability.h"
#import "ASIHTTPRequest.h"
#import "NSArray+ReplaceNull.h"
#import "World_FisherAppDelegate.h"
#import "MBProgressHUD.h"
#import "SNAdsManager.h"
//#define kURL = WorldFisherMyCatchURL;


@implementation MyCatchViewController
@synthesize addNewCatchViewController;
-(id) init 
{
	if (self = [super init])
	{
		// it will initialise only
	}
	self.richListArray = nil;
    World_FisherAppDelegate *dele=(World_FisherAppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *uniqueIdentifier = dele.userID;
	
	self.urlString = [NSString stringWithFormat:@"%@ud_id=%@&catch_id=%d", WorldFisherMyCatchURL, uniqueIdentifier, [CoreDataDAO myCatchFetchTopRecordID]]; 
	self.urlString = [super.urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSLog(@"Top record id is equal to : %@", self.urlString);
	return self;
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewWillAppear:(BOOL)animated 
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
   // [self hideLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self loadDataFromCoreData];
	[super.myTableView reloadData];
//    [appDelegate stopLoadingView];
	NSLog(@"inside view willappear My Catch View Controller");
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
}

- (void)navigationController:(UINavigationController *)navigationController 
	  willShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewWillAppear:animated];
}


- (void)navigationController:(UINavigationController *)navigationController 
	   didShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewDidAppear:animated];
}


- (void)loadDataFromCoreData
{
   // [super showLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate showLoadingView];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSError *error;
	NSArray *coreDataMyCatchArray = [[NSArray alloc] initWithArray:[CoreDataDAO myCatchGetMyCatchListWithError:&error]];
	self.richListArray = [[NSMutableArray alloc] initWithCapacity:[coreDataMyCatchArray count]];
	if(coreDataMyCatchArray == nil)
	{
		NSLog(@"Database empty trying to fetch from server");
		
	}
	else {
		for(MyCatch *myCatch in coreDataMyCatchArray){
			NSAutoreleasePool * pool2 = [[NSAutoreleasePool alloc] init];
			StandardInfoFeedModelObject *standardFeedObject = [[StandardInfoFeedModelObject alloc] init];
			standardFeedObject.text = myCatch.catchDetails;
			standardFeedObject.modelObjectID = [NSString stringWithFormat:@"%d", [myCatch.mID intValue]];
			NSLog(@"Mike %@", standardFeedObject.modelObjectID);
			standardFeedObject.titleText = myCatch.catchName;
			standardFeedObject.rightText = [self convertTimeIntervalToString:myCatch.date];
			standardFeedObject.thumbnailImage = [myCatch.image valueForKey:@"thumbnailImage"];
			standardFeedObject.thumbnailURL = myCatch.imageURL;
			[self.richListArray addObject:standardFeedObject];
			[standardFeedObject release];
			[pool2 drain];
	}
//           MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.mode = MBProgressHUDModeAnnularDeterminate;
//            hud.labelText = @"Loading";
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//		[super showLoadingView];
		[super.myTableView reloadData];
//		[super hideLoadingView];
      //  [MBProgressHUD hideHUDForView:self.view animated:YES];
	}
    //[self hideLoadingView];
//    [appDelegate stopLoadingView];
	[coreDataMyCatchArray release];
	[pool drain];
}	


- (NSString *)convertTimeIntervalToString:(NSDate *)date{
	NSTimeInterval differenceInSeconds = [[NSDate date] timeIntervalSinceDate:date];
	//TODO: reimplement this code for seconds & minutes
	NSInteger differenceInDays = differenceInSeconds / 86400;
	if(differenceInDays == 0)
		return @"Today";
	else if(differenceInDays == 1)
		return @"Yesterday";
	else
		return [NSString stringWithFormat:@"%d days ago", differenceInDays];
}


- (void)loadView {
	[super loadView];
	super.url = [[NSURL alloc] initWithString:urlString];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCatch)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageDownloadCompleteInMyCatchObject:) name:@"MyCatchImageDownloadComplete" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageDownloadFailedInMyCatchObject:) name:@"MyCatchImageDownloadFailed" object:nil];
}


#pragma mark -
#pragma mark Add Catch
- (void)addCatch{
	NSLog(@"Hello add new catch");
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif

    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        self.addNewCatchViewController = [[AddNewCatchViewController alloc] initWithNibName:@"AddNewCatchViewController-ipad" bundle:Nil];
   else
	self.addNewCatchViewController = [[AddNewCatchViewController alloc] initWithNibName:@"AddNewCatchViewController" bundle:Nil];
	[self.navigationController pushViewController:addNewCatchViewController animated:YES];	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif

    
    CatchDetailsViewController *catchDetailsViewController;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        catchDetailsViewController = [[CatchDetailsViewController alloc] initWithNibName:@"CatchDetailViewController-ipad" bundle:Nil];
    else
	catchDetailsViewController = [[CatchDetailsViewController alloc] initWithNibName:@"CatchDetailsViewController" bundle:Nil];
	
	catchDetailsViewController.title = @"Details";
    catchDetailsViewController.TestArray = [[NSMutableArray alloc]init];
    [catchDetailsViewController.TestArray addObject:[richListArray objectAtIndex:indexPath.row]];
    
    
	catchDetailsViewController.fishNameLabel.text = [[richListArray objectAtIndex:indexPath.row] titleText];
	catchDetailsViewController.fishDetails.text = [[richListArray objectAtIndex:indexPath.row] text];
	catchDetailsViewController.fishImageView.image = [[richListArray objectAtIndex:indexPath.row] thumbnailImage];
	NSString *catchID = [NSString stringWithString:[[richListArray objectAtIndex:indexPath.row] modelObjectID]];
	NSLog(@"my catch selected id : %@", catchID);
	MyCatch *catch = [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:[catchID intValue]] withError:nil];
	if ([catch.image valueForKey:@"image"]) {
		catchDetailsViewController.highDefImage = [catch.image valueForKey:@"image"];
		NSLog(@"Image value is not nil");
	}
	else {
		NSLog(@"Nil in the database for catch image");
	}
	//catchDetailsViewController.highDefImage = [[richListArray objectAtIndex:indexPath.row] thumbnailImage]; 
	catchDetailsViewController.myCatchCurrentID = [[[richListArray objectAtIndex:indexPath.row] modelObjectID] integerValue];
	NSLog(@"CatchID %d", catchDetailsViewController.myCatchCurrentID);
    [self.navigationController pushViewController:catchDetailsViewController animated:YES];

	[catchDetailsViewController release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Connection Delegates
- (void)requestFinished:(ASIHTTPRequest *)request
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.labelText = @"Loading";
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//   
    //[self showLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate showLoadingView];
	if (responseString)
		[responseString release];
	responseString = [[NSString alloc] initWithString:[request responseString]] ;
	NSLog(@"response is %@",responseString);
    if ([responseString isEqualToString:@"[]"]) {
 //       [MBProgressHUD hideHUDForView:self.view animated:YES];
		//[self hideLoadingView];
      //  [appDelegate stopLoadingView];
        return;
	} 
    NSLog(@"responsString %@", responseString);
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
	super.dataArray = [[NSMutableArray alloc] init];
	for(NSDictionary *dic in array)
	{
		MyCatch *myCatch = [CoreDataDAO myCatchAddNewCatchWithID:[NSNumber numberWithInt:[[dic valueForKey:@"catch_id"] integerValue]]];
		myCatch.catchName = [dic objectForKey:@"catch_name"];
		NSLog(@"catchidisequal %@", myCatch.mID);
		myCatch.catchDetails = [dic objectForKey:@"catch_details"];
		NSLog(@"%@", myCatch.catchDetails);
		myCatch.latitude = [dic objectForKey:@"latitude"];
		myCatch.longitute = [dic objectForKey:@"longitude"];		
		NSString *imageURL = [dic objectForKey:@"image"];
        NSString *fbImage = [dic objectForKey:@"fb_image"];
        fbImage = [fbImage stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        myCatch.fbimageURL = fbImage;
		imageURL = [imageURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"imgURL = %@", imageURL);
		NSRange subStrRange = [imageURL rangeOfString:@"http:"];
		BOOL myBool =  (subStrRange.location != NSNotFound);
		if(!myBool)
		{
			imageURL = [NSString stringWithFormat:@"http://%@", imageURL];
			NSLog(@"NSLOGGED URL = %@", imageURL);
		}
		myCatch.imageURL = imageURL;
		[myCatch downloadImage];
		[super.dataArray addObject:myCatch];
		NSLog(@"Array Count = %d", [super.dataArray count]);
		NSLog(@"\n\n\n\n\n\n\n\n");
	}	
	NSLog(@"Caveman debugging");
//    [appDelegate stopLoadingView];
}
#pragma mark -
#pragma mark UINotifications methods

- (void)imageDownloadCompleteInMyCatchObject:(NSNotification *)notification
{
    
	//[self showLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
 //   [appDelegate showLoadingView];
	NSLog(@"My Catch Added successfully");
	[CoreDataDAO saveData];
	[myTableView reloadData];
	static int count = 0;
	count++;
	if([super.dataArray count] == count){
		[self performSelectorOnMainThread:@selector(loadDataFromCoreData) withObject:nil waitUntilDone:NO];
		NSLog(@"Reloading table data from coredata");
        World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
       // [appDelegate showLoadingView];
		[appDelegate performSelector:@selector(stopLoadingView)
				   withObject:nil
				   afterDelay:0.35]; 
	}
}

- (void)imageDownloadFailedInMyCatchObject:(NSNotification *)notification
{
	StandardInfoFeedModelObject *modelObject = [notification object];
	NSUInteger rowNumber = [richListArray indexOfObject:modelObject];
	RichListCell *cell = (RichListCell *)[myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber inSection:0]];
	[cell updateCell];
	NSLog(@"Image download has failed");
}
- (void)dealloc 
{
	[super dealloc];
	[richListArray release];
	[addNewCatchViewController release];
}

@end