//
//  FishObjectModel.h
//  World-Fisher
//
//  Created by Asad Khan on 2/6/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandardInfoFeedModelObject.h"

@interface FishObjectModel : StandardInfoFeedModelObject {
	
}
@property (nonatomic, copy)NSString *scientificName;
@property (nonatomic, copy)NSString *familyName;
@property (nonatomic, copy)NSString *fishRange;
@property (nonatomic, copy)NSString *habitat;
@property (nonatomic, copy)NSString *adultSize;
@property (nonatomic, copy)NSString *identification;
@property (nonatomic, copy)NSString *howToFish;
@end
