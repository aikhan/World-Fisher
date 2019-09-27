//
//  RichListCell.h
//  UIStandardization
//
//  Created by Asad Khan on 11/1/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandardInfoFeedModelObject.h"


@interface RichListCell : UITableViewCell {

	UILabel				*Title;
	UILabel				*Text;
	UILabel				*RightText;
	UIImageView			*profileImage;
	UIActivityIndicatorView *scrollingWheel;
	UIImageView			*backgroundImageView;
	
	
	StandardInfoFeedModelObject *modelObject;

}

@property (nonatomic,retain) UILabel		*Title;
@property (nonatomic,retain) UILabel		*Text;
@property (nonatomic,retain) UILabel		*RightText;
@property (nonatomic,retain) UIImageView	*profileImage;
@property (nonatomic, retain) UIActivityIndicatorView *scrollingWheel;
@property (nonatomic, retain) StandardInfoFeedModelObject *modelObject;
@property (nonatomic,retain) UIImageView	*backgroundImageView;

- (void)updateCell;
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
