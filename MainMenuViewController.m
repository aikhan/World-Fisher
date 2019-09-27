//
//  MainMenuViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 12/18/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "MainMenuViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MyCatchViewController.h"
#import "GameFishViewController.h"
#import "MapAppViewController.h"
#import "MapViewController.h"
#import "InformationViewController.h"
#import "MKStoreManager.h"
#import "animatedButton.h"
#import "MBProgressHUD.h"
@implementation MainMenuViewController
@synthesize audioPlayer, mapViewController,myButton,restore;
@synthesize infoFeedController, informationViewController, gameFishController;
@synthesize myCatchButtonAnim,gameFishAnim,infoAnim,mapAnim;
- (void)dealloc {
    [myCatchButtonAnim release];
    [gameFishAnim release];
    [infoAnim release];
    [mapAnim release];
    [super dealloc];
	[audioPlayer release];
	[mapViewController release];
	[infoFeedController release];
	[informationViewController release];
	[gameFishController release];
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

    
//    
 //    buttonView.frame = CGRectMake(0, 518, 280, 80);
//	 buttonView.center = CGPointMake(-280, -518);
    buttonView.center= CGPointMake(-280, -518);
//	[self.view addSubview: self.myCatchButtonAnim];

    
    
    
//    self.myCatchButtonAnim.frame = CGRectMake(775, 518, 280, 80);
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//        self.myCatchButtonAnim.frame=CGRectMake(775, 518, 280, 80);
//        self.gameFishAnim.frame=CGRectMake(775, 584, 280, 80);
//        self.infoAnim.frame=CGRectMake(775, 649, 280, 80);
//        self.mapAnim.frame=CGRectMake(775, 715, 280, 80);
//    }else{
//    //................Buttons Animation..............//
//    self.myCatchButtonAnim.frame=CGRectMake(325, 215, 168, 36);
//    self.gameFishAnim.frame=CGRectMake(325, 250, 168, 36);
//    self.infoAnim.frame=CGRectMake(325, 287, 168, 36);
//    self.mapAnim.frame=CGRectMake(325, 319, 168, 36);
//    
//    }
//    
    
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES];
#ifdef FreeApp
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(transactionDidCompleted:)
                                                 name:@"ForMainViews"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(transactionDidFailed:)
                                                 name:@"ForFailView"
                                               object:nil];
    #endif
    
#ifdef FreeApp
   
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   
    if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"]){
       
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // self.myButton.frame = CGRectMake(150, 380, 50, 50); // position in the parent view and set the size of the button
        [self.myButton setImage:[UIImage imageNamed:@"RemoveAdd1.png"] forState:UIControlStateNormal];
        //[self.myButton setTitle:@"Remove Ads" forState:UIControlStateNormal];
        // add targets and actions
        [self.myButton addTarget:self action:@selector(removeAd) forControlEvents:UIControlEventTouchUpInside];
        // add to a view
        self.restore = [UIButton buttonWithType:UIButtonTypeCustom];
        //  self.restore.frame = CGRectMake(220, 380, 50, 50); // position in the parent view and set the size of the button
        [self.restore setImage:[UIImage imageNamed:@"Restore1.png"] forState:UIControlStateNormal];
        // [self.restore setTitle:@"Restore" forState:UIControlStateNormal];
        // add targets and actions
        [self.restore addTarget:self action:@selector(reStore) forControlEvents:UIControlEventTouchUpInside];
        // add to a view
        if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
            self.myButton.frame = CGRectMake(340, 860, 200, 60); // position in the parent view and set the size of the button
            self.restore.frame = CGRectMake(540, 860, 200, 60); // position in the parent view and set the size of the button

    }else{
           self.myButton.frame = CGRectMake(110, 380, 100, 30); // position in the parent view and set the size of the button
           self.restore.frame = CGRectMake(210, 380, 100, 30); // position in the parent view and set the size of the button
    }
        
        
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            self.myButton.frame = CGRectMake(100, 470, 100, 30); // position in the parent view and set the size of the button
            self.restore.frame = CGRectMake(200, 470, 100, 30); // position in the parent view and set the size of the button
            
        }
    
       
    }
        
        [self.view addSubview:self.myButton];
        
        
        [self.view addSubview:self.restore];
        
    }

    
#endif
  
    
    
   // [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"menu bar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0,320,280)] forBarMetrics:UIBarMetricsDefault];
