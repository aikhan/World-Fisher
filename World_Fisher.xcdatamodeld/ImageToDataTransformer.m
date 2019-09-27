//
//  ImageToDataTransformer.m
//  World-Fisher
//
//  Created by Asad Khan on 12/26/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "ImageToDataTransformer.h"


@implementation ImageToDataTransformer


+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value {
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
	return [uiImage autorelease];
}

@end
