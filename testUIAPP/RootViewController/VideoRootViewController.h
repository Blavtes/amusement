/***************************************************
 文件名称：RootViewController.h
 作   者：刘焱
 创建时间：2012-10-18
 修改历史：2012-10-23
 版权声明：
 ***************************************************/

#import <UIKit/UIKit.h>
#import "AuthorizedDelegate.h"


@class SohuVideoViewController;
@class TudouVideoViewController;
@class VideoNewsViewController;
@class YoukuVideoViewController;
@class LeshiVideoViewController;
@class QQMusicViewController;
@class KugouMusicViewController;
//@class NetworkRadioViewController;
//@class RadioStationsListViewController;
@class LiveViewController;

//@class PlayListViewController;
//@class CollectListViewController;
//@class MyIDViewController;
//@class SettingViewController;
//@class UserFeedbackViewController;


@interface VideoRootViewController : UIViewController<AuthorizedDelegate>
{
//    UIImageView *bottomImageView; //底部导航
//    UIImageView *recommendImageView; //推荐
//    UIImageView *channelImageView; //频道
//    UIImageView *iLoveBeeImageView; //用户
//    UIImageView *localFilesImageView; //本地
    
//    ChannelViewController *channelView;
//    ILoveBeeViewController *iLoveBeeView;
//    LocalFilesViewController *localFilesView;
    
    //进入搜狐视频
    SohuVideoViewController *souhuVideoV;
    //进入土豆视频
    TudouVideoViewController *tudouVideoV;
    //进入视频新闻
    VideoNewsViewController *videNewsV;
    //进入优酷视频
    YoukuVideoViewController *youkuViedeoV;
    //进入乐视影院
    LeshiVideoViewController *leShiVideoV;
    //进入QQ音乐
    QQMusicViewController *qqMusicV;
    //进入酷狗音乐
    KugouMusicViewController *kuGouMusicV;
    //进入网络广播
//    NetworkRadioViewController *netWorkRadioV;
//    //进入网络广播    
//    RadioStationsListViewController* _iRadioV;
    //进入直播
    LiveViewController *liveV;
    
//    PlayListViewController *playListV;
//    CollectListViewController *collectListV;
//    MyIDViewController *myIdV;
//    SettingViewController *settingV;
//    UserFeedbackViewController *userFeedBackV;
    
}

//@property (nonatomic, retain) UIImageView *bottomImageView; //底部导航
//@property (nonatomic, retain) UIImageView *recommendImageView; //推荐
//@property (nonatomic, retain) UIImageView *channelImageView; //频道
//@property (nonatomic, retain) UIImageView *iLoveBeeImageView; //用户
//@property (nonatomic, retain) UIImageView *localFilesImageView; //设置
//
//@property (nonatomic, retain) ChannelViewController *channelView;
//@property (nonatomic, retain) ILoveBeeViewController *iLoveBeeView;
//@property (nonatomic, retain) LocalFilesViewController *localFilesView;

@property (nonatomic, retain) SohuVideoViewController *souhuVideoV;
@property (nonatomic, retain) TudouVideoViewController *tudouVideoV;
@property (nonatomic, retain) VideoNewsViewController *videNewsV;
@property (nonatomic, retain) YoukuVideoViewController *youkuViedeoV;
@property (nonatomic, retain) LeshiVideoViewController *leShiVideoV;
@property (nonatomic, retain) QQMusicViewController *qqMusicV;
@property (nonatomic, retain) KugouMusicViewController *kuGouMusicV;
//@property (nonatomic, retain) NetworkRadioViewController *netWorkRadioV;
//@property (nonatomic, retain) RadioStationsListViewController *_iRadioV;
@property (nonatomic, retain) LiveViewController *liveV;

//@property (nonatomic, retain) PlayListViewController *playListV;
//@property (nonatomic, retain) CollectListViewController *collectListV;
//@property (nonatomic, retain) MyIDViewController *myIdV;
//@property (nonatomic, retain) SettingViewController *settingV;
//@property (nonatomic, retain) UserFeedbackViewController *userFeedBackV;
- (IBAction)player:(id)sender;

@end
