//
//  splashView.m
//  version 1.1
//
//  Created by Shannon Appelcline on 5/22/09.
//  Copyright 2009 Skotos Tech Inc.
//
//  Licensed Under Creative Commons Attribution 3.0:
//  http://creativecommons.org/licenses/by/3.0/
//  You may freely use this class, provided that you maintain these attribute comments
//
//  Visit our iPhone blog: http://iphoneinaction.manning.com
//

#import "splashView.h"
#import "DeviceMetricsHelper.h"


@implementation splashView
@synthesize delegate;
@synthesize image;
@synthesize delay;
@synthesize touchAllowed;
@synthesize animation;
@synthesize isFinishing;
@synthesize animationDelay;


- (id)initWithImage:(UIImage *)screenImage {

	if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())]) {
		self.image = screenImage;
		self.delay = 5;
		self.touchAllowed = NO;
		self.animation = SplashViewAnimationFade;
		self.animationDelay = 1.5;
		self.isFinishing = NO;
	}
	return self;
}

- (void)startSplash {

	[[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:self];
	splashImage = [[UIImageView alloc] initWithImage:self.image];
   
	//[self addSubview:splashImage];
    
  

	[self performSelector:@selector(dismissSplash) withObject:self afterDelay:self.delay];
}

- (void)dismissSplash {

	if (self.isFinishing || self.animation == SplashViewAnimationNone) {
		[self dismissSplashFinish];
	} else if (self.animation == SplashViewAnimationSlideLeft) {
		CABasicAnimation *animSplash = [CABasicAnimation animationWithKeyPath:@"transform"];
		animSplash.duration = self.animationDelay;
		animSplash.removedOnCompletion = NO;
		animSplash.fillMode = kCAFillModeForwards;
		animSplash.toValue = [NSValue valueWithCATransform3D:
							  CATransform3DMakeAffineTransform
							  (CGAffineTransformMakeTranslation(-screenWidth(), 0))];
		animSplash.delegate = self;
		[self.layer addAnimation:animSplash forKey:@"animateTransform"];
	} else if (self.animation == SplashViewAnimationFade) {
		CABasicAnimation *animSplash = [CABasicAnimation animationWithKeyPath:@"opacity"];
		animSplash.duration = self.animationDelay;
		animSplash.removedOnCompletion = NO;
		animSplash.fillMode = kCAFillModeForwards;
		animSplash.toValue = [NSNumber numberWithFloat:0];
		animSplash.delegate = self;
		[self.layer addAnimation:animSplash forKey:@"animateOpacity"];
	}
	self.isFinishing = YES;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {

	[self dismissSplashFinish];
}

- (void)dismissSplashFinish {

	if (splashImage) {
		[splashImage removeFromSuperview];
		[self removeFromSuperview];
		[image release];
	}
	if (self.delegate && [self.delegate respondsToSelector:@selector(splashIsDone)]) {
		[delegate splashIsDone];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	if (self.touchAllowed) {
		[self dismissSplash];
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
