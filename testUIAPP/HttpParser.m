//
//  HttpParser.m
//  XmlDemo
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HttpParser.h"
#import "SBJson.h"
#import "GDataXMLNode.h"
#import "BookItem.h"
#import "AppDelegate.h"
#import "QFDatabase.h"
#import "BookController.h"
@implementation HttpParser
@synthesize delegate,mArray;
@synthesize mSummary;
//@synthesize delegateID;
//初始化方法
-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType
{
    if (self=[super init]) {
        mDownloadType=type;
        mParseType=pType;
        
        mArray=[[NSMutableArray alloc] initWithCapacity:0];
        mSummary = @"";
    }
    return self;
}

- (void) parseFromUrl:(NSString *)url key:(NSString *)key
{
    mKey = [key copy];
    isBookID = NO;
     if (mHttpDownload) {
        NSLog(@"download is 1 ");
        [mHttpDownload downloadFromUrl:url];
    }else{
        NSLog(@"download is 2 ");
        mHttpDownload = [[HttpDownload alloc] initWithType:mDownloadType parseType:mParseType];
        mHttpDownload.delegate = self;
        [mHttpDownload downloadFromUrl:url];
    }
}
- (void) parseFromUrlID:(NSString *)url 
{
    isBookID = YES;
    NSLog(@"kaishi id  pares...");
    if (idHttpDownload) {
        NSLog(@"download is 1 ");
        [idHttpDownload downloadFromUrlID:url];
    }else{
        NSLog(@"download is 2 ");
        idHttpDownload = [[HttpDownload alloc] initWithType:mDownloadType parseType:mParseType];
//        idHttpDownload.delegateID = self;
//        [idHttpDownload downloadFromUrlID:url];
    }
    NSLog(@"load over...");
}
- (NSString*)getImageUrl:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        
        if ([[dict objectForKey:@"@rel"] isEqualToString:@"image"]) {
            return [dict objectForKey:@"@href"];
        }
    }
    return nil;
}
- (NSString*)getPublisher:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"@name"] isEqualToString:@"publisher"]) {
            return [dict objectForKey:@"$t"];
        }
    }
    return nil;
}
- (NSString*) getPrice:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"@name"] isEqualToString:@"price"]) {
            return [dict objectForKey:@"$t"];
        }
    }
    return nil;
}
- (void) createCellData:(int)startIndexs JsonParser:(NSDictionary*)jsonParser

{
    NSArray *books = [jsonParser objectForKey:@"entry"];
    NSLog(@"books count %d",[books count]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    for (NSDictionary *perBook in books) {
        NSString *name = [[perBook objectForKey:@"title"] objectForKey:@"$t"];
        NSArray *authorArray = [perBook objectForKey:@"author"];
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in authorArray) {
            NSString *name = [[dict objectForKey:@"name"] objectForKey:@"$t"];
            [result addObject:name];
            
        }
        //        NSLog(@"book name %@ author %@ image ",name,authorstr);
        BookItem *oneBook = [[BookItem alloc] init];
        
        oneBook.title = name;
        oneBook.author = result;
        oneBook.imageurl = [self getImageUrl:[perBook objectForKey:@"link"]];
        oneBook.keystr = mKey;
        [mArray addObject:oneBook];
        [oneBook release];
        startIndexs++;
    }
    NSLog(@"count books %dXXXXXXXXXXXXXXXXX",[mArray count]);
    
    
}

