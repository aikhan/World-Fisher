//
//  InformationViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 2/15/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SKBounceAnimation.h"

@interface InformationViewController : UIViewController {
		AVAudioPlayer *audioPlayer;
  IBOutlet UIView *buttonView;
}

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

- (IBAction) glossaryTapped;
- (IBAction) creditsTapped;
- (IBAction) aboutusTapped;
- (void)playSound;
@property (retain, nonatomic) IBOutlet UIButton *glossaryAnim;
@property (retain, nonatomic) IBOutlet UIButton *craditAnim;
@property (retain, nonatomic) IBOutlet UIButton *aboutAnim;
@end
