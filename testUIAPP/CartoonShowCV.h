//
//  CartoonShowCV.h
//  testUIAPP
//
//  Created by Yong on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartoonShowCV : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *imagUrlArray;
    
    IBOutlet UITableView *myTabelView;
}
@property (nonatomic,retain) NSArray *imagUrlArray;
@property (nonatomic,retain) UITableView *myTabelView;
@end
