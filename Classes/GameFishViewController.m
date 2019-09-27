//
//  GameFishViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 12/22/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "GameFishViewController.h"
#import "GameFishDetailViewController.h"
#import "Constants.h"
#import "AddNewCatchViewController.h"
#import "CatchDetailsViewController.h"
#import "GameFish.h"
#import "CoreDataDAO.h"
#import "FishObjectModel.h"
#import "MyCatch.h"
#import "RichListCell.h"
#import "JSON.h"
#import "NetworkReachability.h"
#import "ASIHTTPRequest.h"
#import "NSArray+ReplaceNull.h"
#import "World_FisherAppDelegate.h"
#import "MBProgressHUD.h"
#import "SNAdsManager.h"


@implementation GameFishViewController

@synthesize myInfoFeedArray;


-(id) init
{
	if ((self = [super init]))
	{
		// it will initialise only
	}
	
    //	self.urlString = [NSString stringWithFormat:@"%@%d", WorldFisherFishURL, [CoreDataDAO fishFetchTopRecordID]];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastupdate;
    if (standardUserDefaults) {
        lastupdate = [standardUserDefaults objectForKey:@"lastupdate"];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-d HH:mm:ss"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormat setTimeZone:gmt];
    NSString *dateString = [dateFormat stringFromDate:lastupdate];
    [dateFormat release];
    dateString = [dateString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSLog(@"Current day time is %@", dateString);
    self.urlString = [NSString stringWithFormat:@"%@%@", WorldFisherFishURL, dateString];
    //  self.urlString = @"http://www.world-fisher.com/fish/fish-json.php?id=2011-03-18%2000:25:05";
	return self;
}

#pragma mark -
#pragma mark UIViewController methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	NSLog(@"view will appear GameFish View Controller");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
	NSLog(@"%@", self.urlString);
    
}


- (void)loadDataFromCoreData
{
	NSArray *coreDataFishArray = [[NSArray alloc] initWithArray:[CoreDataDAO fishGetFishListWithError:nil]];
	self.myInfoFeedArray = [[NSMutableArray alloc] initWithCapacity:[coreDataFishArray count]];
	if(coreDataFishArray == nil)
	{
		NSLog(@"Database empty trying to fetch from server");
        World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
        // [appDelegate showLoadingView];
        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        hud.mode = MBProgressHUDModeAnnularDeterminate;
        //        hud.labelText = @"Loading";
        //
        //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	}
	else {
        
		for(GameFish *fish in coreDataFishArray){
            GameFish *copyFish = fish;
            [copyFish retain];
            FishObjectModel *standardFeedObject = [[FishObjectModel alloc] init];
			standardFeedObject.text = fish.identification;
			standardFeedObject.titleText = fish.name;
			standardFeedObject.rightText = @"";
			int x = [fish.mID intValue];
			standardFeedObject.modelObjectID = [NSString stringWithFormat:@"%d", x];
			//standardFeedObject.thumbnailImage = [fish.image valueForKey:@"image"];
			standardFeedObject.thumbnailImage = [fish.image valueForKey:@"thumbnailImage"];
			if (standardFeedObject.thumbnailImage == nil) {
				NSLog(@"Complain %@", fish.thumbnailURL);
                [copyFish downloadImage];
			}
			standardFeedObject.thumbnailURL = fish.thumbnailURL;
			standardFeedObject.scientificName = fish.scientificName;
			standardFeedObject.familyName = fish.family;
			standardFeedObject.fishRange = fish.range;
			standardFeedObject.habitat = fish.habitat;
			standardFeedObject.adultSize = fish.adultSize;
			standardFeedObject.identification = fish.identification;
			standardFeedObject.howToFish = fish.howToFish;
            
			[self.myInfoFeedArray addObject:standardFeedObject];
			[standardFeedObject release];
		}
		self.richListArray = self.myInfoFeedArray;
		[self.myTableView reloadData];
	}
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //	[self hideLoadingView];
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    // [appDelegate stopLoadingView];
	[coreDataFishArray release];
}

- (void)loadView {
	[super loadView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageDownloadCompleteInFishObject:) name:@"FishImageDownloadComplete" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageDownloadFailedInFishObject:) name:@"FishImageDownloadFailed" object:nil];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.ScamsterFree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // [appDelegate showLoadingView];
	GameFishDetailViewController *gameFishDetailViewController;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
        gameFishDetailViewController= [[GameFishDetailViewController alloc] initWithNibName:@"GameFishDetailViewController-ipad" bundle:nil];
    } else{
        gameFishDetailViewController= [[GameFishDetailViewController alloc] initWithNibName:@"GameFishDetailViewController" bundle:nil];
    }
    gameFishDetailViewController.Temp = [[NSMutableArray alloc]init];
    [gameFishDetailViewController.Temp addObject:[richListArray objectAtIndex:indexPath.row]];//richListArray;
	gameFishDetailViewController.title = @"Fish Details";
	gameFishDetailViewController.commonNameLabel.text = [[richListArray objectAtIndex:indexPath.row] titleText];
	gameFishDetailViewController.scientificNameLabel.text = [[richListArray objectAtIndex:indexPath.row] scientificName];
	gameFishDetailViewController.familyLabel.text = [[richListArray objectAtIndex:indexPath.row] familyName];
	gameFishDetailViewController.rangeLabel.text = [[richListArray objectAtIndex:indexPath.row] fishRange];
	gameFishDetailViewController.habitatLabel.text = [[richListArray objectAtIndex:indexPath.row] habitat];
	gameFishDetailViewController.adultSizeLabel.text = [[richListArray objectAtIndex:indexPath.row] adultSize];
	gameFishDetailViewController.identificationTextView.text = [[richListArray objectAtIndex:indexPath.row] identification];
	gameFishDetailViewController.howToFishTextView.text = [[richListArray objectAtIndex:indexPath.row] howToFish];
	
	
