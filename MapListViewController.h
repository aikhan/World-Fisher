//
//  MapListViewController.h
//  World-Fisher
//
//  Created by Qaisar on 4/10/2557 BE.
//
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface MapListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
  
    NSMutableArray *fishArray;
	
	NSString *responseString;
    NSURL *url;
	NSOperationQueue *downloadQueue;
    DetailViewController *detailViewController;

}
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain) NSMutableArray *fishArray;

@property (nonatomic, retain) NSString *responseString;

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSOperationQueue *downloadQueue;


@property (nonatomic, retain) DetailViewController *detailViewController;
@property (nonatomic)double lati;
@property (nonatomic)double longi;
@property(nonatomic,retain)NSString *fisName;
- (void)fetchURLData;
@end
