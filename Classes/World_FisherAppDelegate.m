//
//  World_FisherAppDelegate.m
//  World-Fisher
//
//  Created by Asad Khan on 12/18/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "World_FisherAppDelegate.h"
#import "splashView.h"
#import "CoreDataDAO.h"
#import	"MyCatch.h"
#import "Temp.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "JSON.h"
#import "NSArray+ReplaceNull.h"
#import "LoadingView.h"

#import "RevMobAds/RevMobAds.h"
#import "SNAdsManager.h"

#import "LocalNotificationManager.h"

@implementation World_FisherAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize locationManager, startingPoint, currentPosition, locationManagerStartDate, image;
@synthesize loadingView;
@synthesize animatingImages,m_ctrlThinking;
@synthesize splashPage,userID;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    NSLog(@"app did finish launching");
    
    //...............................
    

    
    
    [self copyDataFile];
    
    
	
//    if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) 
//	{
//		NSLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
//	}
// 
//
    
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    
    UIImage * animatingImage = [UIImage imageNamed :@"Default1.png"];
    UIImageView *splashBg = [[UIImageView alloc] initWithImage:animatingImage];
    splashBg.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    [self.window addSubview: splashBg];
    [self.window bringSubviewToFront:splashBg];
    [splashBg release];
    
    self.animatingImages = [[NSMutableArray alloc] init];
    
    
    animatingImage=[UIImage imageNamed :@"final0001.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0002.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0003.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0004.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0005.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0006.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0007.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0008.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0009.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0010.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0011.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0012.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0013.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0014.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0015.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0016.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0017.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0018.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0019.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0020.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0021.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0022.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0023.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0024.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0025.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0026.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0027.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0028.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0029.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0030.png"];
    [self.animatingImages addObject:animatingImage];
    
    
    animatingImage=[UIImage imageNamed :@"final0031.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0032.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0033.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0034.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0035.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0036.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0037.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0038.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0039.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0040.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0041.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0042.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0043.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0044.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0045.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0046.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0047.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0048.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0049.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0050.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0051.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0052.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0053.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0054.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0055.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0056.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0057.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0058.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0059.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0060.png"];
    
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0061.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0062.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0063.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0064.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0065.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0066.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0067.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0068.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0069.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0070.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0071.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0072.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0073.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0074.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0075.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0076.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0077.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0078.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0079.png"];
    [self.animatingImages addObject:animatingImage];
    
    animatingImage=[UIImage imageNamed :@"final0080.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0081.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0082.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0083.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0084.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0085.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0086.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0087.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0088.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0089.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0090.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0091.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0092.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0093.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0094.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0095.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0096.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0097.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0098.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0099.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0100.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0101.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0102.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0103.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0104.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0105.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0106.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0107.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0108.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0109.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0110.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0111.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0112.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0113.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0114.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0115.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0116.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0117.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0118.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0119.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0120.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0121.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0122.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0123.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0124.png"];
    [self.animatingImages addObject:animatingImage];
    animatingImage=[UIImage imageNamed :@"final0125.png"];
    [self.animatingImages addObject:animatingImage];   

    
    
    
	[self insertTempIntoMyCatch];
    
    self.splashPage = [[UIImageView alloc] init];
	self.splashPage.frame = CGRectMake(0, 0, animatingImage.size.width, animatingImage.size.height);
    self.splashPage.animationImages = [self.animatingImages retain];  
    self.splashPage.animationDuration = 10.0;         
    self.splashPage.animationRepeatCount = 1;       
    [self.splashPage startAnimating];
    
   // [self.window addSubview:self.splashPage];
  //  [self.window bringSubviewToFront:self.splashPage];
    
     NSLog(@"images added to window");
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:5.0];
    
    [window makeKeyAndVisible];
    
    
    return YES;
}
//------------------------------------------------------------------------------


