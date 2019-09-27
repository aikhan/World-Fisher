//
//  CoreDataDAO.h
//  World Fisher
//
//  Created by Asad Khan on 12/17/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GameFish;
@class MyCatch;
@class Temp;

//DAO class
@interface CoreDataDAO : NSObject {	

}	

+(GameFish *) fishAddNewFish;
+(NSArray*) fishGetFishListWithError:(NSError**)error;
+(void) fishRemoveAllFish;
+(int) numberOfRows;
+(void) fishAddImage:(UIImage *)image ForGameFish:(GameFish *)gameFish;
+(void) fishAddThumbnailImage:(UIImage *)image ForGameFish:(GameFish *)gameFish;
+(int) fishFetchTopRecordID;
+(GameFish *) fishAddNewFishWithID:(NSNumber *)myFishID;
+(GameFish *) fishFetchFishWithID:(NSNumber *)fishID withError:(NSError**)error;


+(MyCatch *) myCatchFetchMyCatchWithName:(NSString *)catchName withError:(NSError**)error;
+(NSArray *) myCatchGetMyCatchListWithError:(NSError**)error;
+(void) myCatchRemoveMyCatch:(MyCatch *)myCatch;
+(void) myCatchRemoveAllMyCatchItems;
+(MyCatch *) myCatchAddMyCatch;
+(void) myCatchAddImage:(UIImage *)image ForMyCatch:(MyCatch *)myCatch;
+(MyCatch *) myCatchAddNewCatchWithID:(NSNumber *)myCatchID;
+(MyCatch *) myCatchFetchMyCatchWithID:(NSNumber *)myCatchID withError:(NSError**)error;
+(int) myCatchFetchTopRecordID;


+(Temp *) tempFetchMyCatchWithName:(NSString *)catchName withError:(NSError**)error;
+(NSArray *) tempGetMyCatchListWithError:(NSError**)error;
+(void) tempRemoveMyCatch:(Temp *)temp;
+(void) tempRemoveAllMyCatchItems;
+(Temp *) tempAddMyCatch;
+(void) tempAddImage:(UIImage *)image ForMyCatch:(Temp *)temp;
+(void) tempAddThumbnailImage:(UIImage *)image ForMyCatch:(Temp *)temp;
+(Temp *) tempAddNewCatchWithID:(NSNumber *)tempID;
+(Temp *) tempFetchMyCatchWithID:(NSNumber *)tempID withError:(NSError**)error;
+(int) tempFetchTopRecordID;


+(void) saveData;

@end
