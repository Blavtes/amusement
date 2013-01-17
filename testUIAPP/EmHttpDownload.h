//
//  HttpDownload.h
//  JsonParserDemo
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EMDownloadCompleteDelegate.h"

@class Humorous;

@interface EmHttpDownload : NSObject<NSXMLParserDelegate>
{
    //下载链接类
    NSURLConnection *mUrlConnection;
    
    
    //下载的数据
    NSMutableData *mData;
    
    //代理
    id<EMDownloadCompleteDelegate> delegate;
    
    //结果数组
    NSMutableArray  *workingArray;
    
    Humorous       *workingEntry;
    
    //所需节点数组
    NSArray         *elementsToParse;
    
}
@property (nonatomic,assign) id<EMDownloadCompleteDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) Humorous *workingEntry;

@property (nonatomic, retain) NSArray *elementsToParse;

-(void)downloadFromUrl:(NSString*)url;
@end