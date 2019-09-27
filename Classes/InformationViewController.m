//
//  InformationViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 2/15/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import "InformationViewController.h"
#import "GlossaryViewController.h"
#import "AboutViewController.h"
#import "CreditViewController.h"
#import "RateManager.h"

@implementation InformationViewController
@synthesize audioPlayer;
@synthesize glossaryAnim,craditAnim,aboutAnim;
- (IBAction) glossaryTapped{
    
    
    GlossaryViewController *glossaryViewController;
	[self playSound];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        glossaryViewController = [[GlossaryViewController alloc] initWithNibName:@"GlossaryViewController-ipad" bundle:Nil];
    else
        
        glossaryViewController = [[GlossaryViewController alloc] initWithNibName:@"GlossaryViewController" bundle:Nil];
    [self.navigationController pushViewController:glossaryViewController animated:YES];
    [glossaryViewController release];
    
}
- (IBAction) creditsTapped{
    
    
    CreditViewController *creditViewController;
	[self playSound];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        creditViewController = [[CreditViewController alloc] initWithNibName:@"CreditViewController-ipad" bundle:Nil];
    else
        creditViewController = [[CreditViewController alloc] initWithNibName:@"CreditViewController" bundle:Nil];
    [self.navigationController pushViewController:creditViewController animated:YES];
	[creditViewController release];
    
	
}
- (IBAction) aboutusTapped{
     [[RateManager sharedManager]showReviewApp];
    
//    AboutViewController *aboutViewController;
//	[self playSound];
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
//        aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController-ipad" bundle:Nil];
//    else
//        aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:Nil];
//	[self.navigationController pushViewController:aboutViewController animated:YES];
//	[aboutViewController release];
}

