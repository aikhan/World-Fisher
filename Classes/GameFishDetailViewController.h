//
//  GameFishDetailViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 2/1/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"


@interface GameFishDetailViewController : UIViewController <UIScrollViewDelegate>{

	UIScrollView *scrollView;
	UIButton *bigFishButton;
	UIImage *downloadedImage;
	NSOperationQueue *downloadQueue;

	
	UILabel *commonNameLabel;
	UILabel *scientificNameLabel;
	UILabel *familyLabel;
	UILabel *rangeLabel;
	UILabel *habitatLabel;
	UILabel *adultSizeLabel;
	UILabel *identificationLabel;
	UILabel *howToFishLabel;
	
	UITextView *identificationTextView;
	UITextView *howToFishTextView;
	
	
	
}
@property (retain, nonatomic) IBOutlet UILabel *four;
@property (retain, nonatomic) IBOutlet UILabel *third;
@property (retain, nonatomic) IBOutlet UILabel *second;
@property (retain, nonatomic) IBOutlet UILabel *first;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIButton *bigFishButton;
@property (retain, nonatomic) NSOperationQueue *downloadQueue;
@property (retain, nonatomic) UIImage *downloadedImage;
@property (retain, nonatomic)  NSMutableArray *Temp;

@property (retain, nonatomic) IBOutlet UILabel *commonNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *scientificNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *familyLabel;
@property (retain, nonatomic) IBOutlet UILabel *rangeLabel;
@property (retain, nonatomic) IBOutlet UILabel *habitatLabel;
@property (retain, nonatomic) IBOutlet UILabel *adultSizeLabel;
@property (retain, nonatomic) IBOutlet UILabel *identificationLabel;
@property (retain, nonatomic) IBOutlet UILabel *howToFishLabel;

@property (retain, nonatomic) IBOutlet UITextView *identificationTextView;
@property (retain, nonatomic) IBOutlet UITextView *howToFishTextView;

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *myspiner;


- (IBAction) bigFishButtonTapped;
@end
