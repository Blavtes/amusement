//
//  MoveCell.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveCell.h"

@implementation MoveCell
@synthesize moveName;
@synthesize moveCast;
@synthesize moveLanguage;
@synthesize moveYear;
@synthesize moveImage;
@synthesize bgImageView;
@synthesize fgImageView;
@synthesize ratLabel;
@synthesize rating = _rating;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        ratingView = [[RatingView alloc] initWithFrame:CGRectMake(208, 52, 70, 16)] ;
//        ratingView.backgroundColor = [UIColor clearColor];
//        ratingView.rating = 3.2;
//        [self.contentView addSubview:ratingView];
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
    CGRect rect = CGRectMake(108, 68, newWidth, bgImageView.frame.size.height);
    fgImageView.frame = rect;
    NSLog( @"rating is %f ,%@",rating,NSStringFromCGRect(rect));
    fgImageView.clipsToBounds = YES;
    [fgImageView setContentMode:UIViewContentModeTopLeft];
}

- (void)dealloc {
    [moveName release];
    [moveCast release];
    [moveLanguage release];

    [moveYear release];
    [moveImage release];
    [ratLabel release];
    [super dealloc];
}
@end
