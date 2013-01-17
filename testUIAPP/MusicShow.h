//
//  MusicShow.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicShow : UITableViewCell
{
    float _rating;
}
@property (nonatomic,assign) float rating;
@property (retain, nonatomic) UILabel *name;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *author;
@property (retain, nonatomic) IBOutlet UILabel *ratingLabel;
@property (retain, nonatomic) IBOutlet UILabel *publisher;
@property (retain, nonatomic) IBOutlet UILabel *pubDate;
@property (retain, nonatomic) IBOutlet UIImageView *fgImageView;
@property (retain, nonatomic) IBOutlet UIImageView *bgImageView;
@end
