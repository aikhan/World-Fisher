//
//  MyCatchDraftViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 1/10/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import "MyCatchDraftViewController.h"
#import "CoreDataDAO.h"
#import "StandardInfoFeedModelObject.h"
#import "RichListCell.h"
#import "Temp.h"
#import "CatchDetailsViewController.h"
#import "AddNewCatchViewController.h"
#import "SNAdsManager.h"

@implementation MyCatchDraftViewController
@synthesize myTableView, richListArray;

- (void)dealloc {
    [super dealloc];
	[richListArray release];
	[myTableView release];
}

- (void)loadDraftDataFromCoreData{
	NSArray	*coreDataDraftArray = [[NSArray alloc] initWithArray:[CoreDataDAO tempGetMyCatchListWithError:nil]];
	self.richListArray = [[NSMutableArray alloc] initWithCapacity:[coreDataDraftArray count]];
	
	for(Temp *temp in coreDataDraftArray){
		StandardInfoFeedModelObject *standardModelObject = [[StandardInfoFeedModelObject alloc] init];
		standardModelObject.modelObjectID = [NSString stringWithFormat:@"%d", [temp.mID intValue]];
		standardModelObject.text = temp.catchDetails;
		standardModelObject.thumbnailImage = [temp.image valueForKey:@"thumbnailImage"];
		standardModelObject.titleText = temp.catchName;
		[self.richListArray addObject:standardModelObject];
		[standardModelObject release];
	}
	[coreDataDraftArray release];
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

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.myTableView deselectRowAtIndexPath:[myTableView indexPathForSelectedRow] animated:YES];


}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor = [UIColor blueColor];
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.alpha = 0.75;
	self.myTableView.separatorStyle = [UIColor whiteColor];
    
	self.myTableView.backgroundColor = [UIColor clearColor];
	[self loadDraftDataFromCoreData];
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



#pragma mark Table View Methods


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
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75f];
	[cell updateCell];
	cell.alpha = 0.0f;
	
	[UIView commitAnimations];
	
	
#ifdef UNIT_TESTING
	rowCount++;	
# endif	
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif

    AddNewCatchViewController *addNewCatchViewController;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
       addNewCatchViewController = [[AddNewCatchViewController alloc] initWithNibName:@"AddNewCatchViewController-ipad" bundle:Nil];
    else
	addNewCatchViewController = [[AddNewCatchViewController alloc] initWithNibName:@"AddNewCatchViewController" bundle:Nil];
		
    addNewCatchViewController.TestArray = [[NSMutableArray alloc]init];
    [addNewCatchViewController.TestArray addObject:[richListArray objectAtIndex:indexPath.row]];//richListArray;
    
    addNewCatchViewController.title = @"Details";
   
//	addNewCatchViewController.textField.text = [[richListArray objectAtIndex:indexPath.row] titleText];
//	addNewCatchViewController.textView.text = [[richListArray objectAtIndex:indexPath.row] text];
//	[addNewCatchViewController.imageButton setImage:[[richListArray objectAtIndex:indexPath.row] thumbnailImage] forState:UIControlStateNormal];
//	addNewCatchViewController.highDefImage = [[richListArray objectAtIndex:indexPath.row] thumbnailImage];
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber * myNumber = [f numberFromString:[[richListArray objectAtIndex:indexPath.row] modelObjectID]];
	[f release];
	
	NSLog(@"id of tapped temp %@", [[richListArray objectAtIndex:indexPath.row] modelObjectID]);
	
	Temp *temp = [CoreDataDAO tempFetchMyCatchWithID:myNumber withError:nil];
	addNewCatchViewController.latitude = [temp.latitude doubleValue];
	addNewCatchViewController.longitude = [temp.longititue doubleValue];
	addNewCatchViewController.saveDraftButton.hidden = YES;
	addNewCatchViewController.navigationItem.rightBarButtonItem  = nil;
   
	if ([temp.image valueForKey:@"image"]) {
		NSLog(@"got image data for temp from core data");
		addNewCatchViewController.highDefImage = [temp.image valueForKey:@"image"];
		
	}
	else if([temp.image valueForKey:@"thumbnailImage"]) {
		NSLog(@"thumbnail present");
		addNewCatchViewController.highDefImage = [temp.image valueForKey:@"thumbnailImage"];
	}
	else{
		NSLog(@"picked up image from last view neither thumbnail or image present in coredata");
		addNewCatchViewController.highDefImage = [[richListArray objectAtIndex:indexPath.row] thumbnailImage];
	}
    
    NSLog(@"%@",addNewCatchViewController.highDefImage);
	
	addNewCatchViewController.isTemp = YES;
	addNewCatchViewController.tempID = temp.mID;
    [self.navigationController pushViewController:addNewCatchViewController animated:YES];

	
	[addNewCatchViewController release];
	
	

}

@end
