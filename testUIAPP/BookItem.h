//
//  BookItem.h
//  DoubanDemo1
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface BookItem : NSObject
{
    //书名
    NSString *title;
    //作者
    NSArray *author;
    NSString *authors;
    NSString *authorInfo;
    //属性
    NSDictionary *attr;
    //此书的详情信息的地址
    NSString *mid;
    //此书的图片
    NSString *price;
    NSString *publisher;
    NSString *pubdate;
    NSString *imageurl;
    //搜索此书时用的关键字
    NSString *keystr;
    //图书简介
    NSString *mdescription;
    NSString *summary;
    NSInteger mCount;


    NSString *rating;
}
@property (nonatomic,retain) NSString *rating;

@property (nonatomic,retain) NSString *summary;
@property (nonatomic,retain) NSString *authors;
@property (nonatomic,retain) NSString *authorInfo;
@property (nonatomic,retain) NSString *pubdate;
@property (nonatomic,copy) NSString *publisher;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger mCount;
@property (nonatomic,copy) NSString *keystr;
@property (nonatomic,copy) NSString *mid;
@property (nonatomic,copy) NSString *mdescription;
@property (nonatomic,retain)NSArray *author;
@property (nonatomic,retain)NSDictionary *attr;
@property (nonatomic,copy)NSString *imageurl;
@end
