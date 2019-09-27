//
//  AddNewCatchViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 12/19/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.

#import <Twitter/Twitter.h>
#import "AddNewCatchViewController.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "CoreDataDAO.h"
#import "MyCatch.h"
#import "MyCatchDraftViewController.h"
#import "Temp.h"
#import "JSON.h"
#import "NSArray+ReplaceNull.h"
#import "World_FisherAppDelegate.h"
#import "fbViewController.h"
//#import "SA_OAuthTwitterEngine.h"
#import "World_FisherAppDelegate.h"
#define kOAuthConsumerKey		@"VhYYebuiRD7RQVYZ4tpj0g"//API Keys for world fisher
#define kOAuthConsumerSecret	@"64k9nkjTtqeigMCBo8ZjIr2PosVtWNRpkGatHSBrM"



UIImage *scaleAndRotateImage(UIImage *image, BOOL isThumbnail);
#define kOFFSET_FOR_KEYBOARD 160.0
#define BUTTON_WIDTH 44.0
#define BUTTON_SEGMENT_WIDTH 51.0
#define CAP_WIDTH 5.0

typedef enum {
	CapLeft          = 0,
	CapMiddle        = 1,
	CapRight         = 2,
	CapLeftAndRight  = 3
} CapLocation;

@interface AddNewCatchViewController (PrivateMethods)
-(UIButton*)woodButtonWithText:(NSString*)buttonText stretch:(CapLocation)location;
-(UIBarButtonItem*)woodBarButtonItemWithText:(NSString*)buttonText;
@end

@implementation AddNewCatchViewController
@synthesize textView, imageButton, imgPicker, saveButton, pushedUp, highDefImage, textField, saveDraftButton, isPhotoUploaded,
currentFishDescription, currentFishName, longitude, latitude, imageURL;
@synthesize myCatchCurrentID, currentLocation, isTemp, tempID, tempName,TestArray;

