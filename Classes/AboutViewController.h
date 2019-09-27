//
//  AboutViewController.h
//  UIStandardization
//
//  Created by Mac on 5/25/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController : UIViewController<UIActionSheetDelegate ,MFMailComposeViewControllerDelegate> {
	IBOutlet UILabel		*copyRightLabel;
	IBOutlet UILabel		*emailLabel;
	IBOutlet UILabel		*twitterLabel;
	IBOutlet UILabel		*facebookLabel;
	NSString				*copyright;
	NSString				*emailID;
	NSString				*twitter;
	NSString				*facebook;
	IBOutlet UILabel		*message;
	IBOutlet UIImageView	*myImage;
	UIImage					*backgroundImage;
}

@property (nonatomic, retain) NSString *copyright;
@property (nonatomic, retain) NSString *emailID;
@property (nonatomic, retain) NSString *twitter;
@property (nonatomic, retain) NSString *facebook;
@property (nonatomic, retain) UILabel *message;
@property (nonatomic, retain) UIImage *backgroundImage;


-(IBAction) emailClicked:(id)sender;
-(IBAction) twitterClicked:(id)sender;
-(IBAction) facebookClicked:(id)sender;
-(void)showPicker;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
@end

