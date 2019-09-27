//
//  StandardInfoFeedModelObject.h
//  Twitterrific
//
//  Created by Asad Khan on 03/09/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"

@interface StandardInfoFeedModelObject : NSObject <ImageDownloaderDelegate> 
{
	ImageDownloader *downloader;
}

@property (nonatomic, copy) NSString *modelObjectID;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, retain) UIImage *thumbnailImage;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *rightText;

- (void)downloadImage;
- (BOOL)saveThumbnailImageToDisk;
- (UIImage *)getThumbnailImageFromDisk;

+ (BOOL)checkReachabilityForHost:(NSString *)host;

@end
