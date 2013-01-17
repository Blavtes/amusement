//
//  SignViewController.h
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignDownLoadDelegate.h"
#import "SignShowItem.h"
#import "SignHttpDownload.h"
@interface SignViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SignDownLoadDelegate>
{
    IBOutlet UITableView *myTabelView;
    NSMutableArray *array;
    NSMutableArray *subArray;
    SignShowItem *showItem;
    BOOL isLoading;
//    SignHttpDownload *httpDownload;
}
@property (nonatomic,retain) NSMutableArray *subArray;
@property (nonatomic,retain) NSMutableArray *array;
@end
