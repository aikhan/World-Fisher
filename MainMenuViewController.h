//
//  MainMenuViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 12/18/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SKBounceAnimation.h"
@class MapViewController;
@class MyCatchViewController;
@class GameFishViewController;
@class InformationViewController;
@class animatedButton;

@interface MainMenuViewController : UIViewController{
	AVAudioPlayer *audioPlayer;
	MapViewController *mapViewController;
	MyCatchViewController *infoFeedController;
	GameFishViewController *gameFishController;
	InformationViewController *informationViewController;
   IBOutlet UIView *buttonView;
    IBOutlet animatedButton *infoButton;
    IBOutlet animatedButton *infoButton1;
    IBOutlet animatedButton *infoButton2;
    IBOutlet animatedButton *infoButton3;

}
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) MapViewController *mapViewController;
@property (nonatomic, retain) MyCatchViewController *infoFeedController;
@property (nonatomic, retain) GameFishViewController *gameFishController;
@property (nonatomic, retain) InformationViewController *informationViewController;
@property(nonatomic,strong)UIButton *myButton;
@property(nonatomic,strong)UIButton *restore;
- (IBAction)buttonTapped:(id)sender;
- (void)hideNavigationBar;
- (void)playSoundForButton:(id)sender;
-(void)removeAd;
-(void)reStore;
@property (retain, nonatomic) IBOutlet UIButton *myCatchButtonAnim;

@property (retain, nonatomic) IBOutlet UIButton *gameFishAnim;

@property (retain, nonatomic) IBOutlet UIButton *infoAnim;

@property (retain, nonatomic) IBOutlet UIButton *mapAnim;

@end
