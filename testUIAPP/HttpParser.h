//
//  HttpParser.h
//  XmlDemo
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HttpParserDelegate.h"
#import "HttpDownload.h"
#import "HttpDownloadDelegateEx.h"
//#import "HttpParserIDDelegateEX.h"
@interface HttpParser : NSObject<HttpDownloadDelegateEx>

{
    id<HttpParserDelegate> delegate;
//    id<HttpParserIDDelegateEX> delegateID;
    //下载类实例
    HttpDownload *mHttpDownload;
    HttpDownload *idHttpDownload;
    //下载数据的方式
    NSInteger mDownloadType;
    //解析数据的方式（数据类型）
    NSInteger mParseType;
    
    //解析的结果
    NSMutableArray *mArray;
    
    //此次要解析的结果所用的关键字
    NSString *mKey;
    BOOL isBookID;
    NSString *mSummary;
}
//@property (nonatomic,assign) id<HttpParserIDDelegateEX> delegateID;
@property (nonatomic,assign) id<HttpParserDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *mArray;
@property (nonatomic,retain) NSString *mSummary;
-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url key:(NSString*)key;
- (void) parseFromUrlID:(NSString *)url;

@end
