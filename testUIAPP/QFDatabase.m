//
//  QFDatabase.m
//  XmlParserDemo
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QFDatabase.h"
#import "FMDatabase.h"
#import "FMDatabasePool.h"

#import "BookItem.h"
#import "Helper.h"
#import "CONST.h"

//数据库文件名
#define DBNAME @"mydb.sqlite3"

@implementation QFDatabase
@synthesize mNewsArray;
@synthesize fmdb,dbFilePath;

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}
-(void)closeDB
{
    [fmdb close];
}
-(void)createTablePool
{
    //创建表语句
    
    /* 在iOS中执行sql语句 */
    NSArray *array=[NSArray arrayWithObjects:CREATE_BOOK_SQL,CREATE_AUTHOR_SQL,CREATE_ATTRIBUTE_SQL,CREATE_KEY_SQL, nil];
    
    for (NSString *sql in array) {
        //执行sql语句
        if (![fmdb executeUpdate:sql]) {
            NSLog(@"创建表失败");
        }
    }
}
//跟据传入的类型用相应的方法打开数据库
-(void)openDatabase{
    
    //数据库文件路径
    self.dbFilePath=[Helper databasePath:DBNAME];
    
    //数据库文件存在就打开，不存在就创建再打开
    self.fmdb=[FMDatabase databaseWithPath:dbFilePath];
    if (![fmdb open]) {
        NSLog(@"数据库打开失败");
    }
    else{
        //创建表
        [self createTablePool];
    }
    
    //执行这条语句会使数据库占用空间变小
    [fmdb executeUpdate:@"VACUUM"];//压缩数据库内容
    
    
    return;
}



//插入数组中所有数据到数据库
-(void)insertToDatabase:(NSArray *)array
{
    //开始事务
    [fmdb beginTransaction];
    
    //多次插入数据
    for (BookItem *item in array) {
        [self insertItemWithFMDB:item];
    }
    //一次提交
    [fmdb commit];

}


//检查数据合法性
-(void)checkItem:(BookItem*)item
{
    if (item) {
        item.title=item.title?item.title:@"";
        item.imageurl=item.imageurl?item.imageurl:@"";
        item.mid=item.mid?item.mid:@"";
        item.mdescription=item.mdescription?item.mdescription:@"";
        item.rating = item.rating?item.rating:@"";
        //
        item.price = item.price?item.price:@"";
        item.publisher = item.publisher?item.publisher:@"";
        item.pubdate = item.pubdate?item.pubdate:@"";
    }
}
//以下为fmdb方式的方法
-(BOOL)insertKeyWithFMDB:(NSString *)key count:(NSInteger)count
{
    if ([self isExistKey:key]) {
        return NO;//存在就不重复记录
    }
    BOOL isSuccessed=NO;
    //参数必须是对象
    isSuccessed=[fmdb executeUpdate:@"INSERT INTO keys (name,count) values ( ?, ?)",
                 key,[NSNumber numberWithInteger:count]
                 ];
    return isSuccessed;

}
//fmdb方式插入一条 数据
-(BOOL)insertItemWithFMDB:(BookItem *)item
{
    [self checkItem:item];
    BOOL isSuccessed=NO;
    //执行插入数据到book表
    isSuccessed=[fmdb executeUpdate:@"INSERT INTO book (id,title,image,name,price,publisher,date,rating) values (?, ?, ?,?,?,?,?,?)",
                 item.mid,
                 item.title,
                 item.imageurl,
                 item.keystr,
                 item.price,
                 item.publisher,
                 item.pubdate,
                 item.rating
                 ];
    if (item.author) {
        for (NSString *name in item.author) {
            [fmdb executeUpdate:@"INSERT INTO author (bid,name) values ( ?, ?)",item.mid,name
             ];
        }
    }
    if (item.attr) {
        for (NSString *key in [item.attr allKeys]) {
            [fmdb executeUpdate:@"INSERT INTO attr (bid,name,info) values ( ?, ?, ?)",item.mid,key,[item.attr objectForKey:key]
             ];
        }
    }
    
    
    return isSuccessed;
}

