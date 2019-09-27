// 
//  GameFish.m
//  World-Fisher
//
//  Created by Asad Khan on 12/27/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "GameFish.h"
#import "CoreDataDAO.h"


@implementation GameFish 

@dynamic identification;
@dynamic imageURL;
@dynamic image;
@dynamic name;
@dynamic mID;

@dynamic scientificName;
@dynamic family;
@dynamic range;
@dynamic habitat;
@dynamic adultSize;
@dynamic howToFish;
@dynamic thumbnailURL;

- (void)dealloc
{
	[downloader release];
	[super dealloc];
}

- (void)downloadImage
{
	if ([self.image valueForKey:@"thumbnailImage"])
	{
		return;
	}
	
	if (downloader == nil)
	{
		downloader = [[ImageDownloader alloc] init];
		downloader.delegate = self;
	}
	
	downloader.imageURLString = self.thumbnailURL;
	NSLog(@"Thumbnail URL in downloader %@", self.thumbnailURL);
    NSLog(@"Fish Name : %@", self.name);
	//downloader.imageHeight = 48;
	
	[downloader startDownload];
}


- (void)imageDownloader:(ImageDownloader *)downloader didDownloadImage:(UIImage *)image
{
	//self.image = image;
	if (image == nil) {
		NSLog(@"image is nil WTF");
        return;
	}
	//[CoreDataDAO fishAddImage:image ForGameFish:self];
	NSLog(@"Message logged");
	[CoreDataDAO fishAddThumbnailImage:image ForGameFish:self];
	//[self.image setValue:image forKey:@"thumbnailImage"];
	//////////////
	//[self.image setValue:[self resizeImage:image width:75 height:75] forKey:@"thumbnailImage"];
	
	NSNotification* notification = [NSNotification notificationWithName:@"FishImageDownloadComplete" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:notification]; 
}

- (void)imageDownloader:(ImageDownloader *)downloader didFailWithError:(NSError *)error
{
	//self.image = [UIImage imageNamed:@"icon.png"];
	[self.image setValue:[UIImage imageNamed:@"icon.png"] forKey:@"image"];
	
	NSNotification* notification = [NSNotification notificationWithName:@"FishImageDownloadComplete" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}
-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height {
	
	CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	//if (alphaInfo == kCGImageAlphaNone)
	alphaInfo = kCGImageAlphaNoneSkipLast;
	
	CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;
}
@end
