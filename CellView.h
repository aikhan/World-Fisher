//
//  CellView.h
//  Scamster
//
//  Created by Qaisar on 3/6/2557 BE.
//  Copyright (c) 2557 Qaisar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *name;
@property(nonatomic,strong)IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet UIImageView *img;


@end
