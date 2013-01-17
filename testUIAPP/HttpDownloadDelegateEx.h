//
//  HttpDownloadDelegateEx.h
//  XmlDemo
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpDownload;
@protocol HttpDownloadDelegateEx <NSObject>

//下载完成协议方法
-(void)httpDownloadComplete:(HttpDownload*)download;
//-(void)downloadCompleteID:(HttpDownload*)download;
@end
