//
//  World_FisherAppDelegate.h
//  World-Fisher
//
//  Created by Asad Khan on 12/18/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@class Temp;
@class LoadingView;
@interface World_FisherAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate> {
    
    UIWindow *window;
	UINavigationController *navigationController;
	
	//For Location Manager
	CLLocationManager    *locationManager;
	CLLocation           *startingPoint;
	CLLocation *currentPosition;
	NSDate *locationManagerStartDate;
	UIImage *image;
    LoadingView *loadingView;
    NSMutableArray * animatingImages;
    UIImageView * splashPage;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    
    
}

@property(nonatomic,retain) NSMutableArray * animatingImages;

@property(nonatomic,retain) UIImageView * splashPage;

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *startingPoint;
@property (retain, nonatomic) CLLocation *currentPosition;
@property (retain, nonatomic) NSDate *locationManagerStartDate;
@property (retain, nonatomic) UIImage *image;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UIActivityIndicatorView*	m_ctrlThinking;
@property (nonatomic, retain) LoadingView *loadingView;

@property (retain, nonatomic)NSString *userID;


- (void)insertTempIntoMyCatch;
- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)uploadTempCatchWithObject:(Temp *)temp;
- (BOOL)isValidLocation:(CLLocation *)newLocation withOldLocation:(CLLocation *)oldLocation;
-(void)removeSplash;

/**
 @brief show loading view
 */
- (void) showLoadingView;
/**
 @brief sets the text to show in loading view
 @param text - text to show
 */
-(void) setLoadingViewText:(NSString *)text;
/**
 @brief stop loading view
 */
- (void) stopLoadingView;

-(void) showThreadedLoadingView;

-(void) stopThreadedLoadingView;
-(void)loadingViewRetunToDefault;
@end

