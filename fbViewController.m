//
//  FacebookViewController.m
//  Christmas Countdown
//
//  Created by Asad Khan on 26/11/2012.
//  Copyright (c) 2012 Semantic Notion. All rights reserved.
//

#import "fbViewController.h"
#import "MBProgressHUD.h"
//#import "illegalPicsAppDelegate.h"
//#import "MMProgressHUD.h"
@interface fbViewController ()
- (void)FacebookControllerWillDissmiss;

@end

//TODO: clean this page
@implementation fbViewController
@synthesize fbImageURL, fishDescription, catchName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error{
    NSLog(@"hello world");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"Name"] isEqualToString:@""])isAlreadyLoggedIn=NO;
    else
        isAlreadyLoggedIn =YES;

          // settingsManager = [SettingsManager sharedManager];
    self.contentSizeForViewInPopover = CGSizeMake(320.0, [UIScreen mainScreen].bounds.size.height);
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    FBLoginView *loginview =
    [[FBLoginView alloc] initWithPublishPermissions:[NSArray arrayWithObject:@"basic_info"] defaultAudience:FBSessionDefaultAudienceEveryone];
    
    
  //  loginview.frame = CGRectMake(7, 288, 307, 48);
    loginview.frame = CGRectOffset(self.buttonPostPhoto.frame, 0, 50);
    for (id obj in loginview.subviews)
    {
        if ([obj isKindOfClass:[UIButton class]])
        {
            UIButton * loginButton =  obj;
            UIImage *loginImage = [UIImage imageNamed:@"silver-button-normal.png"];
            [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
            [loginButton setBackgroundImage:nil forState:UIControlStateSelected];
            [loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            [loginButton sizeToFit];
        }
        if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel * loginLabel =  obj;
            // loginLabel.text = @"Log in to facebook";
            loginLabel.font = self.buttonPostStatus.titleLabel.font;
            //loginLabel.textColor = self.buttonPostStatus.titleLabel.textColor;
            loginLabel.textAlignment = UITextAlignmentCenter;
            loginLabel.frame = CGRectMake(0, 0, 300, 37);
        }
    }
    
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    loginview.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    self.buttonPostPhoto.enabled = YES;
    self.buttonPostStatus.enabled = YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
//    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
//    [MMProgressHUD showWithTitle:@"Loading..." status:@""];

    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSString stringWithFormat:@"%@", [user objectForKey:@"name"]] forKey:@"Name"];
    [defaults synchronize];
    self.labelFirstName.text = [NSString stringWithFormat:@"WellCome   %@", [user objectForKey:@"name"]];//%@", user.first_name,user.last_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
  //  self.profilePic.profileID = user.id;
    self.loggedInUser = user;
//    illegalPicsAppDelegate *appdelegate = [illegalPicsAppDelegate sharedAppDelegate];
//    appdelegate.username = [user objectForKey:@"name"];

    
//    NSString *urlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", user.id];
//    NSData * photo = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//    appdelegate.profilePic = [UIImage imageWithData:photo];
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"profile_pic.png"];
//    
//    UIImage *editedImage = appdelegate.profilePic;
//    NSData *webData = UIImagePNGRepresentation(editedImage);
//    [webData writeToFile:imagePath atomically:YES];
//
//    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:@"ProfilePicLink"];
//    [[NSUserDefaults standardUserDefaults] setObject:appdelegate.username forKey:@"Username"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    if (appdelegate.userID == nil) {
//        [appdelegate generateUniqueID];
//    }
//    [MMProgressHUD dismiss];
 //   [self performSelector:@selector(dismissModalViewController) withObject:Nil afterDelay:2.5];
}

