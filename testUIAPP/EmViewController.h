//
//  ViewController.h
//  GXScrollToolbar2
//
//  Created by Yong on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"

@interface EmViewController : UIViewController <UIScrollViewDelegate, MyLabelDelegate> {
    UIImageView *selectBackgroudView;
    NSInteger currentTag;
    NSMutableArray *labelArray;
    NSMutableArray *_subControllers;
}
@property (strong,nonatomic) UIViewController *currentController;
@property (strong,nonatomic) UIView *contentView;
@end
