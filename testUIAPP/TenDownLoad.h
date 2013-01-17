//
//  TenDownLoad.h
//  HtmlParserTest
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TenDownLoadDelegate.h"
#import "ASIHTTPRequest.h"

#define DOWNLOAD_NORMAL 0
//第三方库asihttprequest方式
#define DOWNLOAD_ASIHTTPREQUEST 1

//xml文件
#define PARSE_XML 0
//json文件
#define PARSE_JSON 1
@interface TenDownLoad : NSObject<NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>
{
    id<TenDownLoadDelegate> delegate;

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
}
@property (nonatomic,assign) id<TenDownLoadDelegate> delegate;
@property (nonatomic,retain) NSMutableData * mDownloadData;
-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)downloadFromUrl:(NSString*)url;
@end
