//
//  MyCatchDraftViewController.h
//  World-Fisher
//
//  Created by Asad Khan on 1/10/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyCatchDraftViewController : UIViewController {
	UITableView				*myTableView;
	NSMutableArray			*richListArray;
	
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *richListArray;

- (void)loadDraftDataFromCoreData;
@end
