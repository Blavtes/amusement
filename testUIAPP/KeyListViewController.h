//
//  KeyListViewController.h
//  XmlDemo
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyListViewController : UITableViewController
{
    NSArray *dataArray;
    //某个类指针
    id delegate;
    //delegate类的某个方法
    SEL method;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic,assign) SEL method;

@property (nonatomic,retain) NSArray *dataArray;
@end
