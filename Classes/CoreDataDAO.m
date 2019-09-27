//
//  CoreDataDAO.m
//  World Fisher
//
//  Created by Asad Khan on 12/17/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//


#import "CoreDataDAO.h"
#import "GameFish.h"
#import "World_FisherAppDelegate.h"
#import "MyCatch.h"
#import "Temp.h"


UIImage *scaleAndRotateImage(UIImage *image, BOOL isThumbnail);
UIImage *scaleAndRotateImageForTemp(UIImage *image, BOOL isThumbnail);

static NSManagedObjectContext *managedObjectContext = nil;


@interface CoreDataDAO ()

+(void) setManagedObjectContext;
+(void) deleteAllObjects: (NSString *) entityDescription;

@end




@implementation CoreDataDAO


#pragma Internal Methods

+(void) setManagedObjectContext
{
	if(managedObjectContext == nil)
	{
		World_FisherAppDelegate *appDelegate = (World_FisherAppDelegate *)[[UIApplication sharedApplication] delegate];
		managedObjectContext = [appDelegate managedObjectContext];
	}
}

+ (void) deleteAllObjects: (NSString *) entityDescription  {
	
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
	
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
	
}

#pragma mark -
#pragma mark Fish methods


+(GameFish *) fishAddNewFish
{
	[self setManagedObjectContext];
	GameFish *newFish = (GameFish *)[NSEntityDescription insertNewObjectForEntityForName:@"GameFish" inManagedObjectContext:managedObjectContext];
	return newFish;
}
+(GameFish *) fishAddNewFishWithID:(NSNumber *)myFishID
{
	if (!myFishID)
		return nil;
	[self setManagedObjectContext];
	GameFish *newFish = [self fishFetchFishWithID:myFishID withError:nil];
	
	if (!newFish)
	{
		newFish = (GameFish *)[NSEntityDescription insertNewObjectForEntityForName:@"GameFish" inManagedObjectContext:managedObjectContext];
	}
	newFish.mID = myFishID;
	return newFish;
}
+(GameFish *) fishFetchFishWithID:(NSNumber *)fishID withError:(NSError**)error
{
	[self setManagedObjectContext];
	
	GameFish *myFish;
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription* fishEntity = [NSEntityDescription entityForName:@"GameFish" inManagedObjectContext:managedObjectContext];
	[request setEntity:fishEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mID == %@",fishID];
	[request setPredicate:predicate];
	
	
	/*NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	*/
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	if ([results count] == 0)
	{
		myFish = nil;
	}
	else
	{
		myFish = [results objectAtIndex:0];
	}
	
	
	return myFish;
	
}
+(NSArray*) fishGetFishListWithError:(NSError**)error{
	
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* fish = [NSEntityDescription entityForName:@"GameFish" inManagedObjectContext:managedObjectContext];
	[request setEntity:fish];
	
	
	 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	 [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	 [sortDescriptor release];
	 
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	return [results count] ? results : nil;
}

+(int)numberOfRows{
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSError *err;
	NSEntityDescription* fish = [NSEntityDescription entityForName:@"GameFish" inManagedObjectContext:managedObjectContext];
	[request setEntity:fish];
	
	NSUInteger count = [managedObjectContext countForFetchRequest:request error:&err];
	if(count == NSNotFound) {
		count = 0;
	}
	[request release];
	return count;
}
+(int) fishFetchTopRecordID{	
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* myFish = [NSEntityDescription entityForName:@"GameFish" inManagedObjectContext:managedObjectContext];
	[request setEntity:myFish];
	[request setFetchLimit:1];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"mID" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:nil];
	[request release];
	
	if ([results count] == 0) {
		return 0;
	}
	else {
		return [[[results objectAtIndex:0] mID] intValue];
	}	
	
}
+(void) fishAddImage:(UIImage *)image ForGameFish:(GameFish *)gameFish{
	
	NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"GameFishImage" inManagedObjectContext:managedObjectContext ];
	gameFish.image = imageEntity;
	[imageEntity setValue:image forKey:@"image"];
}

