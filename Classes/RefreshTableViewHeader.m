    //
//  RefreshTableViewHeader.m
//  UIStandardization
//
//  Created by Parul Jain solutions on 29/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RefreshTableViewHeader.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]

@implementation RefreshTableViewHeader

@synthesize state=_state;

// create and add all the UI stuff here.
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
		lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		lastUpdatedLabel.textColor = TEXT_COLOR;
		lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		lastUpdatedLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:lastUpdatedLabel];
		[lastUpdatedLabel release];
		
		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"RefreshTableView_LastRefresh"]) {
			lastUpdatedLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"RefreshTableView_LastRefresh"];
		} else {
			[self setCurrentDate];
		}
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		statusLabel.textColor = TEXT_COLOR;
		statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.textAlignment = UITextAlignmentCenter;
		[self setState:PullRefreshNormal];
		[self addSubview:statusLabel];
		[statusLabel release];
		
		arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, frame.size.height - 45.0f, 10.0f, 28.0f)];
		arrowImage.contentMode = UIViewContentModeScaleAspectFit;
		arrowImage.image = [UIImage imageNamed:@"arrow.png"];
		[self addSubview:arrowImage];
		[arrowImage release];
		
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		activityView.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		activityView.hidesWhenStopped = YES;
		[self addSubview:activityView];
		[activityView release];
		
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextDrawPath(context,  kCGPathFillStroke);
	[BORDER_COLOR setStroke];
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0.0f, self.bounds.size.height - 1);
	CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height - 1);
	CGContextStrokePath(context);
}

- (void)layoutSubviews
{
	CGSize mySize = self.frame.size;
	lastUpdatedLabel.frame = CGRectMake(0, mySize.height - 30, mySize.width, 20);
	statusLabel.frame = CGRectMake(0, mySize.height - 48, mySize.width, 20);
	arrowImage.frame = CGRectMake(20, mySize.height - 45, 10, 28);
	activityView.frame = CGRectMake(25, mySize.height - 38, 20, 20);
}

// Set the current date to be shown on label.
- (void)setCurrentDate 
{
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setAMSymbol:@"AM"];
	[formatter setPMSymbol:@"PM"];
	[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
	lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:[NSDate date]]];
	[[NSUserDefaults standardUserDefaults] setObject:lastUpdatedLabel.text forKey:@"RefreshTableView_LastRefresh"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[formatter release];
}

// Check and set the state of the refresh behaviour. 
- (void)setState:(PullRefreshState)aState
{
	
	switch (aState) 
	{
		case PullRefreshPulling:
			
			statusLabel.text = @"Release to refresh...";
			[CATransaction begin];
			[CATransaction setAnimationDuration:.18];
			arrowImage.hidden = NO;
			[CATransaction commit];
			
			break;
		case PullRefreshNormal:
			
			if (_state == PullRefreshPulling)
			{
				[CATransaction begin];
				[CATransaction setAnimationDuration:.18];
				[CATransaction commit];
			}
			
			statusLabel.text = @"Pull down to refresh...";
			[activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			arrowImage.hidden = NO;
			[CATransaction commit];
			
			break;
		case PullRefreshLoading:
			
			statusLabel.text = @"Loading...";
			[activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}

// Release the used memory.
- (void)dealloc 
{
	activityView = nil;
	statusLabel = nil;
	arrowImage = nil;
	lastUpdatedLabel = nil;
    [super dealloc];
}


@end