/*
- (void)request:(FBRequest *)request didLoad:(id)result {
    
    NSLog(@"request did load");
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    self.username = [result objectForKey:@"name"];
    
    NSLog(@"name :%@",self.username);
    NSLog(@"picture :%@",[result objectForKey:@"picture"]);
    
    NSData * photo = [NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"picture"]]];
    
    self.profilePic = [UIImage imageWithData:photo];
    
    if (self.userID == nil) {
        [self generateUniqueID];
    }
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"profile_pic.png"];
    
    UIImage *editedImage = self.profilePic;
    NSData *webData = UIImagePNGRepresentation(editedImage);
    [webData writeToFile:imagePath atomically:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:@"ProfilePicLink"];
    [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:@"Username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
*/
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
//    BOOL canShareAnyhow = [FBNativeDialogs canPresentShareDialogWithSession:nil];
    self.buttonPostPhoto.enabled=NO;
    self.profilePic.profileID = nil;
    self.loggedInUser = nil;
    self.labelFirstName.text = @"";//[NSString stringWithFormat:@"WellCome %@ %@", user.first_name,user.last_name];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSString stringWithFormat:@"%@",@""] forKey:@"Name"];
    [defaults synchronize];
}
/*
#pragma mark -

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession reauthorizeWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                                   defaultAudience:FBSessionDefaultAudienceFriends
                                                 completionHandler:^(FBSession *session, NSError *error) {
                                                     if (!error) {
                                                         action();
                                                     }
                                                     //For this example, ignore errors (such as if user cancels).
                                                 }];
    } else {
        action();
    }
    
}
- (IBAction)loginButtonTapped:(id)sender{
    DebugLog(@"Login tapped");
    
    
}

- (IBAction)postStatusUpdateClick:(UIButton *)sender {
    // Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Posting On Facebook...";
    [self performSelector:@selector(timeout:) withObject:nil afterDelay:200.0];
    NSString *message = [NSString stringWithFormat:@"%@", settingsManager.mainViewController.jokeTextView.text];
    
    // if it is available to us, we will post using the native dialog
   /* BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
                                                                    initialText:message
                                                                          image:nil
                                                                            url:nil
                                                                        handler:nil];
    */
    //if (!displayedNativeDialog) {
     /*
        [self performPublishAction:^{
            // otherwise fall back on a request for permissions and a direct post
            [FBRequestConnection startForPostStatusUpdate:message
                                        completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                            
                                            //[self showAlert:message result:result error:error];
                                            [self showNotification:@"Updated Status successfully." withNotificationType:AJNotificationTypeGreen];
                                            self.buttonPostStatus.enabled = YES;
                                            [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        }];
            
            self.buttonPostStatus.enabled = NO;
        }];
    //}
}/
- (void)timeout:(id)arg {
    DebugLog(@"%s", __PRETTY_FUNCTION__);
    _hud.labelText = @"Timeout!";
    _hud.detailsLabelText = @"Please try again later.";
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	_hud.mode = MBProgressHUDModeCustomView;
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    
}
- (void)dismissHUD:(id)arg {
    DebugLog(@"%s", __PRETTY_FUNCTION__);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.hud = nil;
    
}

// Post Photo button handler; will attempt to invoke the native
// share dialog and, if that's unavailable, will post directly
- (IBAction)postPhotoClick:(UIButton *)sender {
    // Just use the icon image from the application itself.  A real app would have a more
    // useful way to get an image.
    // UIImage *img = [UIImage imageNamed:@"Icon-72@2x.png"];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Posting On Facebook...";
    [self performSelector:@selector(timeout:) withObject:nil afterDelay:200.0];
    
    NSString *message = [NSString stringWithFormat:@"%@", settingsManager.mainViewController.jokeTextView.text];
    // if it is available to us, we will post using the native dialog
   /* BOOL displayedNativeDialog = [FBNativeDialogs presentShareDialogModallyFrom:self
                                                                    initialText:message
                                                                          image:settingsManager.mainViewController.screenShot
                                                                            url:nil
                                                                        handler:nil];
    if (!displayedNativeDialog) {
    */
  //  NSAssert(settingsManager.mainViewController.screenShot == nil, @"Photo cannot be nil");
   /*     [self performPublishAction:^{
            
            [FBRequestConnection startForUploadPhoto:settingsManager.mainViewController.screenShot
                                   completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                       [self showAlert:@"Photo Post" result:result error:error];
                                       self.buttonPostPhoto.enabled = YES;
                                   }];
            
            self.buttonPostPhoto.enabled = NO;
        }];
    *///Uncomment this for working photo upload
   // }
