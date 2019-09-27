//
//  GameFish.h
//  World-Fisher
//
//  Created by Asad Khan on 12/27/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ImageDownloader.h"


@interface GameFish :  NSManagedObject<ImageDownloaderDelegate>
{
	ImageDownloader *downloader;
}
@property (nonatomic, retain) NSString * identification;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSManagedObject * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * mID;
@property (nonatomic, retain) NSString *scientificName;
@property (nonatomic, retain) NSString *family;
@property (nonatomic, retain) NSString *range;
@property (nonatomic, retain) NSString *habitat;
@property (nonatomic, retain) NSString *adultSize;
@property (nonatomic, retain) NSString *howToFish;
@property (nonatomic, retain) NSString *thumbnailURL;
- (void)downloadImage;
-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height;
@end



