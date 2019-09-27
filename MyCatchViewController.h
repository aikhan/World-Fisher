//
//  MyCatchViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 12/18/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandardInfoFeedViewController.h"
@class AddNewCatchViewController;

@interface MyCatchViewController : StandardInfoFeedViewController  <UINavigationControllerDelegate>{
	AddNewCatchViewController *addNewCatchViewController;
//- (void)reDisplay;
}
@property (nonatomic, retain) AddNewCatchViewController *addNewCatchViewController;

- (NSString *)convertTimeIntervalToString:(NSDate *)date;
@end