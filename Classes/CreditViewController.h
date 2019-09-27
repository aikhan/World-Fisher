//
//  CreditViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 2/17/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreditViewController : UIViewController {
	UITextView *textView;
	NSString *creditsString;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) NSString *creditsString;
@end
