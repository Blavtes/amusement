//
//  SignShowItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignItem.h"
@interface SignShowItem : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    SignItem *item;
    
}
@property (nonatomic,retain) SignItem *item;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end
