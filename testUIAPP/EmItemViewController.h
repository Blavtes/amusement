//
//  MyRootViewController.h
//  JsonParserDemo
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EMDownloadCompleteDelegate.h"

@interface EmItemViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EMDownloadCompleteDelegate>
{
    IBOutlet UITableView *mXibTableView;
    BOOL isLoding;
    NSMutableArray *array;
    UIImageView *arrowView;
    UILabel *refreshLabel;
}
@property (nonatomic,retain) NSMutableArray *array;
@end
