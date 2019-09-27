//
//  CreditViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 2/17/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import "CreditViewController.h"
#import "SNAdsManager.h"
#import "MBProgressHUD.h"
@implementation CreditViewController
@synthesize textView, creditsString;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.navigationItem.title = @"Credits";
	
	[self performSelector:@selector(fetchCredits) withObject:nil afterDelay:0.01];
	[self performSelector:@selector(setTextViewText) withObject:nil afterDelay:0.1];
	
}

- (void)fetchCredits{
	self.creditsString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.semanticdevlab.com/world_hunter/admin/textfile.txt" ] encoding:NSASCIIStringEncoding error:nil];

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)setTextViewText{
	self.textView.text = self.creditsString;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[textView release];
	[creditsString release];
}


@end
