//
//  CatchDetailsViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 12/19/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewCatchViewController.h"


@interface CatchDetailsViewController : AddNewCatchViewController <UITextViewDelegate>{
	UILabel *fishNameLabel;
	UIImageView *fishImageView;
	UITextView *fishDetails;
	int currentCatchId;
	
}
@property (nonatomic, retain) IBOutlet UITextView *fishDetails;
@property (nonatomic, retain) IBOutlet UIImageView *fishImageView;
@property (nonatomic, retain) IBOutlet UILabel *fishNameLabel;
@property (nonatomic, assign) IBOutlet int currentCatchId;

-(IBAction)saveButtonTapped;

@end
