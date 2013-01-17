//
//  TenHttpParse.h
//  HtmlParserTest
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TenDownLoadDelegate.h"
#import "TenHttpParseDelegate.h"
#import "TenDownLoad.h"
@interface TenHttpParse : NSObject<TenDownLoadDelegate,NSXMLParserDelegate>
{
    id<TenHttpParseDelegate>delegate;
    TenDownLoad *mHttpDownload;
    
    NSInteger mDownloadType;
    //解析数据的方式（数据类型）
    NSInteger mParseType;
    NSMutableData *mData;
    //解析的结果
    NSMutableArray *mArray;

}
@property (nonatomic,strong) NSMutableArray *nwsTitle;
@property (nonatomic,strong) NSMutableArray *nwsLink;
@property (nonatomic,strong) NSMutableArray *nwsPubdate;
@property (nonatomic,strong) NSMutableArray *descriptionArray;
@property (nonatomic,strong) NSMutableString *tempString;
@property (nonatomic,assign) id<TenHttpParseDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *mArray;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url;
@end