- (void)playSound{
	NSString *soundFilePath = [NSString stringWithString:[[NSBundle mainBundle] pathForResource: @"info" ofType: @"mp3"]];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    AVAudioPlayer *newPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
    self.audioPlayer = newPlayer;
	[audioPlayer play];
	[fileURL release];
	[newPlayer release];
	
}
-(void)viewWillAppear:(BOOL)animated{
    
    if (!CGRectContainsPoint(buttonView.frame, CGPointMake(-380, -718))) {
        //	buttonView.frame = CGRectMake(0, 518, 280, 80);
        
        NSLog(@"viewWillAppear cgrect");
        
		buttonView.center = CGPointMake(-180,-20);
		return;
	}
    NSLog(@"viewWillAppear ");
    
	NSString *keyPath = @"position";
	id finalValue = [NSValue valueWithCGPoint:CGPointMake(140,518)];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCGPoint:buttonView.center];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = 0.8f;
	bounceAnimation.numberOfBounces = 8;
	bounceAnimation.shouldOvershoot = YES;
    
	
	[buttonView.layer addAnimation:bounceAnimation forKey:@"someKey"];
	
	[buttonView.layer setValue:finalValue forKeyPath:keyPath];
    
    
    
    
    
    //.........
    //    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
    //        [UIView animateWithDuration: 2.0f
    //                              delay: 0.2f
    //                            options: UIViewAnimationOptionCurveEaseIn
    //                         animations: ^{
    //
    //                             self.glossaryAnim.frame=CGRectMake(0, 574, 292, 60);
    //                             self.craditAnim.frame=CGRectMake(0, 631, 292, 60);
    //                             self.aboutAnim.frame=CGRectMake(0, 690, 292, 60);
    //                         }
    //                         completion: ^(BOOL finished) {
    //                             if (finished) {
    //                             }
    //
    //                         }];
    //
    //
    //    }else{
    //        [UIView animateWithDuration: 1.0f
    //                              delay: 0.2f
    //                            options: UIViewAnimationOptionCurveEaseIn
    //                         animations: ^{
    //
    //                             self.glossaryAnim.frame=CGRectMake(0, 274, 168, 36);
    //                             self.craditAnim.frame=CGRectMake(0, 309, 168, 36);
    //                             self.aboutAnim.frame=CGRectMake(0, 344, 168, 36);
    //
    //                         }
    //                         completion: ^(BOOL finished) {
    //                             if (finished) {
    //                             }
    //
    //                         }];
    //
    //
    //    }
    //
    //
}
/*-(void)viewDidAppear:(BOOL)animated{
 if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
 [UIView animateWithDuration: 2.0f
 delay: 0.2f
 options: UIViewAnimationOptionCurveEaseIn
 animations: ^{
 
 self.glossaryAnim.frame=CGRectMake(0, 574, 292, 60);
 self.craditAnim.frame=CGRectMake(0, 631, 292, 60);
 self.aboutAnim.frame=CGRectMake(0, 690, 292, 60);
 }
 completion: ^(BOOL finished) {
 if (finished) {
 }
 
 }];
 
 
 }else{
 [UIView animateWithDuration: 1.0f
 delay: 0.2f
 options: UIViewAnimationOptionCurveEaseIn
 animations: ^{
 
 self.glossaryAnim.frame=CGRectMake(0, 274, 168, 36);
 self.craditAnim.frame=CGRectMake(0, 309, 168, 36);
 self.aboutAnim.frame=CGRectMake(0, 344, 168, 36);
 
 }
 completion: ^(BOOL finished) {
 if (finished) {
 }
 
 }];
 
 
 }
 }
 
 */

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
    
    buttonView.center= CGPointMake(-280, -518);
    //........
    
    //    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
    //        self.glossaryAnim.frame=CGRectMake(775, 574, 292, 60);
    //        self.craditAnim.frame=CGRectMake(775, 631, 292, 60);
    //        self.aboutAnim.frame=CGRectMake(775, 690, 292, 60);
    //    }else{
    //    self.glossaryAnim.frame=CGRectMake(325, 274, 168, 36);
    //    self.craditAnim.frame=CGRectMake(325, 309, 168, 36);
    //    self.aboutAnim.frame=CGRectMake(325, 334, 168, 36);
    //}
    //
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
-(void)viewDidAppear:(BOOL)animated{
    
    if (!CGRectContainsPoint(buttonView.frame, CGPointMake(-50, -10))) {
        //		buttonView.frame = CGRectMake(0, 518, 280, 80);
		buttonView.center = CGPointMake(140, 518);
        NSLog(@"viewDidAppear cgrect");
		return;
        
	}
	
	NSString *keyPath = @"position";
    
    
    NSLog(@"viewDidAppear ");
    
    id finalValue;
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
        finalValue = [NSValue valueWithCGPoint:CGPointMake(140, 618)];
    }
    else
        finalValue = [NSValue valueWithCGPoint:CGPointMake(140, 350)];
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            finalValue = [NSValue valueWithCGPoint:CGPointMake(140, 450)];
            
        }else{
        finalValue = [NSValue valueWithCGPoint:CGPointMake(140, 400)];
        }
    }
    
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
    bounceAnimation.fromValue = [NSValue valueWithCGPoint:buttonView.center];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 0.8f;
    bounceAnimation.numberOfBounces = 8;
    bounceAnimation.shouldOvershoot = YES;
    
    
    [buttonView.layer addAnimation:bounceAnimation forKey:@"someKey"];
    
    [buttonView.layer setValue:finalValue forKeyPath:keyPath];
    
    //-----------------
    /*
     if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
     
     [UIView animateWithDuration: 1.0f
     delay: 0.2f
     options: UIViewAnimationOptionCurveEaseIn
     animations: ^{
     
     self.myCatchButtonAnim.frame=CGRectMake(0, 518, 280, 80);
     self.gameFishAnim.frame=CGRectMake(0, 584, 280, 80);
     self.infoAnim.frame=CGRectMake(0, 649, 280, 80);
     self.mapAnim.frame=CGRectMake(0, 715, 280, 80);
     
     }
     completion: ^(BOOL finished) {
     if (finished) {
     }
     
     }];
     
     
     
     }else{
     [UIView animateWithDuration: 1.0f
     delay: 0.2f
     options: UIViewAnimationOptionCurveEaseIn
     animations: ^{
     
     self.myCatchButtonAnim.frame=CGRectMake(0, 215, 168, 36);
     self.gameFishAnim.frame=CGRectMake(0, 250, 168, 36);
     self.infoAnim.frame=CGRectMake(0, 287, 168, 36);
     self.mapAnim.frame=CGRectMake(0, 319, 168, 36);
     
     }
     completion: ^(BOOL finished) {
     if (finished) {
     }
     
     }];
     
     }
     */
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setGlossaryAnim:nil];
    [self setCraditAnim:nil];
    [self setAboutAnim:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [audioPlayer release];
    [glossaryAnim release];
    [craditAnim release];
    [aboutAnim release];
	[super dealloc];
	
}


@end
