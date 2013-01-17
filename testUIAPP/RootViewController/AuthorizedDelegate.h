//
//  cellItemDelegate.h
//  LoveBeeAudioVisual
//
//  Created by liuyan on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthorizedDelegate

@optional

/*******************************************
 函数名称：(void)onCellItem:(int)index  
 函数功能：获取用户单击九宫格的序号，实现此协议时实现
 传入参数：(int)index
 返回 值： N/A
 ********************************************/
- (void)onCellItem:(int)index;

//进入搜狐视频
- (void)sohuVideo;

//进入土豆视频
- (void)tudouVideo;

//进入视频新闻
- (void)videoNews;

//进入优酷视频
- (void)youkuVideo;

//进入乐视视频
- (void)leshiVideo;

//进入QQ音乐
- (void)qqMusic;

//进入酷狗音乐
- (void)kugouMusic;

//进入网络广播
- (void)networkRadio;

//进入直播
- (void)live;

- (void)playListView;

- (void)collectListView;

- (void)myIdView;

- (void)settingView;

- (void)userFeedbackView;

@end