- (void) copyDataFile {
    
	NSString *documentsDir = [self getPlistFilePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDir isDirectory:NO])  {
        [[NSFileManager defaultManager] createFileAtPath:documentsDir contents:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PersonData" ofType:@"plist"]] attributes:Nil];
       
        NSLog(@"%@",documentsDir);
     
        
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        [(NSString *)uuidStr autorelease];
        self.userID =  (NSString *)uuidStr;
        NSLog(@"ID: %@",self.userID);
       
        NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
        [temp setValue:self.userID forKey:@"uniqueid"];
        
        [temp writeToFile:documentsDir atomically:YES];
        
    }
    else{
       NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:documentsDir];
        self.userID=[dic objectForKey:@"uniqueid"];
        
        
       // self.audio_List = [[NSMutableArray alloc]initWithArray:array];
       // [self.audio_List writeToFile:documentsDir atomically:YES];
    }
    
}



- (NSString *) getPlistFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
    documentsDir = [documentsDir stringByAppendingPathComponent:@"PersonData.plist"];
    return documentsDir;
}


//------------------------------------------------------------------------------
-(void)removeSplash {
    
    
    [self.splashPage stopAnimating];
    [window addSubview:navigationController.view];
    
    if ([CLLocationManager locationServicesEnabled]) {
		self.locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
		locationManager.distanceFilter = 1.0;
		[locationManager startUpdatingLocation];
		self.locationManagerStartDate = [NSDate date];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Location services disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
#ifdef PaidApp
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setBool:1 forKey:@"com.semanticnotion.worldfisherfree.removeads"];
    [[SNAdsManager sharedManager]giveMePaidFullScreenAd];
    
#endif
    

#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]giveMeBootUpAd];
    
#endif

}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation {
    if (startingPoint == nil)
        self.startingPoint = newLocation;
    if ([self isValidLocation:newLocation withOldLocation:oldLocation]) {
		self.currentPosition = newLocation;
	}
	else {
		//  self.currentPosition = nil;
        
		NSLog(@"Bad location Data");
	}
	//NSLog(@"Decide latitute  : %g", newLocation.coordinate.latitude);
//	NSLog(@"Decide longitude : %g", newLocation.coordinate.longitude);
}