/*    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:message forKey:@"message"];
    [params setObject:UIImagePNGRepresentation(settingsManager.mainViewController.screenShot) forKey:@"picture"];
    self.buttonPostPhoto.enabled = NO; //for not allowing multiple hits
    
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
             //showing an alert for failure
            // [self alertWithTitle:@"Facebook" message:@"Unable to share the photo please try later."];
             [self showNotification:@"Unable to share the photo please try later." withNotificationType:AJNotificationTypeRed];
         }
         else
         {
             //showing an alert for success
            // [UIUtils alertWithTitle:@"Facebook" message:@"Shared the photo successfully"];
             [self showNotification:@"Shared the photo successfully." withNotificationType:AJNotificationTypeGreen];
         }
         self.buttonPostPhoto.enabled = YES;
         [NSObject cancelPreviousPerformRequestsWithTarget:self];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
}

- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle = @"Error";
    } else {
        alertMsg = [NSString stringWithFormat:@"Successfully posted."];
        alertTitle = @"Success";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}
- (void)viewDidUnload {
    [self setUserImageView:nil];
    [self setLoginButton:nil];
    
    [self setLabelFirstName:nil];
    [self setMyActivityIndicator:nil];
    [super viewDidUnload];
}
*/
-(void)dismissModalViewController{
    if (!isAlreadyLoggedIn) {
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"Name"] isEqualToString:@""])
        [self.delegate FacebookControllerWillDissmiss:NO];
    else
        [self.delegate FacebookControllerWillDissmiss:YES];
    
    [self dismissModalViewControllerAnimated:YES];
    }

}
- (IBAction)dismissTapped:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"Name"] isEqualToString:@""])
        [self.delegate FacebookControllerWillDissmiss:NO];
    else
        [self.delegate FacebookControllerWillDissmiss:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}
/*
- (void)showNotification:(NSString *)text withNotificationType:(AJNotificationType)AJNotificationTypeSelected{
    [AJNotificationView showNoticeInView:self.view
                                    type:AJNotificationTypeSelected
                                   title:text
                         linedBackground:AJLinedBackgroundTypeAnimated
                               hideAfter:2.5f offset:0.0f delay:0.0f detailDisclosure:NO
                                response:^{
                                    NSLog(@"Response block");
                                }
     ];
}
- (BOOL)isReachable{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(internetStatus == ReachableViaWiFi)
        return YES;
    else if (internetStatus == ReachableViaWWAN)
        return YES;
    else
        return NO;
}*/
-(void)publishStory{
    // Just use the icon image from the application itself.  A real app would have a more
    // useful way to get an image.
    // UIImage *img = [UIImage imageNamed:@"Icon-72@2x.png"];
 //   self.hud = [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
  //  self.hud.labelText = @"Posting On Facebook...";
  //  [self performSelector:@selector(timeout:) withObject:nil afterDelay:200.0];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:self.fishDescription forKey:@"message"];
    [params setObject:UIImagePNGRepresentation(self.fbImageURL) forKey:@"picture"];
       self.buttonPostPhoto.enabled = NO; //for not allowing multiple hits
    
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error)
     {
         if (error)
         {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Uploading Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
             self.hud.labelText = @"Unable to share the photo please try later";
             
         }
         else
         {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Photo successfully shared" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
             self.hud.labelText = @"Photo successfully shared";
             
         }
         [NSObject cancelPreviousPerformRequestsWithTarget:self];
     
       //  [self performSelector:@selector(hideMBHudView) withObject:nil afterDelay:2.0];
     }];
    
}
-(void)requestPublishPermissions{
    [FBSession.activeSession requestNewPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                          defaultAudience:FBSessionDefaultAudienceEveryone
                                        completionHandler:^(FBSession *session, NSError *error) {
                                            if (!error) {
                                                if ([FBSession.activeSession.permissions
                                                     indexOfObject:@"publish_actions"] == NSNotFound){
                                                    
                                                    [[[UIAlertView alloc] initWithTitle:@"Permission not granted"
                                                                                message:@"Your action will not be published to Facebook."
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK!"
                                                                      otherButtonTitles:nil] show];
                                                } else {
                                                    // Permission granted, publish the OG story
                                                    [self publishStory];
                                                }
                                                
                                            } else {
                                                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                NSLog(@"%@",[error description]);
                                                
                                                [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                            message:@"Something goes wrong... plz try later"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK!"
                                                                  otherButtonTitles:nil] show];
                                            }
                                        }];
}
- (void)sharePhoto:(UIImage*)img  {
    
 self.fbImageURL = img;
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  NSDictionary *permissions= [(NSArray *)[result data] objectAtIndex:0];
                                  if (![permissions objectForKey:@"publish_actions"]){
                                      // Publish permissions not found, ask for publish_actions
                                      [self requestPublishPermissions];
                                      
                                  } else {
                                      // Publish permissions found, publish the OG story
                                      [self publishStory];
                                  }
                                  
                              } else {
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                  NSLog(@"%@",[error description]);
                                  [[[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Something goes wrong... plz try later"
                                                             delegate:self
                                                    cancelButtonTitle:@"OK!"
                                                    otherButtonTitles:nil] show];
                              }
                          }];

    
    
}
- (IBAction)shareImage {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Uploading";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self sharePhoto:self.fbImageURL];
}
@end
