//
//  FishObjectModel.m
//  World-Fisher
//
//  Created by Asad Khan on 2/6/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import "FishObjectModel.h"


@implementation FishObjectModel

@synthesize scientificName;
@synthesize familyName;
@synthesize fishRange;
@synthesize habitat;
@synthesize adultSize;
@synthesize identification;
@synthesize howToFish;

- (void)dealloc
{
	[scientificName release];
	[familyName release];
	[fishRange release];
	[habitat release];
	[adultSize release];
	[identification release];
	[howToFish release];
	[super dealloc];
}


@end