//	int mID = [[[richListArray objectAtIndex:indexPath.row] modelObjectID] intValue];
//	
//	NSLog(@"Fish id = %d", mID);
//	NSNumber *number = [NSNumber numberWithInt:mID];
//	GameFish *fish;
//	fish = [CoreDataDAO fishFetchFishWithID:number withError:nil];
//	UIImage *image = [fish.image valueForKey:@"image"];
//    
//	NSLog(@"image URL from core data : %@", fish.imageURL);
//	if (!image) {
//        
//		image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fish.imageURL]]];
//        [fish.image setValue:image forKey:@"image"];
//		//[CoreDataDAO fishAddImage:image ForGameFish:fish];
//		[CoreDataDAO saveData];
//        
//	}
//	else {
//		image = [fish.image valueForKey:@"image"];
//	}
    
    
//	[gameFishDetailViewController.bigFishButton setImage:image forState:UIControlStateNormal];
//    [gameFishDetailViewController.bigFishButton setImage:image forState:UIControlStateSelected];
    
	NSLog(@"Common Name : %@", [[richListArray objectAtIndex:indexPath.row] titleText]);
	NSLog(@"Scientific Name : %@", [[richListArray objectAtIndex:indexPath.row] scientificName]);
	NSLog(@"Family Name : %@", [[richListArray objectAtIndex:indexPath.row] familyName]);
	NSLog(@"Fish Range : %@", [[richListArray objectAtIndex:indexPath.row] fishRange]);
	NSLog(@"Habitat : %@", [[richListArray objectAtIndex:indexPath.row] habitat]);
	NSLog(@"Adult Size : %@", [[richListArray objectAtIndex:indexPath.row] adultSize]);
	NSLog(@"Identification : %@", [[richListArray objectAtIndex:indexPath.row] identification]);
	NSLog(@"How to Fish : %@", [[richListArray objectAtIndex:indexPath.row] howToFish]);
    //	[gameFishDetailViewController release];
    [appDelegate stopLoadingView];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.navigationController pushViewController:gameFishDetailViewController animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark -
#pragma mark Connection Delegates


