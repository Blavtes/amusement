//
//  NewsCell.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
{
    IBOutlet UILabel *newsTtile;

    IBOutlet UILabel *newsDate;
}
@property (retain, nonatomic) IBOutlet UILabel *newsTtile;
@property (retain, nonatomic) IBOutlet UILabel *newsDate;

@end
