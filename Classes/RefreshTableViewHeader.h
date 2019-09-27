//
//  RefreshTableViewHeader.h
//  UIStandardization
//
//  Created by Parul Jain on 29/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


typedef enum
{
	PullRefreshPulling = 0,
	PullRefreshNormal,
	PullRefreshLoading,	
} PullRefreshState;

@interface RefreshTableViewHeader : UIView {
	
	UILabel *lastUpdatedLabel;
	UILabel *statusLabel;
	UIImageView *arrowImage;
	UIActivityIndicatorView *activityView;
	
	PullRefreshState _state;
	
}

@property(nonatomic,assign) PullRefreshState state;

- (void)setCurrentDate;
- (void)setState:(PullRefreshState)aState;

@end