//
//  animatedButton.h
//  World-Fisher
//
//  Created by Qaisar on 4/8/2557 BE.
//
//

#import <UIKit/UIKit.h>

@interface animatedButton : UIButton

@property(nonatomic)CGPoint finalrect;
-(void) animateSelectedButton;
-(void) animateSelectedButton1:(float)delay;

@end
