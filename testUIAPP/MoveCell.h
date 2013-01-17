//
//  MoveCell.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RatingView.h"

@interface MoveCell : UITableViewCell
{
    IBOutlet UILabel *moveName;
    IBOutlet UILabel *moveCast;
    IBOutlet UILabel *moveLanguage;
    
    IBOutlet UILabel *moveYear;
    IBOutlet UIImageView *moveImage;
    IBOutlet UIImageView *bgImageView;
    IBOutlet UIImageView *fgImageView;
    float _rating;

    IBOutlet UILabel *ratLabel;
}
@property (assign) float rating;
@property (retain,nonatomic) IBOutlet UIImageView *bgImageView;
@property (retain,nonatomic) IBOutlet UIImageView *fgImageView;
@property (retain,nonatomic) IBOutlet UILabel *ratLabel;
//@property (retain,nonatomic) RatingView *ratingView;
@property (retain, nonatomic) IBOutlet UILabel *moveName;
@property (retain, nonatomic) IBOutlet UILabel *moveCast;
@property (retain, nonatomic) IBOutlet UILabel *moveLanguage;

@property (retain, nonatomic) IBOutlet UILabel *moveYear;
@property (retain, nonatomic) IBOutlet UIImageView *moveImage;

@end
