//
//  BookCell.m
//  DoubanDemo1
//
///  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "BookCell.h"

@implementation BookCell

@synthesize bgImageView;
@synthesize fgImageView;
@synthesize ratLabel;
@synthesize rating = _rating;
@synthesize titleLabel,authorLabel,publisher,coverImageView,price;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (float) rating
{
    return _rating;
}
- (void) setRating:(float)rating
{
    _rating = rating;
    CGFloat newWidth = bgImageView.frame.size.width*rating/10.0f;
    CGRect rect = CGRectMake(126, 96, newWidth, bgImageView.frame.size.height);
    fgImageView.frame = rect;
    NSLog( @"rating is %f ,%@",rating,NSStringFromCGRect(rect));
    fgImageView.clipsToBounds = YES;
    [fgImageView setContentMode:UIViewContentModeTopLeft];
}
- (void)dealloc {
    [price release];
    [super dealloc];
}
@end
