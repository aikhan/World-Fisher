//
//  Temp.h
//  World-Fisher
//
//  Created by Asad Khan on 1/29/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Temp :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * longititue;
@property (nonatomic, retain) NSString * uploadOnNextStart;
@property (nonatomic, retain) NSString * catchName;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * mID;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * catchDetails;
@property (nonatomic, retain) NSManagedObject * image;

@end



