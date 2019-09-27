//
//  StandardInfoFeedModelObject.m
//  Twitterrific
//
//  Created by Asad Khan on 03/09/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "StandardInfoFeedModelObject.h"
#import "NetworkReachability.h"


@implementation StandardInfoFeedModelObject

@synthesize modelObjectID;
@synthesize titleText;
@synthesize text;
@synthesize rightText;
@synthesize thumbnailImage;
@synthesize thumbnailURL;

- (void)dealloc
{
	[modelObjectID release];
	[titleText release];
	[text release];
	[rightText release];
	[thumbnailURL release];
	[thumbnailImage release];
	[downloader release];
	[super dealloc];
}


#pragma mark -
#pragma mark Image  methods

- (void)downloadImage
{
	if(self.thumbnailImage)
	{
		return;
	}
	
	
	NSString *hostName = [[NSURL URLWithString:thumbnailURL] host];
	if([StandardInfoFeedModelObject checkReachabilityForHost:hostName])
	{
		if(downloader == nil)
		{
			downloader = [[ImageDownloader alloc] init];
			downloader.delegate = self;
		}
		
		downloader.imageURLString = self.thumbnailURL;
		downloader.imageHeight = 80;
		
		[downloader startDownload];
	}
	else
	{
		UIImage *savedImage = [self getThumbnailImageFromDisk];
		
		if(savedImage)
		{
			self.thumbnailImage = savedImage;
			NSNotification* notification = [NSNotification notificationWithName:@"ModelObjectImageDownloadComplete" object:self];
			[[NSNotificationCenter defaultCenter] postNotification:notification];
		}
		else
		{
			self.thumbnailImage = [UIImage imageNamed:@"NoImage.png"];
			NSNotification* notification = [NSNotification notificationWithName:@"ModelObjectImageDownloadFailed" object:self];
			[[NSNotificationCenter defaultCenter] postNotification:notification];
		}
	}
}


#pragma mark -
#pragma mark ImageDownloader Delegate methods

- (void)imageDownloader:(ImageDownloader *)downloader didDownloadImage:(UIImage *)image
{
	static int count = 0;
	count++;
	NSLog(@"%d", count);
	NSLog(@"DidDownloadImage delegate method");
	self.thumbnailImage = image;
	
	NSNotification* notification = [NSNotification notificationWithName:@"ModelObjectImageDownloadComplete" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	NSLog(@"Hopefully the image is downloaded");
	//[self saveThumbnailImageToDisk];
}


- (void)imageDownloader:(ImageDownloader *)downloader didFailWithError:(NSError *)error
{
	self.thumbnailImage = [UIImage imageNamed:@"NoImage.png"];
	
	NSNotification* notification = [NSNotification notificationWithName:@"ModelObjectImageDownloadFailed" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}



#pragma mark -
#pragma mark Data save and retreival from disk methods

- (BOOL)saveThumbnailImageToDisk
{
	NSString *imageName = [thumbnailURL lastPathComponent];
	NSString *uniqueAttribute = modelObjectID;
    
	NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@-%@.jpg",uniqueAttribute,imageName]];
	
	BOOL success = [UIImageJPEGRepresentation(thumbnailImage, 1.0) writeToFile:imagePath atomically:YES];
	
	if(success)
		NSLog(@"image saved");
	else
		NSLog(@"error saving image");
	
	return success;
}


- (UIImage *)getThumbnailImageFromDisk
{
	NSString *imageName = [thumbnailURL lastPathComponent];
	NSString *uniqueAttribute = modelObjectID;
	
	NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@-%@.jpg",uniqueAttribute,imageName]];
	
	return [UIImage imageWithContentsOfFile:imagePath];
}



#pragma mark -
#pragma mark Check URL connectivity methods

+ (BOOL)checkReachabilityForHost:(NSString *)host
{
	BOOL isReachable = NO;
	
	NetworkReachability *reachability = [NetworkReachability sharedReachability];
	[reachability setHostName:host];
	NetworkStatus remoteHostStatus = [reachability remoteHostStatus];
	
	
	if(remoteHostStatus == NotReachable)
		isReachable = NO;
	else
		isReachable = YES;
    
	return isReachable;
}



@end
