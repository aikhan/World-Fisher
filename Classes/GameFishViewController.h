//
//  GameFishViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 12/22/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandardInfoFeedViewController.h"
#import "MyCatchViewController.h"

@interface GameFishViewController : StandardInfoFeedViewController {
	
	NSMutableArray			*myInfoFeedArray;

}
@property (nonatomic, retain) NSMutableArray *myInfoFeedArray;
@property (strong, nonatomic)UISegmentedControl* segmentedControl;
- (NSString *)makeURLReady:(NSString *)oldURL;
@end