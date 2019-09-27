 //
 //  DeviceMetricsHelper.h
 //  Chefs Pantry
 //
 //  Created by Asad Khan on 11/1/10.
 //  Copyright 2010 Semantic Notion Inc. All rights reserved.
 //

// this file must be included if you want to check the current device type,
// to use constants for width/height and to get current screen width/height


enum
{
	kIpadPortraitWidth = 768,
	kIpadLandscapeHeight = 768,
	kIpadPortraitHeight = 1024,
	kIpadLandscapeWidth = 1024,
	kIphonePortraitWidth = 320,
	kIphoneLandscapeHeight = 320,
	kIphonePortraitHeight = 480,
	kIphoneLandscapeWidth = 480
};


BOOL isIpad();
BOOL isIphone();


// these don't work in google testing framework (GTM), so use the next category if you plan to unittest with GTM
#pragma mark Functions using device orientation 

BOOL isPortrait();
BOOL isLandscape();

CGFloat screenWidth();
CGFloat screenHeight();


// this makes GTM determine orientation correctly
#pragma mark Category methods on UIViewController that use self.interfaceOrientation

@interface UIViewController (OrientationMetrics)

@property(nonatomic, readonly) BOOL isPortrait;
@property(nonatomic, readonly) BOOL isLandscape;
@property(nonatomic, readonly) CGFloat screenWidth;
@property(nonatomic, readonly) CGFloat screenHeight;

@end