//	self.navigationController.navigationBar.tintColor = [UIColor clearColor];
//	self.navigationController.navigationBar.translucent = YES;
//	self.navigationController.navigationBar.alpha = 0.55;
//self.navigationController.navigationBar.bounds = CGRectMake(0, -10, 320, 80);
	self.navigationItem.title = @"Menu";
	//[self performSelector:@selector(hideNavigationBar) withObject:nil afterDelay:2.0];
	self.audioPlayer.numberOfLoops = 1;
	self.audioPlayer.currentTime = 0;
	self.audioPlayer.volume = 1.0;
    
	
	
	
}


-(void)viewDidAppear:(BOOL)animated{
    
    if (!CGRectContainsPoint(buttonView.frame, CGPointMake(-50, -10))) {
//		buttonView.frame = CGRectMake(0, 518, 280, 80);
		buttonView.center = CGPointMake(140, 518);
        infoButton.center = CGPointMake(140,518);
        infoButton1.center= CGPointMake(140,518);
        infoButton2.center=CGPointMake(140, 518);
        infoButton3.center=CGPointMake(140, 518);

        NSLog(@"viewDidAppear cgrect");
		return;
        
	}
	
	NSString *keyPath = @"position";
   
    
    NSLog(@"viewDidAppear ");
    
    id finalValue;
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
        finalValue = [NSValue valueWithCGPoint:CGPointMake(780, 618)];
        
        
    }
    else
        finalValue = [NSValue valueWithCGPoint:CGPointMake(140, 350)];
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            finalValue = [NSValue valueWithCGPoint:CGPointMake(140, 400)];
            
        }}
    
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
    bounceAnimation.fromValue = [NSValue valueWithCGPoint:buttonView.center];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 0.4f;
    bounceAnimation.numberOfBounces = 8;
    bounceAnimation.shouldOvershoot = YES;
    
    
    [buttonView.layer addAnimation:bounceAnimation forKey:@"someKey"];
    
    [buttonView.layer setValue:finalValue forKeyPath:keyPath];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        infoButton.finalrect = CGPointMake(135,530);
        [infoButton animateSelectedButton1:0.1];
        
        infoButton1.finalrect = CGPointMake(135, 595);
        [infoButton1 animateSelectedButton1:0.4];
        
        infoButton2.finalrect = CGPointMake(135, 661);
        [infoButton2 animateSelectedButton1:0.8];
        
        infoButton3.finalrect = CGPointMake(135, 726);
        [infoButton3 animateSelectedButton1:1.2];
        
        
    }else{
        
        
        
        infoButton.finalrect = CGPointMake(85,22);
        [infoButton animateSelectedButton1:0.1];
        
        infoButton1.finalrect = CGPointMake(85, 58);
        [infoButton1 animateSelectedButton1:0.4];
        
        infoButton2.finalrect = CGPointMake(85, 70 +23);
        [infoButton2 animateSelectedButton1:0.8];
        
        infoButton3.finalrect = CGPointMake(85, 70 + 60);
        [infoButton3 animateSelectedButton1:1.2];
        
    }
}
-(void)reStore{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Wait";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
[[MKStoreManager sharedManager] restore];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
-(void)removeAd{

#ifdef FreeApp
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Wait";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[MKStoreManager sharedManager] buyFeatureH];
#endif

}
- (void)transactionDidFailed:(NSNotification *)notif {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Purchaising Failed" message:@"Please Try Later" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)transactionDidCompleted:(NSNotification *)notif {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.myButton.hidden=YES;
    self.restore.hidden=YES;
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"com.semanticnotion.worldfisherfree.removeads"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Purchaising successful" message:@"You Have Successfully Purchaised Remove Ads" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)playSoundForButton:(id)sender{
	NSString *soundFilePath;
	switch ([sender tag]) {
		case 0:
			soundFilePath =[NSString stringWithString:[[NSBundle mainBundle] pathForResource: @"mycatch" ofType: @"mp3"]];
			break;
		case 1:
			soundFilePath =[NSString stringWithString:[[NSBundle mainBundle] pathForResource: @"gamefish" ofType: @"mp3"]];
			break;
		case 2:
			soundFilePath =[NSString stringWithString:[[NSBundle mainBundle] pathForResource: @"map" ofType: @"mp3"]];
			break;
		case 3:
			soundFilePath =[NSString stringWithString:[[NSBundle mainBundle] pathForResource: @"info" ofType: @"mp3"]];
			break;
		default:
			soundFilePath = nil;
			break;
	}
	
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    AVAudioPlayer *newPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
    self.audioPlayer = newPlayer;
	[audioPlayer play];
	[fileURL release];
	[newPlayer release];
	
}


- (void)viewWillAppear:(BOOL)animated{
	//[self performSelector:@selector(hideNavigationBar) withObject:nil afterDelay:2.0];

  //  [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if (!CGRectContainsPoint(buttonView.frame, CGPointMake(-380, -718))) {
	//	buttonView.frame = CGRectMake(0, 518, 280, 80);
        
        NSLog(@"viewWillAppear cgrect");
        
        CGRect *finalValueOfButtons;
       
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            buttonView.center = CGPointMake(-180,-60);
            infoButton.center = CGPointMake(950,530);
            infoButton1.center = CGPointMake(950,595);
            infoButton2.center = CGPointMake(950,661);
            infoButton3.center = CGPointMake(950,726);
            
        }else{

        
		buttonView.center = CGPointMake(-180,-60);
        infoButton.center = CGPointMake(450,50);
        infoButton1.center = CGPointMake(450,80);
        infoButton2.center = CGPointMake(450,100);
        infoButton3.center = CGPointMake(450,120);
        }
        return;
	}
    NSLog(@"viewWillAppear ");

	NSString *keyPath = @"position";
	id finalValue = [NSValue valueWithCGPoint:CGPointMake(140,518)];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCGPoint:buttonView.center];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = 0.4f;
	bounceAnimation.numberOfBounces = 8;
	bounceAnimation.shouldOvershoot = YES;
    
	
	[buttonView.layer addAnimation:bounceAnimation forKey:@"someKey"];
	
	[buttonView.layer setValue:finalValue forKeyPath:keyPath];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        infoButton.finalrect = CGPointMake(85,22);
        [infoButton animateSelectedButton1:0.1];
        
        infoButton1.finalrect = CGPointMake(85, 58);
        [infoButton1 animateSelectedButton1:0.4];
        
        infoButton2.finalrect = CGPointMake(85, 70 +23);
        [infoButton2 animateSelectedButton1:0.8];
        
        infoButton3.finalrect = CGPointMake(85, 70 + 60);
        [infoButton3 animateSelectedButton1:1.2];
    }else{
    
    infoButton.finalrect = CGPointMake(85,22);
    [infoButton animateSelectedButton1:0.1];
    
    infoButton1.finalrect = CGPointMake(85, 58);
    [infoButton1 animateSelectedButton1:0.4];
    
    infoButton2.finalrect = CGPointMake(85, 70 +23);
    [infoButton2 animateSelectedButton1:0.8];
    
    infoButton3.finalrect = CGPointMake(85, 70 + 60);
    [infoButton3 animateSelectedButton1:1.2];
    }}
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
    [self setMyCatchButtonAnim:nil];
    [self setGameFishAnim:nil];
    [self setInfoAnim:nil];
    [self setMapAnim:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.audioPlayer = nil;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (IBAction)buttonTapped:(id)sender{
	[self playSoundForButton:sender];
	switch ([sender tag]) {
		case 0:
			NSLog(@"My Catch");
			self.infoFeedController = [[MyCatchViewController alloc] init];
			[self.navigationController pushViewController:self.infoFeedController animated:YES];
			
			break;
		case 1:
			NSLog(@"Game Fish");
			self.gameFishController = [[GameFishViewController alloc] init];
			[self.navigationController pushViewController:self.gameFishController animated:YES];
			break;
		case 2:
			NSLog(@"Map");
			self.mapViewController = [[MapViewController alloc] init];
			[self.navigationController pushViewController:self.mapViewController animated:YES];
			//[mapViewController release];
			break;
		case 3:
			NSLog(@"Info & Privacy");
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                self.informationViewController = [[InformationViewController alloc] initWithNibName:@"InformationViewController-ipad" bundle:Nil];
        else
			self.informationViewController = [[InformationViewController alloc] initWithNibName:@"InformationViewController" bundle:Nil];
			
            [self.navigationController pushViewController:self.informationViewController animated:YES];
			

			break;
		default:
			break;
	}
	
}
- (void)hideNavigationBar{
	if ([self isMemberOfClass:[MainMenuViewController class]]) {
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
}
	
@end