- (BOOL)isValidLocation:(CLLocation *)newLocation
		withOldLocation:(CLLocation *)oldLocation
{
    // Filter out nil locations
    if (!newLocation)
    {
        return NO;
    }
    
    // Filter out points by invalid accuracy
    if (newLocation.horizontalAccuracy < 0)
    {
        return NO;
    }
    
    // Filter out points that are out of order
    NSTimeInterval secondsSinceLastPoint =
	[newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    
    if (secondsSinceLastPoint < 0)
    {
        return NO;
    }
    
    // Filter out points created before the manager was initialized
    NSTimeInterval secondsSinceManagerStarted =
	[newLocation.timestamp timeIntervalSinceDate:locationManagerStartDate];
    
    if (secondsSinceManagerStarted < 0)
    {
        return NO;
    }
    
    // The newLocation is good to use
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager 
       didFailWithError:(NSError *)error {
    
    NSString *errorType = (error.code == kCLErrorDenied) ? 
    @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Error getting Location" 
                          message:errorType 
                          delegate:nil 
                          cancelButtonTitle:@"Okay" 
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}

- (void)insertTempIntoMyCatch{
	NSArray *tempArray = [[NSArray alloc] initWithArray:[CoreDataDAO tempGetMyCatchListWithError:nil]];
	
	for (Temp *temp in tempArray) {
		NSLog(@"uploadOnNextStart : %@", temp.uploadOnNextStart);
		if ([temp.uploadOnNextStart isEqualToString:@"YES"]) {
			NSLog(@"Try saving data on server");
			[self uploadTempCatchWithObject:temp];
			self.image = [temp.image valueForKey:@"image"];
			if (!self.image) {
				NSLog(@"self image is null");
				if ([temp.image valueForKey:@"thumbnailImage"]) {
					NSLog(@"got data from thumbnail");
					self.image = [temp.image valueForKey:@"thumbnailImage"];
				}
			}
			NSLog(@"details : %@", temp.catchDetails);
			NSLog(@"Catch name : %@", temp.catchName);
			NSLog(@"URL : %@", temp.imageURL);
			NSLog(@"lat : %@", [temp.latitude stringValue]);
			NSLog(@"long : %@", [temp.longititue stringValue]);
		//myCatch.catchDetails = temp.catchDetails;
		//myCatch.catchName = temp.catchName;
		//myCatch.image = temp.image;
		//myCatch.imageURL = temp.imageURL;
		//myCatch.latitude = temp.latitude;
		//myCatch.longitute = temp.longititue;
			//[CoreDataDAO tempRemoveMyCatch:temp];
		}
	}
	
	[tempArray release];
}

- (void)uploadTempCatchWithObject:(Temp *)temp{
    static int countme = 0;
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    World_FisherAppDelegate *dele=(World_FisherAppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *uniqueIdentifier = dele.userID;
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:WorldFisherUploadURL]];
	[request setPostValue:temp.catchDetails forKey:@"mycatch_detail"];
	[request setPostValue:uniqueIdentifier forKey:@"udid"];
	[request setPostValue:temp.catchName forKey:@"mycatch_name"];
    NSLog(@"long000 = %@", [temp.longititue stringValue]);
    //log all values to be uploaded
    if (!(temp.latitude == 0)) {
        [request setPostValue:[[temp.longititue stringValue] substringToIndex:8] forKey:@"long"];
        [request setPostValue:[[temp.latitude stringValue] substringToIndex:8]  forKey:@"lat"];  
    }
    else{
        [request setPostValue:@"0.0" forKey:@"long"];
        [request setPostValue:@"0.0"  forKey:@"lat"];
    }
    NSLog(@"longitude in delegate : %@", [[temp.longititue stringValue] substringToIndex:8] );
    NSLog(@"latitude in delegate : %@", [[temp.latitude stringValue] substringToIndex:8]);
    NSLog(@"catch details : %@",temp.catchDetails );
    NSLog(@"catch details : %@",temp.catchName );
	if ([temp.image valueForKey:@"image"]) {
		NSLog(@"image is not empty");
	}
	[request setData:UIImageJPEGRepresentation(self.image, 0.3) forKey:@"image"];
	[request setDelegate:self];
	[request startAsynchronous];
	[pool release];
    countme++;
    NSLog(@"count me in %d", countme);
	
}
- (void)requestFinished:(ASIHTTPRequest *)request
{

	static int count = 0;
	
	NSString *responseString = [request responseString];
	NSLog(@"%@", responseString);
	if ([responseString isEqualToString:@"error"] && count < 3) {
		count ++;
		NSLog(@"%d", count);
        NSLog(@"ERROR returned trying to upload again");
//		[self insertTempIntoMyCatch];
        [self performSelector:@selector(insertTempIntoMyCatch) withObject:nil afterDelay:3.0];
		return;
	}
	else if ([responseString isEqualToString:@"error"] && count >= 3) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error connecting to server. \nApplication will try so synch catch information on next start up" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	count = 0;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Your draft catch information has been successfully saved on your phone & server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];

	NSMutableString *mstring = [NSMutableString stringWithString:responseString];
    NSRange newRange = NSMakeRange(0, [mstring length]);
	
    [mstring replaceOccurrencesOfString: @"\n"
							 withString: @""
								options: 0
								  range: newRange];
	
    responseString = [NSString stringWithString: mstring];;
	NSLog(@"\n\n\n\n Without new line %@", mstring);
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
	for(NSDictionary *dic in array)
	{
		
		MyCatch *myCatch = [CoreDataDAO myCatchAddNewCatchWithID:[NSNumber numberWithInt:[[dic valueForKey:@"catch_id"] integerValue]]];
		
		myCatch.catchName = [dic objectForKey:@"catch_name"];
		myCatch.catchDetails = [dic objectForKey:@"catch_details"];
		NSLog(@"%@", myCatch.catchDetails);
		myCatch.latitude = [dic objectForKey:@"latitude"];
		myCatch.longitute = [dic objectForKey:@"longitude"];		
		NSString *imageURLString = [dic objectForKey:@"image"];
		imageURLString = [imageURLString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"imgURL = %@", imageURLString);
		NSRange subStrRange = [imageURLString rangeOfString:@"http:"];
		BOOL myBool =  (subStrRange.location != NSNotFound);
		if(!myBool)
		{
			imageURLString = [NSString stringWithFormat:@"http://%@", imageURLString];
			NSLog(@"NSLOGGED URL = %@", imageURLString);
		}
		myCatch.imageURL = imageURLString;
		myCatch.fbimageURL = [[dic objectForKey:@"fb_image"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		[CoreDataDAO myCatchAddImage:self.image ForMyCatch:myCatch];
		[myCatch.image setValue:[myCatch resizeImage:self.image width:75 height:75] forKey:@"thumbnailImage"];
		Temp *temp = [CoreDataDAO tempFetchMyCatchWithName:myCatch.catchName withError:nil];
        if(!temp){
            NSLog(@"OMG no temp in temp table");
            return;
        }
		[CoreDataDAO tempRemoveMyCatch:temp];	
		[CoreDataDAO saveData];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{

	NSError *error = [request error];
	NSLog(@"This is the error %@", [error description]);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error : %@ \n Request timeout. Server may be too busy \n Application will try to re-sync on the next startup or you can manually try uploading info from the My Catch section"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    LocalNotificationManager *localnotification = [[LocalNotificationManager alloc] initWithMessage:@"World Fisher!! Lets start Fishing.."];
    [localnotification release];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
#ifdef FreeApp
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	if (![userDefaults boolForKey:@"com.semanticnotion.worldfisherfree.removeads"])
        [[SNAdsManager sharedManager]giveMeBootUpAd];
    
#endif
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self insertTempIntoMyCatch];
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"World_Fisher" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"World_Fisher.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}



- (void)dealloc {
    [loadingView release];
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    [image release];
	[navigationController release];
	[currentPosition release];
	[startingPoint release];
	[locationManager release];
	[locationManagerStartDate release];
    [window release];
    [super dealloc];
}


#pragma mark -
#pragma LoadingView Methods

/**
 @brief show loading view
 */
-(void) showLoadingView
{
	[NSThread detachNewThreadSelector:@selector(showThreadedLoadingView) toTarget:self withObject:nil];
//    [self performSelectorOnMainThread:@selector(showThreadedLoadingView) withObject:nil waitUntilDone:NO];
}

/**
 @brief stop loading view
 */
-(void) stopLoadingView
{
	[NSThread detachNewThreadSelector:@selector(stopThreadedLoadingView) toTarget:self withObject:nil];
//    [self performSelectorOnMainThread:@selector(stopThreadedLoadingView) withObject:nil waitUntilDone:NO];
}

/**
 @brief show thread loading view 
 */
-(void) showThreadedLoadingView
{
	NSAutoreleasePool *pooled = [[NSAutoreleasePool alloc] init];
    NSLog(@"loadingView %@", (loadingView.hidden ? @"YES" : @"NO"));
    if(YES)
	{
        NSLog(@"inside loading view");
		loadingView.hidden = NO;
        [window addSubview:self.loadingView];
		[self loadingViewRetunToDefault];
		
		[window bringSubviewToFront:loadingView];
        [self performSelector:@selector(stopLoadingView) withObject:nil afterDelay:3.0];
	}
	[pooled release];
}

/**
 @brief sets the text to show in loading view
 @param text - text to show
 */
-(void) setLoadingViewText:(NSString *)text
{
	
	[NSThread detachNewThreadSelector:@selector(setThreadedLoadingViewText:) toTarget:self withObject:text];
//    [self performSelectorOnMainThread:@selector(setThreadedLoadingViewText:) withObject:nil waitUntilDone:NO];
    
}

/**
 @brief sets the text to show in loading view on thread
 @param text - text to show
 */
-(void) setThreadedLoadingViewText:(NSString*)text
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[loadingView changeMessage:text];
	[pool release];
	return;
	
}
/**
 @brief display stop thread loading view 
 */
-(void) stopThreadedLoadingView
{
	NSAutoreleasePool *pooled = [[NSAutoreleasePool alloc] init];
	if(loadingView.hidden == NO)
	{
        NSLog(@"Stop loading view");
		loadingView.hidden = YES;
		[loadingView returnToDefault];
        if (loadingView) {
            [window sendSubviewToBack:loadingView];
        }
		
	}
	[pooled release];
}


/**
 @brief return loading view to default
 */
-(void)loadingViewRetunToDefault
{
	[loadingView returnToDefault];
}
@end

