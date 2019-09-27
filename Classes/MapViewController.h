//
//  MapViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 1/4/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapListViewController.h"
@class Fish;
@class DetailViewController;


@interface MapViewController : UIViewController <MKMapViewDelegate>{
	MKMapView *mapView;
	CLLocationCoordinate2D location;
	NSMutableArray *fishArray;
	
	NSString *responseString;
	NSURL *url;
	NSOperationQueue *downloadQueue;
	NSMutableArray *mapAnnotations;
	
	DetailViewController *detailViewController;
	
	
}
@property (retain)IBOutlet MKMapView *mapView;

@property (assign) CLLocationCoordinate2D location;
@property (retain) NSMutableArray *fishArray;

@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSOperationQueue *downloadQueue;

@property (nonatomic, retain) NSMutableArray *mapAnnotations;

@property (nonatomic, retain) DetailViewController *detailViewController;
@property (nonatomic, retain) MapListViewController *mapList;
@property (strong, nonatomic)UISegmentedControl* segmentedControl;
- (void)fetchURLData;
- (void)loadAnnotationData;
@end
