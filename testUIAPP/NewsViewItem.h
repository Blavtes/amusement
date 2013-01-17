//
//  NewsViewItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface NewsViewItem : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *nwTitle;
    NSString *url;
    NSMutableString *content;
    
}
@property (nonatomic,retain) NSMutableString *content;
@property (nonatomic,retain) NSString *url;
@property (retain, nonatomic) IBOutlet UILabel *author;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *nwTitle;


@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@end
