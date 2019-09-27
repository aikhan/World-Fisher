//
//  ImageDownloader.h
//  World Fisher
//
//  Created by Asad Khan on 11/1/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@class ImageDownloader;



@protocol ImageDownloaderDelegate 
- (void)imageDownloader:(ImageDownloader *)downloader didDownloadImage:(UIImage *)image;
- (void)imageDownloader:(ImageDownloader *)downloader didFailWithError:(NSError *)error;
@end


@interface ImageDownloader : NSObject {

	
    id <ImageDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
	
	NSInteger imageHeight;
	NSString *imageURLString;
}


@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, copy) NSString *imageURLString;

- (void)startDownload;
- (void)cancelDownload;

@end