- (void)dealloc {
    [super dealloc];
	[textView release];
	[imageButton release];
	[imgPicker release];
	[saveButton release];
	[highDefImage release];
	[textField release];
	[saveDraftButton release];
	[currentFishName release];
	[currentFishDescription release];
	[imageURL release];
	[currentLocation release];
	[tempID release];
	[tempName release];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (id) init {
	self = [super init];
	if ([self isMemberOfClass:[AddNewCatchViewController class]]) {
		if (self != nil) {
		}
	}
	return self;
}
#pragma mark -
#pragma mark Twitter 
-(IBAction)twitterButtonPressed{
	if (!isPhotoUploaded) {
		[self alertPhotoNotUploaded];
	}
	else {
        if ([TWTweetComposeViewController canSendTweet])
        {
            TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
            
            [tweetSheet setInitialText:@"#FunniestPics Get more stunning natural #scenery download the #app now from http://www.semanticdevlab.com!"];
           
            NSLog(@"%d", myCatchCurrentID);
/*
            standardFeedObject.text = myCatch.catchDetails;
			standardFeedObject.modelObjectID = [NSString stringWithFormat:@"%d", [myCatch.mID intValue]];
			NSLog(@"Mike %@", standardFeedObject.modelObjectID);
			standardFeedObject.titleText = myCatch.catchName;
			standardFeedObject.rightText = [self convertTimeIntervalToString:myCatch.date];
			standardFeedObject.thumbnailImage = [myCatch.image valueForKey:@"thumbnailImage"];
			standardFeedObject.thumbnailURL = myCatch.imageURL;*/
            
            

            MyCatch *imagecatch=[CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil];
            NSString *name = imagecatch.catchName;
            NSString *url = imagecatch.imageURL;
         
         //  UIImage *image=[UIImage imageWithContentsOfFile:albumTypePath ];
           NSLog(@"name = %@, url = %@", name, url);
           // [tweetSheet addImage:url];
              // [tweetSheet addImage:image];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *albumTypePath = [documentsPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%d.png",[imagecatch.mID intValue]]];
            NSLog(@"%@",albumTypePath);
            UIImage *img=[[UIImage alloc]initWithContentsOfFile:albumTypePath ];
           // NSData *data = UIImagePNGRepresentation(imagecatch.mID);
             [tweetSheet addImage:img];

            [self presentModalViewController:tweetSheet animated:YES];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }

        
        //------------------------------
	//	if (_engine) return;
//		_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
//		_engine.consumerKey = kOAuthConsumerKey;
//		_engine.consumerSecret = kOAuthConsumerSecret;
//
//		UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
		
//	//	if (controller)
//	//		[self presentModalViewController: controller animated: YES];
//		else {
//			NSLog(@"%d", myCatchCurrentID);
//			NSString *name = [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil].catchName;
//			NSString *url = [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil].imageURL;
//			NSLog(@"name = %@, url = %@", name, url);
//	//		[_engine sendUpdate:[NSString stringWithFormat:@"Hey, check out what I caught! %@ %@", name, url]];
//			//TODO: Change this behaviour create a seprate Catch Object & set its properties
//		}
	}
}

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate
//- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
//	NSLog(@"Authenicated for %@", username);
//	[_engine sendUpdate:[NSString stringWithFormat:@"Hey, check out what I caught! %@ %@", 
//						 [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].catchName,
//						 [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].imageURL
//						 ]];
//}
//
//- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
//	NSLog(@"Authentication Failed!");
//}
//
//- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
//	NSLog(@"Authentication Canceled.");
//}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"You have successfully tweeted your catch info" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)alertPhotoNotUploaded{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You will need to first save your catch details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}

#pragma mark -
#pragma mark General Fucntions 

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//myCatchCurrentID =0 ;
	isPhotoUploaded = NO;
	self.imgPicker = [[UIImagePickerController alloc] init];
	self.imgPicker.allowsEditing = YES;
	self.imgPicker.delegate = self;
	self.imgPicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary; //UIImagePickerControllerSourceTypeCamera;
//	self.imgPicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
	/*
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 60)];
	UILabel *fishLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 120, 40)];
	fishLabel.backgroundColor = [UIColor clearColor];
	fishLabel.text = @"World Fisher";
	fishLabel.textAlignment = UITextAlignmentCenter;
	fishLabel.font = [UIFont fontWithName:@"Zapfino" size:14];
	[overlay addSubview:fishLabel];
	[fishLabel release];
	self.imgPicker.cameraOverlayView = overlay;
    [self.imgPicker.cameraOverlayView setFrame:CGRectMake(0, 0, 160, 60)];
	[overlay release];
    */
	self.pushedUp = NO;
    
	self.navigationItem.rightBarButtonItem = [self woodBarButtonItemWithText:@"Draft"];
	UIButton* rightButton = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
	[rightButton addTarget:self action:@selector(draftButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    if (!self.highDefImage) {
       	self.highDefImage = [[UIImage alloc] init];
     }

	self.textView.delegate = self;
    self.textField.text = [[self.TestArray objectAtIndex:0] titleText];
	self.textView.text = [[self.TestArray objectAtIndex:0] text];
	[self.imageButton setImage:[[self.TestArray objectAtIndex:0] thumbnailImage] forState:UIControlStateNormal];

}

-(UIBarButtonItem*)woodBarButtonItemWithText:(NSString*)buttonText
{
	return [[[UIBarButtonItem alloc] initWithCustomView:[self woodButtonWithText:buttonText stretch:CapLeftAndRight]] autorelease];
}

-(UIImage*)image:(UIImage*)image withCap:(CapLocation)location capWidth:(NSUInteger)capWidth buttonWidth:(NSUInteger)buttonWidth
{
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(buttonWidth, image.size.height), NO, 0.0);
	
	if (location == CapLeft)
		// To draw the left cap and not the right, we start at 0, and increase the width of the image by the cap width to push the right cap out of view
		[image drawInRect:CGRectMake(0, 0, buttonWidth + capWidth, image.size.height)];
	else if (location == CapRight)
		// To draw the right cap and not the left, we start at negative the cap width and increase the width of the image by the cap width to push the left cap out of view
		[image drawInRect:CGRectMake(0.0-capWidth, 0, buttonWidth + capWidth, image.size.height - 20)];
	else if (location == CapMiddle)
		// To draw neither cap, we start at negative the cap width and increase the width of the image by both cap widths to push out both caps out of view
		[image drawInRect:CGRectMake(0.0-capWidth, 0, buttonWidth + (capWidth * 2), image.size.height)];
	
	UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resultImage;
}

-(UIButton*)woodButtonWithText:(NSString*)buttonText stretch:(CapLocation)location
{
	UIImage* buttonImage = nil;
	UIImage* buttonPressedImage = nil;
	NSUInteger buttonWidth = 0;
	if (location == CapLeftAndRight)
	{
		buttonWidth = BUTTON_WIDTH;
		buttonImage = [[UIImage imageNamed:@"nav-button.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
		buttonPressedImage = [[UIImage imageNamed:@"nav-button-press.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
	}
	else
	{
		buttonWidth = BUTTON_SEGMENT_WIDTH;
		
		buttonImage = [self image:[[UIImage imageNamed:@"nav-button.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0] withCap:location capWidth:CAP_WIDTH buttonWidth:buttonWidth];
		buttonPressedImage = [self image:[[UIImage imageNamed:@"nav-button-press.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0] withCap:location capWidth:CAP_WIDTH buttonWidth:buttonWidth];
	}
	
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonImage.size.height);
	button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
	button.titleLabel.textColor = [UIColor whiteColor];
	button.titleLabel.shadowOffset = CGSizeMake(0,-1);
	button.titleLabel.shadowColor = [UIColor darkGrayColor];
	
	[button setTitle:buttonText forState:UIControlStateNormal];
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
	button.adjustsImageWhenHighlighted = NO;
	
	return button;
}

- (void)draftButtonTapped{
	//TODO: if drafts is not nil from core data then load the draft view else show alert box saying its empty
    MyCatchDraftViewController *myCatchDraftViewController;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        myCatchDraftViewController = [[MyCatchDraftViewController alloc] initWithNibName:@"MyCatchDraftViewController-ipad" bundle:Nil];
    else
	myCatchDraftViewController = [[MyCatchDraftViewController alloc] initWithNibName:@"MyCatchDraftViewController" bundle:Nil];
	[self.navigationController pushViewController:myCatchDraftViewController animated:YES];
	[myCatchDraftViewController release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)hideKeyboardForTextField:(id)sender{
	[self.textField resignFirstResponder];
	self.textView.text = @"";
	NSLog(@"insiode hidekeyboardfortextfield");
	self.pushedUp = YES;
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
}
#pragma mark TextView Delegate Methods

-(void)textViewDidBeginEditing:(UITextView *)sender
{	
	[self.textField resignFirstResponder];
	[self.textView becomeFirstResponder];	
	self.pushedUp = YES;
	NSLog(@"textviewbegin editing");
    if ([sender isEqual:textView])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)sender{
	[sender resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    NSLog(@"inside shud change");
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [self.textView resignFirstResponder];
        [self setViewMovedUp:NO];
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

#pragma mark textField Delegate Methods

- (IBAction)textFieldEndEditing{
	[self.textField resignFirstResponder];
	NSLog(@"Resign first responder");
}

-(IBAction)addPictureTapped{
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle:@"Select"
								  delegate:self
								  cancelButtonTitle:@"Cancel"
								  destructiveButtonTitle:nil
								  otherButtonTitles:@"Camera", @"Photo Library", nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
	[self.textField resignFirstResponder];
    [self saveValuesInUserDefault];
	//[self presentModalViewController:self.imgPicker animated:YES];	
}
- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == [actionSheet cancelButtonIndex])
	{
		imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	else {
		imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	}
	
		
	NSLog(@"%d", buttonIndex);
	if (buttonIndex == 0 ) {
		imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentModalViewController:self.imgPicker animated:YES];
	}
	else if(buttonIndex == 1){
		imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		[self presentModalViewController:self.imgPicker animated:YES];
	}
	
}
#pragma mark imagePicker Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
	[self.imgPicker dismissModalViewControllerAnimated:YES];
	[self.imageButton setImage:[info objectForKey:@"UIImagePickerControllerEditedImage"] forState:UIControlStateNormal];
	self.highDefImage = [info objectForKey:@"UIImagePickerControllerEditedImage"]; //[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if ([self getDetailFromUserDefault] && [self getTitleFromUserDefault]) {
        self.textField.text = [self getTitleFromUserDefault];
        self.textView.text = [self getDetailFromUserDefault];
        NSLog(@"Picked up data from user defaults");
    }
    self.highDefImage = scaleAndRotateImage(self.highDefImage, NO);
}
//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
      rect.origin.y -= kOFFSET_FOR_KEYBOARD;
       // rect.size.height += kOFFSET_FOR_KEYBOARD;
		self.pushedUp = YES;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
		self.pushedUp = NO;
    }
    self.view.frame = rect;
	
    [UIView commitAnimations];
}



- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	
    if ([textView isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (![textView isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboardForTextField:) 
												 name:UITextViewTextDidBeginEditingNotification object:self.view.window];
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
}

#pragma mark -
#pragma mark Email Methods
-(IBAction)emailButtonPressed:(id)sender
{
    if (!isPhotoUploaded) {
		[self alertPhotoNotUploaded];
	}
	else {
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}

}
#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Hey, look what I caught!"];
	//---------------------!!
    
    MyCatch *imagecatch=[CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil];
    NSString *name = imagecatch.catchName;
    NSString *url = imagecatch.imageURL;
    
    //  UIImage *image=[UIImage imageWithContentsOfFile:albumTypePath ];
    NSLog(@"name = %@, url = %@", name, url);
    // [tweetSheet addImage:url];
    // [tweetSheet addImage:image];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *albumTypePath = [documentsPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%d.png",[imagecatch.mID intValue]]];
    NSLog(@"%@",albumTypePath);
    UIImage *img=[[UIImage alloc]initWithContentsOfFile:albumTypePath ];

    
    
    //---------------------!!
	NSData *myData = UIImagePNGRepresentation(img);
 //NSLog(@"%@",myData);
	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"viewImage"];
	// Fill out the email body text
	NSString *emailBody = @"\n\n\n\n\n\n\n\nWorld Fisher for iPhone";
	[picker setMessageBody:emailBody isHTML:NO];
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	NSLog(@"Entered delegate");
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: saved");
			break;
		case MFMailComposeResultSent:
			NSLog( @"Result: sent");
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Your email has been sent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			break;
		case MFMailComposeResultFailed:
			NSLog( @"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	[controller dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Mail on device
	
// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:someone@example.com&subject=Hey, look what I caught!";
	NSString *body = @"&body=World-Fisher iPhone app";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
#pragma mark -
#pragma mark Save Buttons
- (IBAction)saveTapped{
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	if ([self.textView.text isEqualToString:@""] || [self.textField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to enter appropriate information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		alert.tag = 1;
		[alert release];
		return;
	}
	if (isPhotoUploaded) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have already saved the information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		alert.tag = 2;
		[alert release];
	}
	else {
	[self showLoadingView];
        //[appDelegate showLoadingView];
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		[self.textView resignFirstResponder];
		if (self.pushedUp == YES) {
			[self setViewMovedUp:NO];
		}
		
		if(appDelegate.currentPosition){
			if (!isTemp) {
				self.currentLocation = appDelegate.currentPosition;
				NSLog(@"recieved coordinates lat : %g", appDelegate.currentPosition.coordinate.latitude);
				NSLog(@"recieved coordinates long : %g", appDelegate.currentPosition.coordinate.longitude);
				self.latitude = appDelegate.currentPosition.coordinate.latitude;
				self.longitude = appDelegate.currentPosition.coordinate.longitude;
			}
			else {
				NSLog(@"Location already set for temp just do nothing");
			}
		}
		else {
			if (!isTemp) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Valid GPS Location available \n Your catch details will be saved without any location info" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];

				NSLog(@"NO GPS data available");
			}
			else {
				NSLog(@"Using temp doesnt matter about the current acquisition");
			}

			
		}
    
		World_FisherAppDelegate *dele=(World_FisherAppDelegate*)[UIApplication sharedApplication].delegate;
		NSString *uniqueIdentifier = dele.userID;
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:WorldFisherUploadURL]];
		[request setPostValue:self.textView.text forKey:@"mycatch_detail"];
		[request setPostValue:uniqueIdentifier forKey:@"udid"];
		[request setPostValue:self.textField.text forKey:@"mycatch_name"];
    
		[request setPostValue:[NSString stringWithFormat:@"%f", self.longitude] forKey:@"long"];
		[request setPostValue:[NSString stringWithFormat:@"%f", self.latitude]  forKey:@"lat"];
		[request setData:UIImageJPEGRepresentation(self.highDefImage, 0.3) forKey:@"image"];
  
        //  [request setData:UIImageJPEGRepresentation([UIImage imageNamed:@"bt-shr.png"], 0.3) forKey:@"image"];
		[request setDelegate:self];
		[request startAsynchronous];
		[pool release];
        
       // NSError * error;
	}

}
- (void)showLoadingView
{
  //  if (!loadingView)
  //  {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                  hud.mode = MBProgressHUDModeAnnularDeterminate;
                   hud.labelText = @"Loading";
                 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
//		[self.navigationController setNavigationBarHidden:YES animated:YES];
//        loadingView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        loadingView.opaque = NO;
//        loadingView.backgroundColor = [UIColor darkGrayColor];
//        loadingView.alpha = 0.5;
//		
//        UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        [spinningWheel startAnimating];
//        spinningWheel.center = self.view.center;
//        [loadingView addSubview:spinningWheel];
//        [spinningWheel release];
//    }
//    
//    [self.view addSubview:loadingView];
//}
}
- (void)hideLoadingView
{
	[self.navigationController setNavigationBarHidden:NO animated:YES];
   // [loadingView removeFromSuperview];
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (IBAction)saveDraft{
	NSLog(@"Save Draft");
	if ([self.textView.text isEqualToString:@""] || [self.textField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to enter appropriate information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	self.saveButton.hidden = YES;
	[self.textView resignFirstResponder];
	if (self.pushedUp == YES) {
		[self setViewMovedUp:NO];
	}
	World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
	Temp *temp = [CoreDataDAO tempAddMyCatch];
	temp.catchName = self.textField.text;
	temp.catchDetails = self.textView.text;
	temp.longititue = [NSNumber numberWithDouble:appDelegate.currentPosition.coordinate.longitude];//[NSNumber numberWithDouble:self.longitude];
	temp.latitude = [NSNumber numberWithDouble:appDelegate.currentPosition.coordinate.latitude];// = [NSNumber numberWithDouble:self.latitude];
	if(self.highDefImage != nil){
		[CoreDataDAO tempAddImage:self.highDefImage ForMyCatch:temp];
		
		UIImage *smallImage = [self.highDefImage copy];
		[CoreDataDAO tempAddThumbnailImage:smallImage ForMyCatch:temp];
		
		[smallImage release];
		NSLog(@"saving images");
	}
	lastTempName = temp.catchName;
	lastTempId = [CoreDataDAO tempFetchTopRecordID] + 1;
	temp.mID = [NSNumber numberWithInt:lastTempId];
	[CoreDataDAO saveData];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added to drafts list" 
										  message:@"Would you like the information to be synced automatically on the next startup. You can always edit the information by tapping the draft button above" 
										  delegate:self  
										  cancelButtonTitle:@"No" 
										  otherButtonTitles:@"Yes", nil];
	alert.tag = 3;
	[alert show];
	[alert release];
		
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet.tag == 3) {
	self.saveDraftButton.hidden = YES;
	if (buttonIndex == 0)
	{
		NSLog(@"NOoo");
		//temp.uploadOnNextStart = @"NO";
	}
	else
	{
		NSLog(@"YES");
		Temp *temp = [CoreDataDAO tempFetchMyCatchWithID:[NSNumber numberWithInt:lastTempId] withError:nil];  //[CoreDataDAO tempFetchMyCatchWithName:lastTempName withError:nil];
		NSLog(@"last temp id : %d", lastTempId);
		temp.uploadOnNextStart = @"YES";
		[CoreDataDAO saveData];
		
	}
	[self draftButtonTapped];
	}
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
	// Use when fetching text data
	//TODO:If error returned save information on temp table
	static int count = 0;
	
	NSString *responseString = [request responseString];
	NSLog(@"%@", responseString);
	if ([responseString isEqualToString:@"error"] && count < 3) {
		count ++;
		NSLog(@"%d", count);
		[self saveTapped];
		return;
	}
	else if ([responseString isEqualToString:@"error"] && count >= 3) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error connecting to server. \nPlease try again or save it as a draft" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
//		[self hideLoadingView];
        [appDelegate stopLoadingView];
		return;
	}
	count = 0;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Your catch information has been successfully saved on your phone & server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	isPhotoUploaded = YES;
	self.saveDraftButton.hidden = YES;
	self.saveButton.hidden = YES;
	NSMutableString *mstring = [NSMutableString stringWithString:responseString];
    NSRange newRange = NSMakeRange(0, [mstring length]);
	
    [mstring replaceOccurrencesOfString: @"\n"
							 withString: @""
								options: 0
								  range: newRange];
	
    responseString = [NSString stringWithString: mstring];;
	NSLog(@"\n\n\n\n Without new line %@", mstring);
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
	for(NSDictionary *dic in array)
	{
		
		MyCatch *myCatch = [CoreDataDAO myCatchAddNewCatchWithID:[NSNumber numberWithInt:[[dic valueForKey:@"catch_id"] integerValue]]];
		myCatchCurrentID = [myCatch.mID integerValue];
		myCatch.catchName = [dic objectForKey:@"catch_name"];
		myCatch.catchDetails = [dic objectForKey:@"catch_details"];
		NSLog(@"%@", myCatch.catchDetails);
		myCatch.latitude = [dic objectForKey:@"latitude"];
		myCatch.longitute = [dic objectForKey:@"longitude"];		
		NSString *imageURLString = [dic objectForKey:@"image"];
		imageURLString = [imageURLString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"imgURL = %@", imageURLString);
		NSRange subStrRange = [imageURLString rangeOfString:@"http:"];
		BOOL myBool =  (subStrRange.location != NSNotFound);
		if(!myBool)
		{
			imageURLString = [NSString stringWithFormat:@"http://%@", imageURLString];
			NSLog(@"NSLOGGED URL = %@", imageURLString);
		}
		myCatch.imageURL = imageURLString;
		myCatch.fbimageURL = [[dic objectForKey:@"fb_image"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSLog(@"facebook image = %@", myCatch.fbimageURL);
		[CoreDataDAO myCatchAddImage:self.highDefImage ForMyCatch:myCatch];
		UIImage *copyImage = [self.highDefImage copy];
		//[myCatch.image setValue:[myCatch resizeImage:copyImage width:75 height:75] forKey:@"thumbnailImage"];
		[myCatch.image setValue:self.highDefImage forKey:@"thumbnailImage"];
		[CoreDataDAO saveData];
		[copyImage release];
		/*if ([self isMemberOfClass:[AddNewCatchViewController class]]) {
			<#statements#>
		}
		 */
		if (isTemp) {
			NSLog(@"Inside removing the temp object from coredata");
			NSLog(@"Hola %d", [self.tempID intValue]);
			Temp *temp = [CoreDataDAO tempFetchMyCatchWithName:self.textField.text withError:nil];
			[CoreDataDAO tempRemoveMyCatch:temp];
			[CoreDataDAO saveData];
		}
		//[self hideLoadingView];
        [appDelegate stopLoadingView];
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
		 
	}
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
   NSString *albumTypePath = [documentsPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%d.png",myCatchCurrentID]];
    NSLog(@"%@",albumTypePath);
    NSData *data = UIImagePNGRepresentation(self.highDefImage);
    [[NSFileManager defaultManager] createFileAtPath:albumTypePath contents:data attributes:Nil];

    [appDelegate stopLoadingView];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate stopLoadingView];
	//[self hideLoadingView];
	NSError *error = [request error];
	NSLog(@"This is the error %@", [error description]);
	if (isTemp) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error : Connection Time Out \n Please try again, Error communicating with the server "] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error : Connection Time Out \n Information will be saved in your draft table & will saved to the server automatically on the next start-up"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self saveDraft];
	}
}

#pragma mark -
#pragma mark Social Networking features



- (IBAction)shareOnFaceBook{
	NSLog(@"inside facebook");
	if (!isPhotoUploaded) {
		[self alertPhotoNotUploaded];
	}
	else {
        
        fbViewController *fbController;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
           fbController = [[fbViewController alloc] initWithNibName:@"fbViewController-ipad" bundle:Nil];
        else
            fbController = [[fbViewController alloc] initWithNibName:@"fbViewController" bundle:Nil];
     //----------
//        
        MyCatch *imagecatch=[CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil];
//        NSString *name = imagecatch.catchName;
//        NSString *url = imagecatch.imageURL;
//        
        //  UIImage *image=[UIImage imageWithContentsOfFile:albumTypePath ];
//        NSLog(@"name = %@, url = %@", name, url);
//        // [tweetSheet addImage:url];
//        // [tweetSheet addImage:image];
//        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *albumTypePath = [documentsPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%d.png",[imagecatch.mID intValue]]];
       NSLog(@"%@",albumTypePath);
      UIImage *img=[[UIImage alloc]initWithContentsOfFile:albumTypePath ];
//        // NSData *data = UIImagePNGRepresentation(imagecatch.mID);
//        
//        NSURL *check=[NSURL URLWithString:albumTypePath];
//        
//        NSLog(@"%@",check);
//        
//        
        //-------
        MyCatch *shareCatch = [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil];
        fbController.fbImageURL = img;
        fbController.fishDescription = shareCatch.catchDetails;
        fbController.catchName = shareCatch.catchName;
        [self.navigationController pushViewController:fbController animated:YES];
//        [fbController release];
        /*
		NSLog(@"facebook image : %@", [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].fbimageURL);
		[fbAgent publishFeedWithName:@"World Fisher" captionText:[CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].catchName 
							imageurl:[CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].fbimageURL
							 linkurl:@"http://www.world-fisher.com" userMessagePrompt:@"Post your catch to your facebook wall" 
						 actionLabel:@"Appstore link" actionText:@"Download World Fisher iPhone app" 
						  actionLink:@"http://www.world-fisher.com/fish/"];
         */
		 
		/*NSLog(@"Facebook image : %@", [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].fbimageURL);
		[fbAgent publishFeedWithName:@"World Fisher" captionText:@"My Catch" imageurl:[CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:myCatchCurrentID] withError:nil].fbimageURL linkurl:@"http://www.world-fisher.com" userMessagePrompt:@"My Fish"];
	*/

	}
}
/*
- (void) facebookAgent:(FacebookAgent*)agent requestFaild:(NSString*) message{
	fbAgent.shouldResumeSession = NO;
    
    
}
- (void) facebookAgent:(FacebookAgent*)agent statusChanged:(BOOL) success{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Your catch has been shared on facebook" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}
- (void) facebookAgent:(FacebookAgent*)agent loginStatus:(BOOL) loggedIn{
    NSLog(@"Inside login status");
}
- (void) facebookAgent:(FacebookAgent*)agent dialog:(FBDialog*)dialog didFailWithError:(NSError*)error{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error posting your catch to your profile please try back in a while" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
    NSLog(@"Error diFailFacebook %@", [error description]);
}
 */

#pragma mark -
#pragma mark NSUserDefaults 
-(void)saveValuesInUserDefault{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
    if (standardUserDefaults) {
        [standardUserDefaults setObject:self.textField.text forKey:@"title"];
        [standardUserDefaults setObject:self.textView.text forKey:@"detail"];
        [standardUserDefaults synchronize];
	}
}
-(NSString *)getTitleFromUserDefault{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *title;
    if (standardUserDefaults) {
        title = [standardUserDefaults stringForKey:@"title"];
    }
	return title;
}
-(NSString *)getDetailFromUserDefault{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *detail;
    if (standardUserDefaults) {
        detail = [standardUserDefaults stringForKey:@"detail"];
    }
	return detail;
}

@end
