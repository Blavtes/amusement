//
//  MusicCell.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicCell : UITableViewCell

{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *authorLabel;
    IBOutlet UILabel *pubDate;
    
    IBOutlet UILabel *publisher;
    IBOutlet UIImageView *coverImageView;
    
    IBOutlet UIImageView *bgImageView;
    IBOutlet UIImageView *fgImageView;
    float _rating;
    
    IBOutlet UILabel *ratLabel;
}
@property (assign) float rating;
@property (retain,nonatomic) IBOutlet UIImageView *bgImageView;
@property (retain,nonatomic) IBOutlet UIImageView *fgImageView;
@property (retain,nonatomic) IBOutlet UILabel *ratLabel;
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UILabel *authorLabel;
@property (nonatomic,retain) IBOutlet UIImageView *coverImageView;
@property (nonatomic,retain) IBOutlet UILabel *publisher;
@property (nonatomic,retain) IBOutlet UILabel *pubDate;
@end