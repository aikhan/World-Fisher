//
//  Fish.h
//  MapApp
//
//  Created by Anam on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Fish : NSObject {
	double lon;
	double lng;
	NSString *name;
	NSInteger id;
	//NSMutableArray *markers;
	
}
@property (nonatomic,retain) NSString *name;
//@property (nonatomic,retain) NSMutableArray *markers;
@property (nonatomic,readwrite) NSInteger id;
@property (nonatomic,assign) double lat;
@property (nonatomic,assign) double lng;


+ (Fish *)sharedModel;

@end
