//
//  HttpDownload.h
//  XmlDemo
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDownloadDelegateEx.h"
#import "HttpDownloadIDDelegateEx.h"
#import "ASIHttpRequest.h"
//NSUrlConnection方式
#define DOWNLOAD_NORMAL 0
//第三方库asihttprequest方式
#define DOWNLOAD_ASIHTTPREQUEST 1

//xml文件
#define PARSE_XML 0
//json文件
#define PARSE_JSON 1
@interface HttpDownload : NSObject<NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>
{
    //接收下载完成类的实例指针
    id<HttpDownloadDelegateEx> delegate;
    id<HttpDownloadIDDelegateEx> delegateID;
    //下载数据的方式
    NSInteger mDownloadType;
    //解析数据的方式（数据类型）
    NSInteger mParseType;
    
    //下载数据的地址
    NSString *mUrl;
    
    //系统下载类
    NSURLConnection *mUrlConnection;
    //下载的数据
    NSMutableData * mDownloadData;
    BOOL isID;
}
@property (nonatomic,assign) id<HttpDownloadDelegateEx> delegate;
@property (nonatomic,assign) id<HttpDownloadIDDelegateEx> delegateID;
@property (nonatomic,retain) NSMutableData * mDownloadData;
-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)downloadFromUrl:(NSString*)url;
-(void)downloadFromUrlID:(NSString *)url;
@end
