//
//  RichListCell.m
//  UIStandardization
//
//  Created by Asad Khan on 11/1/10.
//  Copyright 2010 Semantic Notion Inc. All rights reserved.
//

#import "RichListCell.h"


@implementation RichListCell

@synthesize modelObject;
@synthesize Title;
@synthesize Text;
@synthesize RightText;
@synthesize profileImage;
@synthesize scrollingWheel;
@synthesize backgroundImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
       
		
		Title = [self newLabelWithPrimaryColor:[UIColor colorWithRed:0/255.0f green:34/255.0f blue:102/255.0f alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:17.0 bold:YES];
      // [Title setFont:[UIFont fontWithName:@"Arial" size:128.0]];
		Title.backgroundColor = [UIColor clearColor];
		Title.textAlignment = UITextAlignmentLeft; 
		[self.contentView addSubview:Title];
		
		Text = [self newLabelWithPrimaryColor:[UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
		Text.backgroundColor = [UIColor clearColor];
		Text.textAlignment = UITextAlignmentLeft;
		[self.contentView addSubview:Text];
		
		RightText = [self newLabelWithPrimaryColor:[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0] selectedColor:[UIColor orangeColor] fontSize:10.0 bold:YES];
		RightText.backgroundColor = [UIColor clearColor];
		RightText.textAlignment = UITextAlignmentRight;
		[self.contentView addSubview:RightText];
		
		profileImage = [[UIImageView alloc] init];
		[self.contentView addSubview:profileImage];
		
        /*scrollingWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        scrollingWheel.hidesWhenStopped = YES;
        [scrollingWheel startAnimating];
        [self.contentView addSubview:scrollingWheel];
		*/
		/*
		backgroundImageView = [[UIImageView alloc] init];
		UIImage *rowBackground;
		UIImage *selectionBackground;
		rowBackground = [UIImage imageNamed:@"row.png"];//center row single
		selectionBackground = [UIImage imageNamed:@"selectedrow.png"];
		self.backgroundImageView.image = rowBackground;
		[self.contentView addSubview:backgroundImageView];
		*/
        self.accessoryType = UITableViewCellAccessoryNone;
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
	[scrollingWheel release];
	[Title release];
	[Text release];
	[RightText release];
	[profileImage release];
	[modelObject release];
    [super dealloc];
}



- (void)updateCell
{
	CGRect contentRect = self.contentView.bounds;
	
	if (!self.editing) {
		
		CGFloat boundsX = contentRect.origin.x, width = contentRect.size.width;
		CGRect frame;
		
		frame = CGRectMake(boundsX + 70, 5, width - 100, 20);
		Title.frame = frame;
		
		frame = CGRectMake(width - 77, 5, 70, 20);
		RightText.frame = frame;
		
		frame = CGRectMake(boundsX + 70, 28, width - 80, 34);
		Text.frame = frame;
		Text.numberOfLines = 3;
		
		frame = CGRectMake(boundsX + 5, 8, 60, 60);
		profileImage.frame = frame;
		
		scrollingWheel.center = profileImage.center;
	}
	
	Text.text=@"";
	Title.text=@"";
	RightText.text=@"";
	
	
	
	if(modelObject.titleText)
	{
		Title.text = modelObject.titleText;
	}
	if(modelObject.text)
	{
		Text.text = modelObject.text;
	}
	if(modelObject.rightText)
	{
		RightText.text = modelObject.rightText;
	}
	
	
	
	
	if(modelObject.thumbnailImage)
	{
		self.profileImage.image = modelObject.thumbnailImage;
		[scrollingWheel stopAnimating];
	}
	else
	{
		self.profileImage.image = nil;
		//[scrollingWheel startAnimating];
		self.profileImage.image = [UIImage imageNamed:@"empty_fish.png"];
	}
    
}



- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}



@end
