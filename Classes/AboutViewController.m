//
//  AboutViewController.m
//  UIStandardization
//
//  Created by Mac on 5/25/10.
//  Copyright 2010 Home. All rights reserved.
//
#import "CoreDataDAO.h"
#import <Twitter/Twitter.h>
#import "AboutViewController.h"
#import "SNAdsManager.h"
#define tActionSheetOne 1
#define tActionSheetTwo 2

@implementation AboutViewController
@synthesize copyright, emailID, twitter, facebook, message,backgroundImage;; 
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)init {
 if (self = [super initWithNibName:@"AboutViewController" bundle:nil]) {
 
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]  giveMeThirdGameOverAd];
#endif
	self.navigationItem.title = @"About";
	backgroundImage = [UIImage imageNamed:@"mainmenuebg.png"];
	[myImage setImage:backgroundImage];
	[myImage release];
	
	
	copyRightLabel.text	= copyright = @"All Rights Reserved World Fisher";
	emailLabel.text		= emailID = @"info@world-fisher.com";
	twitterLabel.text	= twitter = @"http://www.twitter.com/world-fisher";
	facebookLabel.text	= facebook = @"http://www.facebook.com/world-fisher";
	
	emailLabel.font		= [UIFont systemFontOfSize:15];
	emailLabel.textColor = [UIColor whiteColor];
	
	twitterLabel.font	= [UIFont systemFontOfSize:15];
	twitterLabel.textColor = [UIColor whiteColor];
	
	facebookLabel.font	= [UIFont systemFontOfSize:15];
	facebookLabel.textColor = [UIColor whiteColor];
	[super viewDidLoad];
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
-(IBAction) emailClicked:(id)sender{
	[self showPicker];
	
}
-(void)showPicker
{
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
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


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Query from World Fisher iPhone App"];
	
	
	// Set up recipients
	
	NSArray *toRecipients = [NSArray arrayWithObject:emailID]; 
	
	//NSString *toRecipients = agentEmail_string;
	[picker setToRecipients:toRecipients];	

	
	// Fill out the email body text
	NSString *emailBody = @"Hi From World Fisher iPhone App!";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			NSLog(@"message is =%@",message.text);
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			NSLog(@"message is =%@",message.text);
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	//NSString *recipients = @"mailto:?cc=&subject=Hello from UIStandardization!";
	NSString *recipients = [NSString stringWithFormat:@"mailto:%@?cc=&subject=Query from World Fisher iPhone App!", emailID];
	NSString *body = @"&body=Hi From World Fisher iPhone App";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(IBAction) twitterClicked:(id)sender{
    
//    
//    if ([TWTweetComposeViewController canSendTweet])
//    {
//        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
//        [tweetSheet setInitialText:@"#FunniestPics Get more stunning natural #scenery download the #app now from http://bit.ly/1g3VXZG!"];
//        
// //       Picture * pic = [ _photoInformation objectAtIndex:self.photoAlbumView.centerPageIndex];
//        
////        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:pic.picLink]];
//        
// //       UIImage *image = [UIImage imageWithData:imageData];
//        NSString *name = [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil].catchName;
//        NSString *url = [CoreDataDAO myCatchFetchMyCatchWithID:[NSNumber numberWithInt:self.myCatchCurrentID] withError:nil].imageURL;
//
//        [tweetSheet addImage:url];
//        //   [tweetSheet addURL:[NSURL URLWithString:kAppStoreURL]];
//        
//        [self presentModalViewController:tweetSheet animated:YES];
//    }
//    else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
//                                                            message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }
    
    //////
    	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure to open Twitter?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"YES" otherButtonTitles:nil, nil];
    	actionSheet.tag = tActionSheetOne;
    	[actionSheet showInView:self.view];
    	[actionSheet release];
}
-(IBAction) facebookClicked:(id)sender{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure to open Facebook?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"YES" otherButtonTitles:nil, nil];
	actionSheet.tag = tActionSheetTwo;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (actionSheet.tag == tActionSheetOne)
    {
		if(buttonIndex == 0){
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitter]];
		}
	}
	if (actionSheet.tag == tActionSheetTwo)
    {
		if(buttonIndex == 0){
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:facebook]];
		}
	}
}
- (void)dealloc {
    [super dealloc];
}


@end
