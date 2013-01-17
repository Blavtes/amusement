//
//  MainViewController.h
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
#import "UIAViewController.h"
@interface MainViewController : UIViewController<TabBarProtocol,UIAViewControllerdelegate>
{
    NSMutableArray *_subViewControllers;
    NSMutableArray *_titleArray;
    UIAViewController *liv;
}
@property (retain, nonatomic) IBOutlet UILabel *mainTitle;
@property (retain, nonatomic) IBOutlet TabBar *tabBar;
@property (retain,nonatomic) NSMutableArray *titleArray;
- (IBAction)onReplyButton:(id)sender;
@property (nonatomic,retain) UIViewController *currentController;
@property (nonatomic,retain) IBOutlet UIView *contentView;
- (void) didItemSelectedWithIndex:(NSInteger)index;

@end
