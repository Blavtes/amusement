//
//  RecommeTabBar.m
//  testUIAPP
//
//  Created by Yong on 12-9-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RecommeTabBar.h"

@interface RecommeTabBar (Private)
- (void) gotoItemWithIndex:(NSInteger)index;
@end
@implementation RecommeTabBar
@synthesize delegate = _delegate;
@synthesize nibFileName = _nibFileName;
@synthesize top;
@synthesize itemButtonArray;
//@synthesize bottomView = _bottomView;
@synthesize selectedIndex = _selectedIndex;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void) setSelectdIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self gotoItemWithIndex:selectedIndex];
}
- (void) setNibFileName:(NSString *)nibFileName
{
    _nibFileName = nibFileName;
    UIView *rootView = [[[NSBundle mainBundle] loadNibNamed:self.nibFileName owner:self options:nil] lastObject];
    [self addSubview:rootView];
}

- (IBAction)onItemClicked:(id)sender
{
    NSLog(@"count %d",[self.itemButtonArray count]);
    for (NSInteger index = 0; index < [self.itemButtonArray count]; index++) {
        UIView  *view = [self.itemButtonArray objectAtIndex:index];
        NSLog(@"index item Is %d count %d view is %@",index,[self.itemButtonArray count],view);
        if (view == sender) {
            [self gotoItemWithIndex:index];
            self.selectedIndex = index;
            break;
        }
    }
    
}
- (void)dealloc {
//    [_bottomView release];
    [top release];
    [super dealloc];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end

@implementation RecommeTabBar (Private)

- (void) gotoItemWithIndex:(NSInteger)index
{
    UIView *view = [self.itemButtonArray objectAtIndex:index];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5f];
    CGRect fram = [view convertRect:view.frame toView:self];//转换坐标值    
//    self.bottomView.frame = fram;
    self.top.frame =fram;
    [UIView commitAnimations];
    [_delegate didItemSelectedWithIndex:index];
}

@end
