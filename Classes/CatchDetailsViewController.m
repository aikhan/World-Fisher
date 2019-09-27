//
//  CatchDetailsViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 12/19/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "CatchDetailsViewController.h"
#import "AddNewCatchViewController.h"

@implementation CatchDetailsViewController
@synthesize fishNameLabel, fishDetails, fishImageView, currentCatchId,TestArray;
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
    
	self.navigationItem.rightBarButtonItem  = nil;
	isPhotoUploaded = YES;
	//self.myCatchCurrentID = self.currentCatchId;
    self.fishNameLabel.text= [[TestArray objectAtIndex:0] titleText];
    self.fishDetails.text = [[TestArray objectAtIndex:0] text];
    self.fishImageView.image = [[TestArray objectAtIndex:0] thumbnailImage];

	
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

- (IBAction)saveButtonTapped{
	[super setViewMovedUp:NO];
}
-(void)textViewDidBeginEditing:(UITextView *)sender
{
		NSLog(@"This is a log statement 1");
    if ([sender isEqual:fishDetails])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            NSLog(@"This is a log statement");
			[super setViewMovedUp:YES];
        }
    }
}

- (void)dealloc {
    [super dealloc];
	[fishImageView release];
	[fishDetails release];
	[fishNameLabel release];
}


@end
