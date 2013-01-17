//
//  NewsViewController.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@class HttpParser;



@interface NewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
#define XML_ 0 
{
    HttpParser *nHttpParse;
    NSInteger curPage;
    NSInteger perCount;
    NSInteger totalCount;
    BOOL isLoading;
    
    dispatch_queue_t quene;

    
}


@property (retain, nonatomic) IBOutlet UITableView *myTableView;
- (void) lodingData;
CGFloat BNRTimeBlock(void (^block)(void));
@end
