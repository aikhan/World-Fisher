//
//  CellView.m
//  Scamster
//
//  Created by Qaisar on 3/6/2557 BE.
//  Copyright (c) 2557 Qaisar. All rights reserved.
//

#import "CellView.h"

@implementation CellView
@synthesize name,backgroundImage,img;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.name=[[UILabel alloc]init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
