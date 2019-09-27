#import "ParkPlaceMark.h"

@implementation ParkPlaceMark
@synthesize coordinate, title,subtitle;

/*- (NSString *)subtitle{
	return @"Put some text here";
}
- (NSString *)title{
	return calloutTitle;
}*/

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	//calloutTitle= @"Current Location";
	return self;
}
-(id)initWithLat:(double)c lon:(double)d{
	coordinate.latitude=c;
	coordinate.longitude=d;
	//NSLog(@"%f,%f",c,d);
	//calloutTitle= @"Nearby Location";
	return self;
}
@end
