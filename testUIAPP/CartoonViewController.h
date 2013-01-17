//
//  CartoonViewController.h
//  testUIAPP
//
//  Created by Yong on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartoonDownloadDelegate.h"
#import "CartoonHttpDownLoad.h"
@interface CartoonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CartoonDownloadDelegate>
{
    IBOutlet UITableView *mXibTableView;
    
    NSArray *array;
    UIImageView *arrowView;
    UILabel *refreshLabel;
    NSMutableArray *imageArray;
    NSMutableArray *subArray;
    CartoonHttpDownLoad *httpdownload;
    //    NSMutableArray *arrayData;
    
}
@property (nonatomic,retain) NSMutableArray *subArray;
@property (nonatomic,retain) NSArray *array;
@property (nonatomic,retain) IBOutlet UITableView *mXibTableView;
@end
