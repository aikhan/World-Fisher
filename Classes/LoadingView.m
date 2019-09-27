//
//  LoadingView.m
//  TheHomeDepot
//
//  Created by The Home Depot on 7/22/10.
//  Copyright 2010 The Home Depot, Inc. All rights reserved.
//



#import "LoadingView.h"


@implementation LoadingView
@synthesize loadingBack;

/**
 @brief Initializes the view with the frame rect
 */
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		int width = frame.size.width/2 - 12;
		int height = frame.size.height/2 - 50;
		self.backgroundColor =[UIColor clearColor];
		loadingBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadingBackground.png"]];
		loadingBack.alpha = 0.75;
		loadingBack.frame = CGRectMake(width-(88+20) , height -15, 240, 150);
		[self addSubview:loadingBack];
		loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(width, height+30, 25, 25)];
		[loadingView startAnimating];
		[self addSubview: loadingView];
		
		viewLabel = [LoadingView newLabelWithPrimaryColor:[UIColor whiteColor]
													   selectedColor:[UIColor whiteColor] fontSize:20.0 bold:YES];
		viewLabel.frame = CGRectMake(width - (88+20), height + 55, 240, 47);
		viewLabel.text = @"Loading ...";
		
		viewLabel.textAlignment = UITextAlignmentCenter;
		viewLabel.numberOfLines = 2;
		viewLabel.textColor = [UIColor whiteColor];
		viewLabel.backgroundColor = [UIColor clearColor];
		[self addSubview: viewLabel];
    }
    return self;
}

/**
 @brief adds a background image 
 */
- (void) addBackground:(NSString *)backgroundImage
{
	viewLabel.hidden = YES;
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImage]];
	[self addSubview:imageView];
	loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	int width = self.frame.size.width/2 - 25;
	int height = self.frame.size.height/2 - 70;
	loadingView.frame = CGRectMake(width, height, 50, 50);
	//[self bringSubviewToFront:loadingView];
}

/**
 @brief changes the loading text
 @param text : loading text to change
 */
-(void) changeMessage:(NSString *)text
{
	CGRect rect = viewLabel.frame;
	rect.origin.x = rect.origin.x - 80;
	
	
	viewLabel.text = text;
	[self setNeedsDisplay];
}

/**
 @brief resets to default 
 */
-(void) returnToDefault
{
	int width = self.frame.size.width/2 - 12;
	int height = self.frame.size.height/2 - 50;
	viewLabel.frame = CGRectMake(width - (88+20), height + 55, 240, 47);
	viewLabel.text = @"Loading..."; 
	
}

- (void)drawRect:(CGRect)rect {}

- (void)dealloc {
    [super dealloc];
}
+ (UILabel *)newLabelWithPrimaryColor:(UIColor *) primaryColor 
						selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	UIFont *font;
	if(bold)
		font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize]; // fontSize
	else
		font = [UIFont fontWithName:@"Helvetica" size:fontSize];
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.opaque = YES;
	newLabel.textColor= primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;	
}

@end
