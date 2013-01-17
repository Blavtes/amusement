/***************************************************
 文件名称：RootViewController.m
 作   者：刘焱
 创建时间：2012-10-18
 修改历史：2012-10-23
 版权声明：
 ***************************************************/

#import "VideoRootViewController.h"
//#import "RecommendViewController.h" //推荐


#import "QQMusicViewController.h"
#import "SohuVideoViewController.h"
#import "TudouVideoViewController.h"
#import "VideoNewsViewController.h"
#import "YoukuVideoViewController.h"
#import "LeshiVideoViewController.h"
#import "KugouMusicViewController.h"
//#import "NetworkRadioViewController.h"
//#import "RadioStationsListViewController.h"
#import "LiveViewController.h"
//
////#import "PlayListViewController.h"
//#import "CollectListViewController.h"
//#import "MyIDViewController.h"
//#import "SettingViewController.h"
//#import "UserFeedbackViewController.h"

@implementation VideoRootViewController

//@synthesize bottomImageView;
//@synthesize recommendImageView;
//@synthesize channelImageView;
//@synthesize iLoveBeeImageView;
//@synthesize localFilesImageView;
//
//@synthesize channelView;
//@synthesize iLoveBeeView;
//@synthesize localFilesView;

@synthesize souhuVideoV;
@synthesize tudouVideoV;
@synthesize videNewsV;
@synthesize youkuViedeoV;
@synthesize leShiVideoV;
@synthesize qqMusicV;
@synthesize kuGouMusicV;
//@synthesize netWorkRadioV;
//@synthesize _iRadioV;
@synthesize liveV;

//@synthesize playListV;
//@synthesize collectListV;
//@synthesize myIdV;
//@synthesize settingV;
//@synthesize userFeedBackV;

- (void)dealloc
{
//    [bottomImageView release];
//    [recommendImageView release];
//    [channelImageView release];
//    [iLoveBeeImageView release];
//    [localFilesImageView release];
//    
//    [channelView release];
//    [iLoveBeeView release];
//    [localFilesView release];
    
    [souhuVideoV release];
    [tudouVideoV release];
    [videNewsV release];
    [youkuViedeoV release];
    [leShiVideoV release];
    [qqMusicV release];
    [kuGouMusicV release];
//    [netWorkRadioV release];
//    [_iRadioV release];
    [liveV release];
    
//    [playListV release];
//    [collectListV release];
//    [myIdV release];
//    [settingV release];
//    [userFeedBackV release];
     
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"视频";
    
}


/*******************************************
 函数名称：- (void)sohuVideo
 函数功能：进入搜狐视频
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)sohuVideo
{
    if (nil == souhuVideoV) {
        souhuVideoV = [[SohuVideoViewController alloc]init];
    }
    self.view = souhuVideoV.view;
    [self.navigationController presentModalViewController:souhuVideoV animated:YES];
}

/*******************************************
 函数名称：- (void)tudouVideo
 函数功能：进入土豆视频
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)tudouVideo
{
    if (nil == tudouVideoV) {
        tudouVideoV = [[TudouVideoViewController alloc]init];
    }
    self.view = tudouVideoV.view;
    [self.navigationController presentModalViewController:tudouVideoV animated:YES];
}

/*******************************************
 函数名称：- (void)videoNews
 函数功能：进入视频新闻
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)videoNews
{
    if (nil == videNewsV) {
        videNewsV = [[VideoNewsViewController alloc]init];
    }
    self.view = videNewsV.view;
    [self.navigationController presentModalViewController:videNewsV animated:YES];
}

/*******************************************
 函数名称：- (void)youkuVideo
 函数功能：进入优酷视频
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)youkuVideo
{
    if (nil == youkuViedeoV) {
        youkuViedeoV = [[YoukuVideoViewController alloc]init];
    }
    self.view = youkuViedeoV.view;
    [self.navigationController presentModalViewController:youkuViedeoV animated:YES];
}

/*******************************************
 函数名称：- (void)leshiVideo
 函数功能：进入乐视视频
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)leshiVideo
{
    if (nil == leShiVideoV) {
        leShiVideoV= [[LeshiVideoViewController alloc]init];
    }
    self.view = leShiVideoV.view;
    [self.navigationController presentModalViewController:leShiVideoV animated:YES];
}

/*******************************************
 函数名称：- (void)qqMusic
 函数功能：进入QQ音乐
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)qqMusic
{
    if (nil == qqMusicV) {
        qqMusicV = [[QQMusicViewController alloc]init];
    }
    self.view = qqMusicV.view;
    
    [self.navigationController presentModalViewController:qqMusicV animated:YES];
}

/*******************************************
 函数名称：- (void)kugouMusic
 函数功能：进入酷狗音乐
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)kugouMusic
{
    if (nil == kuGouMusicV) {
        kuGouMusicV = [[KugouMusicViewController alloc]init];
    }
    self.view = kuGouMusicV.view;
    
    [self.navigationController presentModalViewController:kuGouMusicV animated:YES];
}

/*******************************************
 函数名称：- (void)networkRadio
 函数功能：进入网络广播
 传入参数：无
 返回 值 ：无
 ********************************************/
