//
//  MoveItemParser.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveItemParser.h"
#import "SBJSON.h"
#import "GDataXMLNode.h"
#import "NewsItem.h"
#import "MoveController.h"
#import "MoveItem.h"


@implementation MoveItemParser
@synthesize delegate,nArray;
- (id) initWithType:(NSInteger)type parseType:(NSInteger)pType
{
    if (self = [super init]) {
        nDownloadType = type;
        nParseType = pType;
        nArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
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
        MoveItem *oneBook = [[MoveItem alloc] init];
        
        oneBook.name = name;
        //        oneBook.author = result;
        oneBook.imageUrl = [self getImageUrl:[perBook objectForKey:@"link"]];
        oneBook.keystr = mKey;
        [nArray addObject:oneBook];
        [oneBook release];
        startIndexs++;
    }
    //    NSLog(@"count books %dXXXXXXXXXXXXXXXXX",[mArray count]);
    
    
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
    [nArray removeAllObjects];
//    NSDictionary *jsonParse = [data JSONValue];
//    
//    [self parseCommon:jsonParse];
    NSLog(@"json解析:%@",data);
}
- (void) parseFromUrl:(NSString *)url
{

    if (nHttpDownload) {
        [nHttpDownload downloadFromUrl:url];
    }else{
        nHttpDownload = [[MoveItemDownload alloc] initWithType:nDownloadType parseType:nParseType];
        nHttpDownload.delegate = self;
        [nHttpDownload downloadFromUrl:url];
    }
}
- (void) parseXmlData:(NSData*)data
{
    [nArray removeAllObjects];
    
    GDataXMLDocument *root = [[[GDataXMLDocument alloc] initWithData:data options:0 error:nil] autorelease];
    if (root == nil) {
        return;
    }
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:@"http://www.w3.org/2005/Atom", @"xmlns",nil];
    
    NSLog(@"isbooid no...");
    NSArray *array = [root nodesForXPath:@"/xmlns:entry" namespaces:dict error:nil];
    
    //获得这次搜索结果在服务器上的总条数
    //    NSArray *resultArray=[root nodesForXPath:@"//opensearch:totalResults" error:nil];
    for (GDataXMLElement *entryElement in array) {
        NSArray * titleArray=[entryElement elementsForName:@"title"];
        
        NSString *title=[[titleArray lastObject] stringValue];
        NSArray * sArray=[entryElement elementsForName:@"summary"];
        
        NSString *sum=[[sArray lastObject] stringValue];
        
        NSArray * idArray=[entryElement elementsForName:@"id"];
        
        NSString *mid=[[idArray lastObject] stringValue];
        
        NSArray *authorArray=[entryElement elementsForName:@"author"];
        
        NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
        for (GDataXMLElement*authorElement in authorArray) {
            
            NSString *tempAuthor=[[[authorElement elementsForName:@"name"] lastObject] stringValue];
            [str appendString:@"["];
            [str appendString:tempAuthor];
            [str appendString:@"]"];
        }
        NSArray *linkArray=[entryElement elementsForName:@"link"];
        MoveItem *item = [[MoveItem alloc] init];
        item.name = title;
        item.author = str;
        item.keystr = mKey;
        item.mid = mid;
        item.summary = sum;
        for (GDataXMLElement *element in linkArray) {
            GDataXMLNode *node=[element attributeForName:@"rel"];
            if ([[node stringValue] isEqualToString:@"image"]) {
                GDataXMLNode *href=[element attributeForName:@"href"];
                item.imageUrl=[href stringValue];
                
            }
            if ([[node stringValue] isEqualToString:@"alternate"]) {
                GDataXMLNode *href=[element attributeForName:@"href"];
                item.mid=[href stringValue];
            }
        }
        NSArray *dbArray=[entryElement elementsForName:@"db:attribute"];
        NSMutableString *caststr = [[[NSMutableString alloc] init] autorelease];
        NSMutableString *languageStr = [[[NSMutableString alloc] init]autorelease];
         NSMutableString *typeStr = [[[NSMutableString alloc] init]autorelease];
        for ( GDataXMLElement *element in dbArray) {
            GDataXMLNode *node=[element attributeForName:@"name"];
            if ([[node stringValue] isEqualToString:@"director"]) {
                item.director = [element stringValue];
            }
            if ([[node stringValue] isEqualToString:@"pubdate"]) {
                item.year = [element stringValue];
            }
            if ([[node stringValue] isEqualToString:@"country"]) {
                item.country = [element stringValue];
            }
            if ([[node stringValue] isEqualToString:@"cast"]) {
                [caststr appendFormat:@"*%@",[element stringValue]];
            }
            if ([[node stringValue] isEqualToString:@"language"]) {
                [languageStr appendFormat:@"*%@*",[element stringValue]];
            }
            if ([[node stringValue] isEqualToString:@"author-intro"]) {
                item.authorInfo = [element stringValue];
            }
            if ([[node stringValue] isEqualToString:@"movie_duration"]) {
                item.duration = [element stringValue];
            }
            if ([[node stringValue] isEqualToString:@"movie_type"]) {
                [typeStr appendFormat:@"%@ ",[element stringValue]];
            }
        }
        item.language = languageStr;
        item.cast = caststr;
        item.types = typeStr;
        NSLog(@"item %@ ...Item.cast..%@...type...%@....dur>>>>%@",item,item.cast,item.types,item.duration);
        [nArray addObject:item];
        
        [item release];
    }
    if (nArray != nil) {
       
    }
    NSLog(@"array %@",nArray);
    //    NSArray *array = [root 
}
-(void)downloadComplete:(MoveItemDownload *)download
{
    NSLog(@"downloadcomplete....");
    switch (nParseType) {
        case PARSE_JSON:
        {
            [self parseJsonData:download.nDownloadData];
        }
            break;
        case PARSE_XML:
        {
            [self parseXmlData:download.nDownloadData];
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
