#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface ParkPlaceMark : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
//	NSString *calloutTitle;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//@property (nonatomic, readonly) NSString *calloutTitle;
@property (nonatomic, copy)	NSString *title;
@property (nonatomic, copy)	NSString *subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
-(id)initWithLat:(double)c lon:(double)d;
//- (NSString *)subtitle;
//- (NSString *)title;


@end
