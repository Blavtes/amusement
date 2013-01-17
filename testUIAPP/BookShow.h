//
//  BookShow.h
//  testUIAPP
//
//  Created by Yong on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface BookShow : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *author;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *publisher;
@property (retain, nonatomic) IBOutlet UILabel *pubDate;

@end
