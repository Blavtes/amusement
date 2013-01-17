//
//  SohuVideoViewController.h
//  LoveBeeAudioVisual
//
//  Created by liuyan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SohuVideoViewController : UIViewController<UIWebViewDelegate,
MBProgressHUDDelegate>
{
    UIWebView *_webView;
    MBProgressHUD *_HUD;
    NSURLRequest *_urlRequest;
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,retain) NSURLRequest *urlRequest;

- (void)backPress;

@end
