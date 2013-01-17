
//  RecommeTabBar.h
//  testUIAPP
//
//  Created by Yong on 12-9-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecommeTabBarProtocol <NSObject>
- (void) didItemSelectedWithIndex:(NSInteger)index;
@end
@interface RecommeTabBar : UIView
{
    
}
//@property (nonatomic,strong) IBOutlet UIView *bottomView;
@property (nonatomic,strong,setter = setNibFileName:)NSString *nibFileName;
@property (nonatomic,strong) IBOutlet UIView *top;
@property (nonatomic,retain) IBOutletCollection(UIButton)NSArray *itemButtonArray;
@property (nonatomic,assign) id <RecommeTabBarProtocol> delegate;
@property (nonatomic,assign,setter = setSelectdIndex:) NSInteger selectedIndex;
- (IBAction)onItemClicked:(id)sender;
@end
