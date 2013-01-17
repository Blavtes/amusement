//
//  AppDelegate.h
//  testUIAPP
//
//  Created by qianfeng on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QFDatabase;
#define ShareApp ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //搜索关键字数组
    NSMutableArray *keyArray;
    //数据库
    QFDatabase *mDatabase;
    NSArray *movieDownArray;
}
@property (strong, nonatomic) IBOutlet UIWindow *window;
//@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) QFDatabase *mDatabase;
@property (nonatomic,retain) NSMutableArray *keyArray;
@property (nonatomic,retain) NSArray *movieDownArray;
@end