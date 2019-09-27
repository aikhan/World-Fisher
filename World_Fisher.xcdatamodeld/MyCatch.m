// 
//  MyCatch.m
//  World-Fisher
//
//  Created by Asad Khan on 12/26/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "MyCatch.h"
#import "World_FisherAppDelegate.h"
#import "CoreDataDAO.h"

UIImage *scaleAndRotateImage(UIImage *image, BOOL isThumbnail);

@implementation MyCatch 

@dynamic latitude;
@dynamic longitute;
@dynamic catchDetails;
@dynamic catchName;
@dynamic imageURL;
@dynamic date;
@dynamic image;
@dynamic mID;
@dynamic fbimageURL;

UIImage *scaleAndRotateImage(UIImage *image, BOOL isThumbnail);
- (void)awakeFromInsert
{
	self.date = [NSDate date];
}

- (void)dealloc
{
	[downloader release];
	[super dealloc];
}

- (void)downloadImage
{
	if ([self.image valueForKey:@"image"])
	{
		return;
	}
	
	if (downloader == nil)
	{
		downloader = [[ImageDownloader alloc] init];
		downloader.delegate = self;
	}
	
	downloader.imageURLString = self.imageURL;
	//downloader.imageHeight = 48;
	
	[downloader startDownload];
}


- (void)imageDownloader:(ImageDownloader *)downloader didDownloadImage:(UIImage *)image
{
	//self.image = image;
	if (image == nil) {
		NSLog(@"image is nil WTF");
	}
	NSLog(@"Hello inside didDownloadImage");
	[CoreDataDAO myCatchAddImage:image ForMyCatch:self];
	//[self rotate(image, UIImageOrientationRight)];
	//[self.image setValue:[self resizeImage:image width:100 height:100] forKey:@"thumbnailImage"];
	UIImage *smallImage = [image copy];
	[self.image setValue:scaleAndRotateImage(smallImage, YES) forKey:@"thumbnailImage"];
	[smallImage release];
	NSNotification* notification = [NSNotification notificationWithName:@"MyCatchImageDownloadComplete" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:notification]; 
}

- (void)imageDownloader:(ImageDownloader *)downloader didFailWithError:(NSError *)error
{
	//self.image = [UIImage imageNamed:@"icon.png"];
	[self.image setValue:[UIImage imageNamed:@"icon.png"] forKey:@"image"];
	
	NSNotification* notification = [NSNotification notificationWithName:@"MyCatchImageDownloadComplete" object:self];
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
UIImage *scaleAndRotateImage(UIImage *image, BOOL isThumbnail)
{
	int kMaxResolution;
    if(isThumbnail){
		kMaxResolution = 75;
	}
	else {
		kMaxResolution = 640;
	}

	
	
    CGImageRef imgRef = image.CGImage;
	
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
	
	NSLog(@"image height : %f, & width : %f", height, width);
	
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
	
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
			
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
			
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
			
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
			
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
			
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
    }
	
    UIGraphicsBeginImageContext(bounds.size);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
	
    CGContextConcatCTM(context, transform);
	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return imageCopy;
}



