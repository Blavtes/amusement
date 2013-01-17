//
//  CartoonHttpDownLoad.h
//  testUIAPP
//
//  Created by Yong on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartoonDownloadDelegate.h"
@class CartoonItem;
@interface CartoonHttpDownLoad : NSObject
{
    //下载链接类
    NSURLConnection *mUrlConnection;
    
    
    //下载的数据
    NSMutableData *mData;
    
    //代理
    id<CartoonDownloadDelegate> delegate;
    
    //结果数组
    NSMutableArray  *workingArray;
    
    CartoonItem       *workingEntry;
    
    //所需节点数组
    NSArray         *elementsToParse;
    
}
@property (nonatomic,assign) id<CartoonDownloadDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) CartoonItem *workingEntry;

@property (nonatomic, retain) NSArray *elementsToParse;

-(void)cartoonDownloadFromUrl:(NSString*)url;

@end
