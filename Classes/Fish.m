//
//  Fish.m
//  MapApp
//
//  Created by Anam on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Fish.h"


@implementation Fish
@synthesize name;
@synthesize id;
@synthesize lat;
@synthesize lng;
//@synthesize markers;
static Fish *sharedModel = nil;

+ (Fish*)sharedModel{
	if(sharedModel == nil){
		sharedModel = [[super allocWithZone:NULL] init];
	}
	return sharedModel;
}

+ (id)allocWithZone:(NSZone *)zone{
	return [[self sharedModel] retain];
}

- (id)copyWithZone:(NSZone *)zone{
	return self;
}

- (id)retain{
	return self;
}

- (NSUInteger)retainCount{
	return NSUIntegerMax;
}

- (void)release{
	//do nothing
}
- (id)autorelease{
	return self;
}

@end
