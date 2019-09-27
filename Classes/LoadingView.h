//
//  LoadingView.h
//  TheHomeDepot
//
//  Created by The Home Depot on 7/22/10.
//  Copyright 2010 The Home Depot, Inc. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface LoadingView : UIView {
	UILabel *viewLabel;
	UIActivityIndicatorView *loadingView;
	UIImageView *loadingBack;
}
@property(nonatomic,retain)  UIImageView *loadingBack;
- (void) addBackground:(NSString *)backgroundImage;
-(void) changeMessage:(NSString *)text;
-(void) returnToDefault;
+ (UILabel *)newLabelWithPrimaryColor:(UIColor *) primaryColor 
						selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end
