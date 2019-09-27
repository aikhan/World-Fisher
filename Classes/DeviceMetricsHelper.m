//
//  DeviceMetricsHelper.m
//  Chefs Pantry
//
//  Created by Asad Khan on 11/1/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "DeviceMetricsHelper.h"


BOOL isIpad()
{
	static NSNumber *isIpad = nil;
	if (isIpad == nil)
		isIpad = [NSNumber numberWithBool:UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad];
	return [isIpad boolValue];
}

BOOL isIphone()
{
	return !isIpad();
}


BOOL isPortrait()
{
	return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
}

BOOL isLandscape()
{
	return !isPortrait();
}


CGFloat screenWidth()
{
	return isPortrait() ? (isIpad() ? kIpadPortraitWidth : kIphonePortraitWidth) : (isIpad() ? kIpadLandscapeWidth : kIphoneLandscapeWidth);
}

CGFloat screenHeight()
{
	return isPortrait() ? (isIpad() ? kIpadPortraitHeight : kIphonePortraitHeight) : (isIpad() ? kIpadLandscapeHeight : kIphoneLandscapeHeight);
}


@implementation UIViewController (OrientationMetrics)

- (BOOL)isPortrait
{
#ifdef UNIT_TESTING
	return UIDeviceOrientationIsPortrait(self.interfaceOrientation);
#else
	return isPortrait();
#endif
}

- (BOOL)isLandscape
{
	return !self.isPortrait;
}


- (CGFloat)screenWidth
{
	return self.isPortrait ? (isIpad() ? kIpadPortraitWidth : kIphonePortraitWidth) : (isIpad() ? kIpadLandscapeWidth : kIphoneLandscapeWidth);
}

- (CGFloat)screenHeight
{
	return self.isPortrait ? (isIpad() ? kIpadPortraitHeight : kIphonePortraitHeight) : (isIpad() ? kIpadLandscapeHeight : kIphoneLandscapeHeight);
}

@end
