//
//  FishDetailImageController.h
//  MapApp
//
//  Created by Anam on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FishDetailImageController : UIViewController<UIScrollViewDelegate> {

	UIImageView *detailImage;
	UIImage *image;
	UIScrollView *scrollView;
  float ratio;
}

@property(nonatomic,retain) IBOutlet UIImageView *detailImage;
@property(nonatomic,retain) IBOutlet UIImage *image;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;

@end
