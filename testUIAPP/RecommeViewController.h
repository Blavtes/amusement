//
//  RecommeViewController.h
//  testUIAPP
//
//  Created by qianfeng on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TabBar.h"
#import "RecommeTabBar.h"
@interface RecommeViewController : UIViewController<RecommeTabBarProtocol>
{
    NSMutableArray *_subControllers;
}
@property (strong,nonatomic) UIViewController *currentController;
@property (strong,nonatomic) IBOutlet UIView *contentView;
@property (strong,nonatomic) IBOutlet RecommeTabBar *tabBar;
- (void) didItemSelectedWithIndex:(NSInteger)index;
@end