+(void) fishAddThumbnailImage:(UIImage *)image ForGameFish:(GameFish *)gameFish{
	
	NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"GameFishImage" inManagedObjectContext:managedObjectContext ];
	gameFish.image = imageEntity;
	[imageEntity setValue:image forKey:@"thumbnailImage"];
}

+(void) fishRemoveAllFish
{
	[self setManagedObjectContext];
	[self deleteAllObjects:@"GameFish"];
}

#pragma mark -
#pragma mark MyCatch Methods

+(NSArray *) myCatchGetMyCatchListWithError:(NSError**)error{
	
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* myCatch = [NSEntityDescription entityForName:@"MyCatch" inManagedObjectContext:managedObjectContext];
	[request setEntity:myCatch];
	 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	 [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	 [sortDescriptor release];
	 
	 
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
//	for (MyCatch *catch in results) {
//		NSLog(@"hey catch id : %d", [catch.mID intValue]);
//	}
	
	return [results count] ? results : nil;
	
}
+(int) myCatchFetchTopRecordID{	
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* myCatch = [NSEntityDescription entityForName:@"MyCatch" inManagedObjectContext:managedObjectContext];
	[request setEntity:myCatch];
	[request setFetchLimit:1];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:nil];
	[request release];
	
	if ([results count] == 0) {
		return 0;
	}
	else {
		return [[[results objectAtIndex:0] mID] intValue];
	}	
	
}
+(MyCatch *) myCatchAddMyCatch
{	
	[self setManagedObjectContext];
	MyCatch *newMyCatch = (MyCatch *)[NSEntityDescription insertNewObjectForEntityForName:@"MyCatch" inManagedObjectContext:managedObjectContext];
	
	return newMyCatch;
}

+(void) myCatchRemoveAllMyCatchItems
{
	[self setManagedObjectContext];
	[self deleteAllObjects:@"MyCatch"];
}

+(void) myCatchRemoveMyCatch:(MyCatch *)myCatch{
	
	[self setManagedObjectContext];
	
	[managedObjectContext deleteObject:myCatch];
}
+(MyCatch *) myCatchFetchMyCatchWithName:(NSString *)catchName withError:(NSError**)error
{
	[self setManagedObjectContext];
	
	MyCatch *myCatch;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* myCatchEntity = [NSEntityDescription entityForName:@"MyCatch" inManagedObjectContext:managedObjectContext];
	[request setEntity:myCatchEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", catchName];
	[request setPredicate:predicate];
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	if ([results count] == 0)
	{
		myCatch = nil;
	}
	else
	{
		myCatch = [results objectAtIndex:0];
	}
	
	
	return myCatch;
	
}

+(void) myCatchAddImage:(UIImage *)image ForMyCatch:(MyCatch *)myCatch{
	
	NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"MyCatchImage" inManagedObjectContext:managedObjectContext ];
	myCatch.image = imageEntity;
	[imageEntity setValue:scaleAndRotateImage(image, NO) forKey:@"image"];
	//[imageEntity setValue:image forKey:@"image"];
}

+(MyCatch *) myCatchAddNewCatchWithID:(NSNumber *)myCatchID
{
	if (!myCatchID)
		return nil;
	
	[self setManagedObjectContext];
	
	
	MyCatch *newMyCatch = [self myCatchFetchMyCatchWithID:myCatchID withError:nil];
	
	if (!newMyCatch)
	{
		newMyCatch = (MyCatch *)[NSEntityDescription insertNewObjectForEntityForName:@"MyCatch" inManagedObjectContext:managedObjectContext];
	}
	
	
	newMyCatch.mID = myCatchID;
	
	return newMyCatch;
}
+(MyCatch *) myCatchFetchMyCatchWithID:(NSNumber *)myCatchID withError:(NSError**)error
{
	[self setManagedObjectContext];
	
	MyCatch *myCatch;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* venueEntity = [NSEntityDescription entityForName:@"MyCatch" inManagedObjectContext:managedObjectContext];
	[request setEntity:venueEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mID == %@",myCatchID];
	[request setPredicate:predicate];
	
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	if ([results count] == 0)
	{
		myCatch = nil;
	}
	else
	{
		myCatch = [results objectAtIndex:0];
	}
	
	
	return myCatch;
	
}

#pragma mark -
#pragma mark Temp Catch Methods

+(NSArray *) tempGetMyCatchListWithError:(NSError**)error{
	
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* tempEntity = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:managedObjectContext];
	[request setEntity:tempEntity];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	return [results count] ? results : nil;
	
}

