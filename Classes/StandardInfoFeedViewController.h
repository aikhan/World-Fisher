//
//  StandardInfoFeedViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 12/26/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StandardInfoFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
	
	NSURL					*url;
	UIView					*loadingView;

	NSMutableArray			*richListArray;
	NSOperationQueue		*downloadQueue;
	UITableView				*myTableView;
	NSString				*responseString;
	//New members
	UIImageView				*imageView;
	UIToolbar				*toolbar;
	NSMutableArray			*dataArray;
	NSString				*urlString;
	
#ifdef UNIT_TESTING
	BOOL requestFinished;
	BOOL requestFailed;
	int rowCount;
	BOOL networkAvailable;
	
#endif
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *richListArray;
@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSOperationQueue *downloadQueue;
@property (assign, getter=isReloading) BOOL reloading;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSString *urlString;





#ifdef UNIT_TESTING

@property (nonatomic) BOOL requestFinished;
@property (nonatomic) BOOL requestFailed;
@property (nonatomic,readwrite) int rowCount;
@property (nonatomic) BOOL networkAvailable;

#endif



- (void)reloadFeed;
- (void)fetchURLData;
- (void)showLoadingView;
- (void)hideLoadingView;
- (void)loadDataFromCoreData;
- (void)showNavigationBar;

#ifdef UNIT_TESTING
- (NSString *)loadResponseFromFile;
#endif

@end
