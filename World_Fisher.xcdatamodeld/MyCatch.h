//
//  MyCatch.h
//  World-Fisher
//
//  Created by Asad Khan on 12/26/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ImageDownloader.h"


@interface MyCatch :  NSManagedObject <ImageDownloaderDelegate>
{
	ImageDownloader *downloader;
}

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitute;
@property (nonatomic, retain) NSString * catchDetails;
@property (nonatomic, retain) NSString * catchName;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSManagedObject * image;
@property (nonatomic, retain) NSNumber * mID;
@property (nonatomic, retain) NSString * fbimageURL;

- (void)downloadImage;
-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height;//Lets resize these damn images

@end
