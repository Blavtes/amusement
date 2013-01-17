//
//  UIAViewController.h
//  UIA
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class UIAViewController;
@protocol UIAViewControllerdelegate <NSObject>
- (void) setMainTitleWithDelegate:(UIAViewController*)delegate;
@end
@interface UIAViewController : UIViewController 
{
	UIImageView *addview;

	int  currenttag;
    id <UIAViewControllerdelegate>delegate;
}
@property (nonatomic,assign) int currenttag;
@property (nonatomic,assign) id<UIAViewControllerdelegate>delegate;
@property (nonatomic,retain) UIViewController *currentController;
-(void)Clickup:(NSInteger)tag;
-(NSInteger)getblank:(NSInteger)tag;
-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num;

@end