- (void)requestFinished:(ASIHTTPRequest *)request
{
	if (responseString)
		[responseString release];
	responseString = [[NSString alloc] initWithString:[request responseString]] ;
	NSLog(@"response %@",responseString);
	if ([responseString isEqualToString:@"[]"] || [responseString isEqualToString:@"false"]) {
        [self loadDataFromCoreData];
        World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate stopLoadingView];
        NSLog(@"Inside return");
        return;
	}
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
	dataArray = [[NSMutableArray alloc] init];
    [CoreDataDAO fishRemoveAllFish];
    NSLog(@"Delete all previous fish");
    [CoreDataDAO saveData];
	for(NSDictionary *dic in array)
	{
		GameFish *myFish = [CoreDataDAO fishAddNewFishWithID:[NSNumber numberWithInt:[[dic valueForKey:@"fish_id"] integerValue]]];
		NSLog(@"fish id when downloading %d",[myFish.mID intValue]);
		myFish.name = [dic objectForKey:@"common_name"];
		//myCatch.date = [dic objectForKey:@"created_at"];
		myFish.identification = [dic objectForKey:@"identification"];
		myFish.scientificName = [dic objectForKey:@"scientific_name"];
		myFish.family = [dic objectForKey:@"family"];
		myFish.range = [dic objectForKey:@"range"];
		myFish.habitat = [dic objectForKey:@"habitate"];
		myFish.adultSize = [dic objectForKey:@"adult_size"];
		myFish.howToFish = [dic objectForKey:@"how_to_fish"];
		myFish.thumbnailURL = [self makeURLReady:[dic objectForKey:@"thumbnail"]];
		NSLog(@"thumbnail URL %@", myFish.thumbnailURL);
		myFish.imageURL = [self makeURLReady:[dic objectForKey:@"image"]];
		[myFish downloadImage];
		[self.dataArray addObject:myFish];
		NSLog(@"Array Count = %d", [self.dataArray count]);
		NSLog(@"\n\n\n\n\n\n\n\n");
        
        
	}
	
 	if (self.dataArray != nil) {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) {
            [standardUserDefaults setObject:[NSDate date] forKey:@"lastupdate"];
            [standardUserDefaults synchronize];
        }
    }
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    // [appDelegate stopLoadingView];
    [appDelegate performSelector:@selector(stopLoadingView) withObject:nil afterDelay:5.5];
    NSLog(@"Caveman debugging");
}

- (NSString *)makeURLReady:(NSString *)oldURL{
	oldURL = [oldURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSRange subStrRange = [oldURL rangeOfString:@"http:"];
	BOOL myBool =  (subStrRange.location != NSNotFound);
	if(!myBool)
	{
		oldURL = [NSString stringWithFormat:@"http://%@", oldURL];
		NSLog(@"NSLOGGED URL = %@", oldURL);
	}
	return oldURL;
}
#pragma mark -
#pragma mark UINotifications methods

- (void)imageDownloadCompleteInFishObject:(NSNotification *)notification
{
	
	NSLog(@"My Fish Added successfully");
	[CoreDataDAO saveData];
	static int count = 0;
	count++;
    NSLog(@"FOr the love of Fish print something\n Count is : %d", count);
    NSLog(@"dataarray count =  %d", [super.dataArray count]);
	if([super.dataArray count] == count){
        NSLog(@"dataarray count =  %d", [super.dataArray count]);
        [self loadDataFromCoreData];
		NSLog(@"Reloading table data from coredata");
        [myTableView reloadData];
        World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
		[appDelegate performSelector:@selector(stopLoadingView)
                          withObject:nil
                          afterDelay:0.35];
	}
	
}

- (void)imageDownloadFailedInFishObject:(NSNotification *)notification
{
	StandardInfoFeedModelObject *modelObject = [notification object];
	NSUInteger rowNumber = [richListArray indexOfObject:modelObject];
	RichListCell *cell = (RichListCell *)[myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber inSection:0]];
	[cell updateCell];
}

- (void)dealloc 
{
	[super dealloc];
	[myInfoFeedArray release];
}

@end
