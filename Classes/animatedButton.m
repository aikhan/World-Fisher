//
//  animatedButton.m
//  World-Fisher
//
//  Created by Qaisar on 4/8/2557 BE.
//
//

#import "animatedButton.h"
#import "SKBounceAnimation.h"

@implementation animatedButton
@synthesize finalrect;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) animateSelectedButton1:(float)delay{
    
    [self performSelector:@selector(animateSelectedButton) withObject:Nil afterDelay:delay];
}

-(void) animateSelectedButton{
    
    
    NSString *keyPath = @"position";
    
    id finalValue;
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
        finalValue = [NSValue valueWithCGPoint:self.finalrect];//CGPointMake(140, 618)];
    }
    else
        finalValue = [NSValue valueWithCGPoint:self.finalrect];//CGPointMake(140, 350)];
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            finalValue = [NSValue valueWithCGPoint:self.finalrect];//CGPointMake(140, 400)];
            
        }}
    
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
    bounceAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 6.f;
    bounceAnimation.numberOfBounces = 10;
    bounceAnimation.shouldOvershoot = YES;
    
    
    [self.layer addAnimation:bounceAnimation forKey:@"someKey"];
    
    [self.layer setValue:finalValue forKeyPath:keyPath];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