-(BOOL)isExistKey:(NSString *)key
{
    //BOOL isSuccessed=NO;
    
    FMResultSet *result=[fmdb executeQuery:@"SELECT name FROM keys WHERE name=?",key];
    while ([result next]) {
        return YES;
    }
    
    return NO;
}
//fmdb方式读取数据
-(void)readDataWithFMDB:(NSString *)key page:(NSInteger)page count:(NSInteger)count
{
    
    if (!mNewsArray) {
        mNewsArray=[[NSMutableArray alloc] init];
    }
    else{
        [mNewsArray removeAllObjects];
    }
    NSString *sql;
    if (key) {
        if (count==0) {
            sql=@"SELECT id,title,image,name,info,price,publisher,date,rating FROM book WHERE name=?";
        }
        else{
            
            sql=[NSString stringWithFormat:@"SELECT id,title,image,name,info,price,publisher,date,rating FROM book WHERE name=? limit %d,%d",page*count,count];
        }
        
    }
    else{
        if (count==0) {
            sql=@"SELECT id,title,image,name,rating,info FROM book";
        }
        else{
            sql=[NSString stringWithFormat:@"SELECT id,title,image,name,info,price,publisher,rating,date FROM book WHERE limit %d,%d",page*count,count];
        }
    }
    FMResultSet *rs = [fmdb executeQuery:sql,key];
    NSLog(@"%@",[fmdb lastErrorMessage]);
    while ([rs next]) {
        
        BookItem *item=[[BookItem alloc] init];
        item.keystr=[rs stringForColumn:@"name"];
        item.mdescription=[rs stringForColumn:@"info"];
        item.mid = [rs stringForColumn:@"id"];
        item.title =[rs stringForColumn:@"title"];
        item.imageurl=[rs stringForColumn:@"image"];
        item.rating = [rs stringForColumn:@"rating"];
//        NSMutableArray *array = [NSMutableArray array];
//        [array addObject:[rs stringForColumn:@"author"]];
//        item.author = array;
        item.publisher = [rs stringForColumn:@"publisher"];
        item.pubdate = [rs stringForColumn:@"date"];
        item.price = [rs stringForColumn:@"price"];
        
        [mNewsArray addObject:item];
        
        [item release];
    }
    NSString *sql1;
    static int n = 0;
    NSLog(@"price.......%d",n++);
    if (key) {
        NSLog(@"price.......%d",n++);
        if (count==0) {
            sql1=@"SELECT bid,name FROM author WHERE name=?";
        }
        else{
            
            sql1=[NSString stringWithFormat:@"SELECT bid,name FROM author WHERE name=? limit %d,%d",page*count,count];
        }
        
    }
    else{
        NSLog(@"price.......%d",n++);
        if (count==0) {
            sql1=@"SELECT bid,name FROM author";
        }
        else{
            sql1=[NSString stringWithFormat:@"SELECT bid,name FROM author WHERE limit %d,%d",page*count,count];
        }
        NSLog(@"sql1 %@",sql1);
    }
    NSLog(@"price.......%d",n++);
    FMResultSet *rs1 = [fmdb executeQuery:sql1,key];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs1 next]) {
        NSLog(@"price.....2..%d",n++);
        
//            NSMutableArray *array1 = [NSMutableArray array];
//            NSLog(@"item %@ ...%",[rs stringForColumn:@"name"]);
        NSString *str = [rs stringForColumn:@"name"];
                
        if ([str length]==0) {
            continue;
        }
            [array addObject:[rs stringForColumn:@"name"]];
            NSLog(@"array  ..%@  ...",array);
//            item.author = array1;   
//            [array addObject:item];
//            NSLog(@"item %@",item);
        
    }
//    [mNewsArray removeAllObjects];
//    [mNewsArray addObjectsFromArray:array];
    
    
}
-(NSArray*)getAllKey
{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
    FMResultSet*resultSet= [fmdb executeQuery:@"SELECT name,count  FROM keys"];
    while ([resultSet next]) {
        NSString *name=[resultSet stringForColumn:@"name"];
        NSString *count=[resultSet stringForColumn:@"count"];
        NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:name,KEY_NAME,count,KEY_COUNT, nil];
        
        [array addObject:dict];
    }
    return array;
    
}
-(NSInteger)getKeyCount
{
    FMResultSet*resultSet= [fmdb executeQuery:@"SELECT COUNT(*)  as count FROM keys"];
    while ([resultSet next]) {
        
        return [resultSet intForColumn:@"count"];
        //获得第0列的值
        //return [resultSet intForColumnIndex:0];
    }
    return 0;
}

-(NSInteger)getCountByKey:(NSString *)key
{
    FMResultSet*resultSet= [fmdb executeQuery:@"SELECT COUNT(*) as count  FROM book WHERE name=?",key];
    while ([resultSet next]) {
        NSInteger count=[resultSet intForColumn:@"count"];
        return count;
    }
    return 0;
}

@end