+(Temp *) tempAddMyCatch
{	
	[self setManagedObjectContext];
	Temp *newTemp = (Temp *)[NSEntityDescription insertNewObjectForEntityForName:@"Temp" inManagedObjectContext:managedObjectContext];
	
	return newTemp;
}

+(void) tempRemoveAllMyCatchItems
{
	[self setManagedObjectContext];
	[self deleteAllObjects:@"Temp"];
}

+(void) tempRemoveMyCatch:(Temp *)temp{
	
	[self setManagedObjectContext];
	
	[managedObjectContext deleteObject:temp];
}
+(Temp *) tempFetchMyCatchWithName:(NSString *)catchName withError:(NSError**)error
{
	[self setManagedObjectContext];
	
	Temp *temp;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* tempEntity = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:managedObjectContext];
	[request setEntity:tempEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"catchName == %@", catchName];
	[request setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	if ([results count] == 0)
	{
		temp = nil;
		NSLog(@"Nil no data found with name %@", catchName);
	}
	else
	{
		temp = [results objectAtIndex:0];
	}
	
	
	return temp;
	
}

+(void) tempAddImage:(UIImage *)image ForMyCatch:(Temp *)temp{
	
	NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"TempImage" inManagedObjectContext:managedObjectContext ];
	temp.image = imageEntity;
	[imageEntity setValue:scaleAndRotateImageForTemp(image, NO) forKey:@"image"];
}

+(void) tempAddThumbnailImage:(UIImage *)image ForMyCatch:(Temp *)temp{
	
	NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"TempImage" inManagedObjectContext:managedObjectContext ];
	temp.image = imageEntity;
	UIImage *thumbnailImage = scaleAndRotateImageForTemp(image, NO);
	[imageEntity setValue:thumbnailImage forKey:@"thumbnailImage"];
}

+(Temp *) tempAddNewCatchWithID:(NSNumber *)tempID
{
	if (!tempID)
		return nil;
	
	[self setManagedObjectContext];
	
	
	Temp *newTemp = [self tempFetchMyCatchWithID:tempID withError:nil];
	
	if (!newTemp)
	{
		newTemp = (Temp *)[NSEntityDescription insertNewObjectForEntityForName:@"Temp" inManagedObjectContext:managedObjectContext];
	}
	
	
	newTemp.mID = tempID;
	
	return newTemp;
}
+(Temp *) tempFetchMyCatchWithID:(NSNumber *)tempID withError:(NSError**)error
{
	[self setManagedObjectContext];
	
	Temp *temp;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* tempEntity = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:managedObjectContext];
	[request setEntity:tempEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mID == %@",tempID];
	[request setPredicate:predicate];
	
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:error];
	[request release];
	
	if ([results count] == 0)
	{
		temp = nil;
	}
	else
	{
		temp = [results objectAtIndex:0];
	}
	
	
	return temp;
	
}

+(int) tempFetchTopRecordID{	
	[self setManagedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription* temp = [NSEntityDescription entityForName:@"Temp" inManagedObjectContext:managedObjectContext];
	[request setEntity:temp];
	[request setFetchLimit:1];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	
	NSArray* results =  [managedObjectContext executeFetchRequest:request error:nil];
	[request release];
	
	if ([results count] == 0) {
		return 0;
	}
	else {
		return [[[results objectAtIndex:0] mID] intValue];
	}	
	
}


#pragma mark Saving Data methods

+(void) saveData
{
	NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			
        } 
    }
}



@end