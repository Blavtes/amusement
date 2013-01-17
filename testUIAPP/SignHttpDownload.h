//
//  SignHttpDownload.h
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignDownLoadDelegate.h"
@class SignItem;
@interface SignHttpDownload : NSObject<NSXMLParserDelegate>



{
    //下载链接类
    NSURLConnection *mUrlConnection;
    
    
    //下载的数据
    NSMutableData *mData;
    
    //代理
    id<SignDownLoadDelegate> delegate;
    
    //结果数组
    NSMutableArray  *workingArray;
    
    SignItem       *workingEntry;
    
    //所需节点数组
    NSArray         *elementsToParse;
    
}
@property (nonatomic,assign) id<SignDownLoadDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) SignItem *workingEntry;

@property (nonatomic, retain) NSArray *elementsToParse;

-(void)downloadFromUrl:(NSString*)url;
@end