- (void) parseCommon:(NSDictionary*)jsonParser
{
    NSDictionary *t1 = [jsonParser objectForKey:@"opensearch:totalResults"];
    NSString *t2 = [t1 objectForKey:@"$t"];
    NSLog(@"$t is %@",t2);
    NSInteger startIndex = [[[jsonParser objectForKey:@"openseatch:startIndex"] objectForKey:@"$t"]intValue];
    int itemsPerPage = [[[jsonParser objectForKey:@"opensearch:itemsPerPage"]objectForKey:@"$t"] intValue];
    NSLog(@"startIndext %d itemsPerPgae %d",startIndex,itemsPerPage);
    [self createCellData:startIndex JsonParser:jsonParser];
}
-(void)parseJsonData:(NSData*)data
{
    [mArray removeAllObjects];
//    NSDictionary *jsonParse = [data JSONValue];
//    
//    [self parseCommon:jsonParse];
    NSLog(@"json解析:%@",data);
}
-(NSDictionary*)parseAttribute:(GDataXMLElement*)element
{
    NSArray * attrArray=[element elementsForName:@"db:attribute"];
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithCapacity:0];
    for (GDataXMLElement *subElement in attrArray) {
        GDataXMLNode *nameNode=[subElement attributeForName:@"name"];
        
        [dict setObject:[subElement stringValue] forKey:[nameNode stringValue]];
    }
    return dict;
    
    
}
-(void)parseXmlData:(NSData*)data
{
    
    [mArray removeAllObjects];
    
    
    GDataXMLDocument *root=[[[GDataXMLDocument alloc] initWithData:data options:0 error:nil] autorelease];
    if (root==nil) {
        return;
    }
    
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:@"http://www.w3.org/2005/Atom", @"xmlns",nil];

        NSLog(@"isbooid no...");
        NSArray *array = [root nodesForXPath:@"/xmlns:feed/xmlns:entry" namespaces:dict error:nil];
        
        //获得这次搜索结果在服务器上的总条数
        NSArray *resultArray=[root nodesForXPath:@"//opensearch:totalResults" error:nil];
        NSInteger count=[[[resultArray lastObject] stringValue] integerValue];

        //存入数据库的表keys中
        [ShareApp.mDatabase insertKeyWithFMDB:mKey count:count];
        for (GDataXMLElement *entryElement in array) {
            NSArray * titleArray=[entryElement elementsForName:@"title"];
                
            NSString *title=[[titleArray lastObject] stringValue];
            
            NSArray * idArray=[entryElement elementsForName:@"id"];
            
            NSString *mid=[[idArray lastObject] stringValue];
            
            NSArray *authorArray=[entryElement elementsForName:@"author"];
            
            NSMutableArray *resultAuthor=[NSMutableArray arrayWithCapacity:0];
            for (GDataXMLElement*authorElement in authorArray) {
                
                NSString *tempAuthor=[[[authorElement elementsForName:@"name"] lastObject] stringValue];
            
                [resultAuthor addObject:tempAuthor];
            }
            NSArray *linkArray=[entryElement elementsForName:@"link"];
            BookItem *item =[[BookItem alloc] init];
            item.title=title;
            item.author=resultAuthor;
            item.mid=mid;
            item.keystr=mKey;
            item.attr=[self parseAttribute:entryElement];
            for (GDataXMLElement *element in linkArray) {
                GDataXMLNode *node=[element attributeForName:@"rel"];
                if ([[node stringValue] isEqualToString:@"image"]) {
                    GDataXMLNode *href=[element attributeForName:@"href"];
                    item.imageurl=[href stringValue];

                }
//                if ([[node stringValue] isEqualToString:@"alternate"]) {
//                    GDataXMLNode *href=[element attributeForName:@"href"];
//                    item.mid=[href stringValue];
//                }
            }
            NSArray *dbArray=[entryElement elementsForName:@"db:attribute"];
            for ( GDataXMLElement *element in dbArray) {
                 GDataXMLNode *node=[element attributeForName:@"name"];
                if ([[node stringValue] isEqualToString:@"price"]) {
                    item.price = [element stringValue];
                }
                if ([[node stringValue] isEqualToString:@"publisher"]) {
                    item.publisher = [element stringValue];
                }
                if ([[node stringValue] isEqualToString:@"pubdate"]) {
                    item.pubdate = [element stringValue];
                }
            }
            NSArray *raArray=[entryElement elementsForName:@"gd:rating"];
            for ( GDataXMLElement *element in raArray) {
                GDataXMLNode *node=[element attributeForName:@"average"];
                item.rating = [node stringValue];
                if (item.rating != nil) {
                    break;
                }
            }
            [mArray addObject:item];
            [item release];
    //               
    }
    NSLog(@"xml解析:%@",data);
}
-(void)parseXmlIDData:(NSData*)data
{
    [mArray removeAllObjects];
    
    
    GDataXMLDocument *root=[[[GDataXMLDocument alloc] initWithData:data options:0 error:nil] autorelease];
    if (root==nil) {
        return;
    }
    
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:@"http://www.w3.org/2005/Atom", @"xmlns",nil];
    isBookID = YES;
    NSLog(@"lod......");
    NSArray *array = [root nodesForXPath:@"/xmlns:entry" namespaces:dict error:nil];
    for ( GDataXMLElement *entryElement in array) {
        NSArray * summaryArray=[entryElement elementsForName:@"summary"];
        NSString *sumary = [[summaryArray lastObject] stringValue];
        mSummary = sumary;
    }
    NSLog(@"xml解析:%@",data);
}

-(void)httpDownloadComplete:(HttpDownload *)download
{
    NSLog(@"downloadcomplete....");
    switch (mParseType) {
        case PARSE_JSON:
        {
            [self parseJsonData:download.mDownloadData];
        }
            break;
        case PARSE_XML:
        {
            [self parseXmlData:download.mDownloadData];
        }
            break;
        default:
            break;
    }
    

    //通知(界面)解析完成
        NSLog(@"通知 解析 完成。。。");
        [delegate parseComplete:self];

}

@end
