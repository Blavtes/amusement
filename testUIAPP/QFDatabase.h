//
//  QFDatabase.h
//  XmlParserDemo
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define CREATE_BOOK_SQL @"CREATE TABLE IF NOT EXISTS book (serial integer  Primary Key Autoincrement,id TEXT(1024) DEFAULT NULL,title TEXT(1024),image TEXT(1024) DEFAULT NULL,name TEXT(1024),rating TEXT(1024),info TEXT(4096),price TEXT(4096),publisher TEXT(4096),date TEXT(4096))"
#define CREATE_KEY_SQL @"CREATE TABLE IF NOT EXISTS keys (serial integer  Primary Key Autoincrement,name TEXT(1024),count TEXT(1024) DEFAULT NULL)"

#define CREATE_AUTHOR_SQL @"CREATE TABLE IF NOT EXISTS author (serial integer  Primary Key Autoincrement,bid TEXT(1024),name TEXT(1024) DEFAULT NULL)"
#define CREATE_ATTRIBUTE_SQL @"CREATE TABLE IF NOT EXISTS attr (serial integer  Primary Key Autoincrement,bid TEXT(1024) DEFAULT NULL,name TEXT(1024),info TEXT(1024) DEFAULT NULL)"

//getAllKey方法返回值数组中元素类型为字典
//字典包含的key如下
#define KEY_NAME @"KEY_NAME"
#define KEY_COUNT @"KEY_COUNT"

@class BookItem;
@class FMDatabase;

@interface QFDatabase : NSObject
{
    //第三方数据库操作类相关
    FMDatabase *fmdb;
   
    //数据库文件全路径
    NSString* dbFilePath;//数据库文件路径
    
    //存放读取结果数组 
    NSMutableArray *mNewsArray;
}
@property (nonatomic,retain) NSMutableArray *mNewsArray;
@property (nonatomic, retain) FMDatabase *fmdb;
@property (nonatomic, copy) NSString *dbFilePath;


//关闭数据库
-(void)closeDB;
//打开数据库
-(void)openDatabase;

//fmdb版方法
-(void)readDataWithFMDB:(NSString*)key page:(NSInteger)page count:(NSInteger)count;
//将一条数据插入数据库
-(BOOL)insertItemWithFMDB:(BookItem *)item;
//向keys表中插入一条记录
-(BOOL)insertKeyWithFMDB:(NSString*)key count:(NSInteger)count;
//将数组的所有数据插入数据库(类型为BookItem)
-(void)insertToDatabase:(NSArray *)array
;
//检查指定的key是否存在
-(BOOL)isExistKey:(NSString*)key;

//获得搜索过的所有关键字的个数
-(NSInteger)getKeyCount;
//获得所有的key字符串
-(NSArray*)getAllKey;

//根据给定的关键字在book表中查询
-(NSInteger)getCountByKey:(NSString*)key;


@end
