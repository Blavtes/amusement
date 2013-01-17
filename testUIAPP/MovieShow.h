//
//  MovieShow.h
//  testUIAPP
//
//  Created by Yong on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface MovieShow : UITableViewCell

{
    IBOutlet UIImageView *image;
    IBOutlet UILabel *name;
    IBOutlet UILabel *cast;
    IBOutlet UILabel *language;
    IBOutlet UILabel *year;
    IBOutlet UILabel *director;
    IBOutlet UILabel *duration;
    IBOutlet UILabel *types;
    NSString *titles;
}
@property (nonatomic,retain) NSString *titles;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *cast;
@property (retain, nonatomic) IBOutlet UILabel *language;
@property (retain, nonatomic) IBOutlet UILabel *year;

@property (retain, nonatomic) IBOutlet UILabel *director;
@property (retain, nonatomic) IBOutlet UILabel *duration;
@property (retain, nonatomic) IBOutlet UILabel *types;
- (IBAction)playerMovie:(id)sender;
@end
