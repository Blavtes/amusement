//
//  NewsItem.h
//  XmlParserDemo
//
////  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Humorous : NSObject
{
    NSString *title;//标题
    NSString *link;//链接
    NSString *author;//作者
    NSString *guid;//标识
    NSString *category;//分类Humorous
    NSString *pubDate;//发布时间
    NSString *comments;//评论
    NSString *description;//摘要
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *author;
@property (nonatomic,copy) NSString *guid;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *pubDate;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *description;
@end
