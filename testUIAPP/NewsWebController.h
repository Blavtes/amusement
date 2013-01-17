//
//  NewsWebController.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface NewsWebController : UIViewController
{
    NSString *_webURL;
    NSString *_newsTitle;
    UIWebView *_webView;
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,retain) NSString *webURL;
@property (nonatomic,retain) NSString *newsTitle;

@end
