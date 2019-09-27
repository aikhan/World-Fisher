//
//  FacebookViewController.h
//  Christmas Countdown
//
//  Created by Asad Khan on 26/11/2012.
//  Copyright (c) 2012 Semantic Notion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"

@protocol FacebookLoginDelegate;

@interface fbViewController : UIViewController<FBLoginViewDelegate>{
    BOOL isAlreadyLoggedIn;
    
    UIImage *fbImageURL;
    NSString *fishDescription;
    NSString *catchName;
}


@property (nonatomic, retain) UIImage *fbImageURL;
@property (nonatomic, retain) NSString *fishDescription;
@property (nonatomic, retain) NSString *catchName;



- (IBAction)shareImage;



@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UIButton *buttonPostStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelFirstName;
@property (strong, nonatomic) IBOutlet UIButton *buttonPostPhoto;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;

@property (nonatomic,assign) NSObject<FacebookLoginDelegate> *delegate;

@property (retain) MBProgressHUD *hud;
- (IBAction)dismissTapped:(id)sender;

@end

@protocol FacebookLoginDelegate

- (void)FacebookControllerWillDissmiss:(BOOL)isLoggedIn;

@end

