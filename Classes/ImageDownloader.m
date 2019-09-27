//
//  ImageDownloader.m
//  World Fisher
//
//  Created by Asad Khan on 11/1/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//


#import "ImageDownloader.h"


@implementation ImageDownloader


@synthesize delegate;
@synthesize activeDownload;
@synthesize imageConnection;
@synthesize imageHeight;
@synthesize imageURLString;

#pragma mark

- (void)dealloc
{
    [activeDownload release];
    [imageConnection cancel];
    [imageConnection release];
	[imageURLString release];
    
    [super dealloc];
}

- (void)startDownload
{
	if(imageConnection)
	{
		return;
	}
	
	
    self.activeDownload = [NSMutableData data];
    // alloc+init and start an NSURLConnection; release on completion/failure
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:
                             [NSURLRequest requestWithURL:
                              [NSURL URLWithString:imageURLString]] delegate:self];
    self.imageConnection = conn;
	//force to start on main thread.
//	if (![NSThread isMainThread])
//	{
//		[self performSelectorOnMainThread:@selector(startDownload)
//							   withObject:nil waitUntilDone:NO];
//		return;
//	}
    [conn release];
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.activeDownload = nil;
    self.imageConnection = nil;
	
	[delegate imageDownloader:self didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	UIImage *image;
	
   
    UIImage *downloadedImage = [[UIImage alloc] initWithData:self.activeDownload];

	
	/*
    if(downloadedImage.size.width != imageHeight && downloadedImage.size.height != imageHeight)
	{
        CGSize itemSize = CGSizeMake(kAppIconHeight, kAppIconHeight);
		UIGraphicsBeginImageContext(itemSize);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[downloadedImage drawInRect:imageRect];
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
    }
    else
    {
        image = downloadedImage;
    }*/
	
	image = downloadedImage;
	 
    
    self.activeDownload = nil;
    self.imageConnection = nil;
	
	[delegate imageDownloader:self didDownloadImage:image];
	[downloadedImage release];
}


@end
