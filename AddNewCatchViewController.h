//
//  AddNewCatchViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 12/19/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

//#import "SA_OAuthTwitterEngine.h"
//#import "SA_OAuthTwitterController.h"
#import <CoreLocation/CoreLocation.h>


@interface AddNewCatchViewController : UIViewController 
<UITextViewDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate, 
UIActionSheetDelegate, UITextFieldDelegate, UINavigationControllerDelegate,
 UIAlertViewDelegate, CLLocationManagerDelegate>{
	
	UITextView				*textView;
	UIImagePickerController *imgPicker;
    UIImageView				*imageView;
	UIButton				*imageButton;
	UIButton				*saveButton;
	UIButton				*saveDraftButton;
	//New entry for holding high quality image for the particular object
	UIImage					*highDefImage;
	NSString				*currentFishName;
	NSString				*currentFishDescription;
	double					longitude;
	double					latitude;
	NSString				*imageURL;
	//End
	UITextField				*textField;
	BOOL					 pushedUp;
	//SA_OAuthTwitterEngine	*_engine;
	BOOL					isPhotoUploaded;
	UIView					*loadingView;
	NSString				*lastTempName;
	
	BOOL isTemp;

	CLLocation *currentLocation;
	
	int myCatchCurrentID;
	NSNumber *tempID;
	NSString *tempName;
	int lastTempId;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *imageButton;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIButton *saveDraftButton;
@property (readwrite, assign) BOOL pushedUp;
@property (readwrite, assign) BOOL isTemp;
@property (nonatomic, retain) NSNumber *tempID;
@property (nonatomic, retain) NSString *tempName;
@property (readwrite, assign) BOOL isPhotoUploaded;

@property (nonatomic, copy) UIImage *highDefImage;
@property (nonatomic, retain) NSString *currentFishName;
@property (nonatomic, retain) NSString *currentFishDescription;
@property (readwrite, assign) double longitude;
@property (readwrite, assign) double latitude;
@property (nonatomic, retain) NSString * imageURL;

@property (nonatomic, retain) IBOutlet UITextField *textField;

@property (readwrite, assign) int myCatchCurrentID;
@property (nonatomic, retain) CLLocation *currentLocation;

@property (nonatomic, retain) NSMutableArray *TestArray;

- (void)setViewMovedUp:(BOOL)movedUp;
- (IBAction)addPictureTapped;
- (IBAction)saveTapped;
- (IBAction)emailButtonPressed:(id)sender;
- (void)displayComposerSheet;
- (void)launchMailAppOnDevice;
- (IBAction)hideKeyboardForTextField:(id)sender;
- (IBAction)shareOnFaceBook;
- (IBAction)saveDraft;
- (void)draftButtonTapped;
- (IBAction)textFieldEndEditing;
- (IBAction)twitterButtonPressed;
- (IBAction)alertPhotoNotUploaded;
- (void)showLoadingView;
- (void)hideLoadingView;
- (void)saveValuesInUserDefault;
- (NSString *)getTitleFromUserDefault;
- (NSString *)getDetailFromUserDefault;


@end
