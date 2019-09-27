//
//  DetailViewController.h
//  MapApp
//
//  Created by Anam on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fish.h"
#import "ParkPlaceMark.h"
#import "ImageDownloader.h"

@interface DetailViewController : UIViewController <ImageDownloaderDelegate>{
	
	UILabel *titleLabel;
	UIButton *fishImageView;
	UIImage *fishImage;
	UITextView *fishDescription;
	NSString *description;
	UIScrollView *imageScroll;
	
	ParkPlaceMark *annotationDetails;
	double Latitude;
	double Longitude;
	
	NSString *latitudeValue;
	
	
	NSXMLParser *catchFishImageParser;
	NSURLConnection *connectionInProgressImage;
	NSMutableData *xmlImageData;
	
	NSMutableString *currentElementValue;
	NSString *newURL;
	
	NSURL *url;
	NSOperationQueue *downloadQueue;
	NSString *imageURLString;
	NSString *responseString;
	
	ImageDownloader *downloader;
	UIView *loadingView;
	UIImage *downloadedImage;
}
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UIButton *fishImageView;
@property (nonatomic,retain)  IBOutlet UIImage *fishImage;
@property (nonatomic,retain) IBOutlet UITextView *fishDescription;
@property(nonatomic,retain) IBOutlet UIScrollView *imageScroll;

@property (nonatomic,retain)NSString *latitudeValue;
@property (nonatomic,retain)NSString *newURL;
@property (nonatomic,retain)NSString *description;
@property (nonatomic,assign) double Latitude;
@property (nonatomic,assign) double Longitude;
@property (nonatomic,retain) ParkPlaceMark *annotationDetails;


@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSOperationQueue *downloadQueue;
@property (nonatomic, retain) NSString *imageURLString;
@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) UIImage *downloadedImage;


- (IBAction)photoTapped;
- (void)fetchURLData;
- (void)loadFishData;

- (void) downloadImage;
- (void) showLoadingView;
- (void) hideLoadingView;

@end