//- (void)networkRadio
//{
////    if (nil == netWorkRadioV) {
////        netWorkRadioV = [[NetworkRadioViewController alloc]init];
////    }
////    [self.navigationController pushViewController:netWorkRadioV animated:YES];
//    if (nil == _iRadioV) {
//        _iRadioV = [[RadioStationsListViewController alloc]init];
//    }
//    [self.navigationController pushViewController:_iRadioV animated:YES];
//}

/*******************************************
 函数名称：- (void)live
 函数功能：进入直播
 传入参数：无
 返回 值 ：无
 ********************************************/
- (void)live
{
    NSLog(@"did..");
    if (nil == liveV) {
        NSLog(@".....");
        liveV = [[LiveViewController alloc]init];
    }

    self.view = liveV.view;

    [self.navigationController presentModalViewController:liveV animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (void)playListView
//{
//    if (nil == playListV) {
//        playListV = [[PlayListViewController alloc]init];
//        
//    }
//    [self.navigationController pushViewController:playListV animated:YES];
//}

//- (void)collectListView
//{
//    if (nil == collectListV) {
//        collectListV = [[CollectListViewController alloc]init];
//        
//    }
//    [self.navigationController pushViewController:collectListV animated:YES];
//}

//- (void)myIdView
//{
//    if (nil == myIdV) {
//        myIdV = [[MyIDViewController alloc]init];
//        
//    }
//    [self.navigationController pushViewController:myIdV animated:YES];
//}

//- (void)settingView
//{
//    if (nil == settingV) {
//        settingV = [[SettingViewController alloc]init];
//        
//    }
//    [self.navigationController pushViewController:settingV animated:YES];
//
//}
//
//- (void)userFeedbackView
//{
//    if (nil == userFeedBackV) {
//        userFeedBackV = [[UserFeedbackViewController alloc]init];
//       
//    }
//     [self.navigationController pushViewController:userFeedBackV animated:YES];
//}

- (IBAction)player:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 1) {
        [self leshiVideo];
    }else if(btn.tag == 2){
        [self videoNews];
    }else if(btn.tag == 3){
        [self tudouVideo];
    }else if(btn.tag == 4){
        [self youkuVideo];
    }else if(btn.tag == 5){
        [self qqMusic];
    }else if(btn.tag == 6){
        
    }else if(btn.tag ==
             
             
             
             
             
             
             
             
             
             
             
             
             7){
        [self live];
    }else if(btn.tag == 8){
        [self sohuVideo];
    }else if(btn.tag == 9){
        [self kugouMusic];
    }
}
@end
