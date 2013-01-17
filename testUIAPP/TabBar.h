//
//  TabBar.h
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TabBarProtocol <NSObject>
- (void) didItemSelectedWithIndex:(NSInteger)index;
@end

@interface TabBar : UIView
{
    
}
@property (nonatomic,strong) IBOutlet UIView *bottomView;
@property (nonatomic,strong,setter = setNibFileName:)NSString *nibFileName;
@property (nonatomic,strong) IBOutlet UIView *top;
@property (nonatomic,retain) IBOutletCollection(UIButton)NSArray *itemButtonArray;
@property (nonatomic,assign) id <TabBarProtocol> delegate;
@property (nonatomic,assign,setter = setSelectdIndex:) NSInteger selectedIndex;
- (IBAction)onItemClicked:(id)sender;
@end
