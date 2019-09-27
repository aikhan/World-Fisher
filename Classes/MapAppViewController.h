//
//  MapAppViewController.h
//  MapApp
//
//  Created by Anam on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkPlaceMark.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "Fish.h"


@interface MapAppViewController : UIViewController  <MKMapViewDelegate, CLLocationManagerDelegate, NSXMLParserDelegate>{
	MKMapView *mapView;
	MKPlacemark *mPlacemark;
	CLLocationCoordinate2D location;
	CLLocationCoordinate2D locations;
	CLLocationManager *locationManager;
	
	NSXMLParser *catchFishParser;
	 NSURLConnection *connectionInProgress;
	NSMutableData *xmlData;
	
	NSMutableArray *fishes;
	//ParkPlaceMark *placemarks;
	Fish *afish;
	NSString *currentKey;
	NSMutableString *currentElementValue;
	
	 NSMutableArray *mapAnnotations;

	
}


@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic,retain) Fish *afish;
@property (nonatomic,retain) NSMutableArray *fishes;

- (void)parseUrl:(NSString *)url;
- (void)beginParsing:(NSURL *)xmlUrl;
@end

