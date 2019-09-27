//
//  FishDetailImageController.m
//  MapApp
//
//  Created by Anam on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FishDetailImageController.h"


@implementation FishDetailImageController
@synthesize detailImage;
@synthesize image, scrollView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    ratio=[UIScreen mainScreen].bounds.size.width/320;
    
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:self.image];
    // scrollView.bounds =  tempImageView.frame;
    
    
    
	//[self setDetailImage:tempImageView];
	
    [scrollView setFrame:CGRectMake(10, 65,scrollView.frame.size.width*ratio , scrollView.frame.size.height*ratio)];
	scrollView.contentSize = CGSizeMake(tempImageView.frame.size.width*ratio , tempImageView.frame.size.height*ratio);
    //    [scrollView setContentMode:UIViewContentModeScaleAspectFit];
    //    [tempImageView sizeToFit];
    
	scrollView.maximumZoomScale = 3.0;
	scrollView.minimumZoomScale = 0.10;
	scrollView.zoomScale = 1.0;
	scrollView.clipsToBounds = YES;
    // [scrollView setFrame:CGRectMake(0, 65, scrollView.frame.size.width , scrollView.frame.size.height)];
    
    
    //  scrollView.contentMode=UIViewContentModeScaleAspectFill;
    
	scrollView.delegate = self;
    
	[scrollView addSubview:tempImageView];
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (self.image == nil) {
		NSLog(@"Cry");
	}
   //	self.detailImage.image = self.image;
	

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
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
	[detailImage release];
	[image release];
	[scrollView release];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return detailImage;
}

@end
