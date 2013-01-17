//
//  TenHttpParse.m
//  HtmlParserTest
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TenHttpParse.h"
#import "SBJson.h"
#import "GDataXMLNode.h"
#import "TenItem.h"
@implementation TenHttpParse
@synthesize delegate,mArray;
@synthesize nwsTitle = _nwsTitle;
@synthesize nwsLink = _nwsLink;
@synthesize nwsPubdate = _nwsPubdate;
@synthesize tempString = _tempString;
@synthesize descriptionArray = _descriptionArray;

#define NWSTITLE @"nwsTitle"
#define NWSLINK @"nwsLink"
#define NWSPUBDATE @"nwsPubdate"
#define NWAUTHOR @"description"
#define TEMPSTRING @"tempString"

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType
{
    if (self=[super init]) {
        mDownloadType=type;
        mParseType=pType;
        
        mArray=[[NSMutableArray alloc] initWithCapacity:0];

    }
    return self;
}

- (void) parseFromUrl:(NSString *)url
{
    
    if (mHttpDownload) {
        NSLog(@"download is 1 ");
        [mHttpDownload downloadFromUrl:url];
    }else{
        NSLog(@"download is 2 ");
        mHttpDownload = [[TenDownLoad alloc] initWithType:mDownloadType parseType:mParseType];
        mHttpDownload.delegate = self;
        [mHttpDownload downloadFromUrl:url];
    }
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"title"]) {
        if (self.nwsTitle == nil) {
            self.nwsTitle = [NSMutableArray array];
        }
    }else if([elementName isEqualToString:@"link"])
    {
        if (self.nwsLink == nil) {
            self.nwsLink = [NSMutableArray arrayWithObject:@"http://10juhua.com"];
        }
    }else if([elementName isEqualToString:@"pubDate"]){
        if (self.nwsPubdate == nil) {
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:8*3600];
            NSString *str = [[NSString stringWithFormat:@"%@",date] substringWithRange:NSMakeRange(0, 19)];
            self.nwsPubdate = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"%@ +0800",str]];
        }
    }else if([elementName isEqualToString:@"description"]){
        if (self.descriptionArray == nil) {
            self.descriptionArray = [NSMutableArray array];
        }
    }
}
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.tempString == nil) {
        self.tempString = [[[NSMutableString alloc] init] autorelease];
    }
    [self.tempString appendString:string];
}
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]) {
        [self.nwsTitle addObject:self.tempString];
    }else if([elementName isEqualToString:@"link"]){
        [self.nwsLink addObject:self.tempString];
    }else if([elementName isEqualToString:@"pubDate"]){
        [self.nwsPubdate addObject:self.tempString];
    }else if([elementName isEqualToString:@"description"]){
        [self.descriptionArray addObject:[[self.tempString componentsSeparatedByString:@"<img"] objectAtIndex:0]];
    }
    NSLog(@"temstring %@",self.tempString);
    if (self.nwsTitle != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:self.nwsTitle forKey:NWSTITLE];
        [[NSUserDefaults standardUserDefaults] setObject:self.nwsPubdate forKey:NWSPUBDATE];
        [[NSUserDefaults standardUserDefaults] setObject:self.descriptionArray forKey:NWAUTHOR];
        [[NSUserDefaults standardUserDefaults] setObject:self.nwsLink forKey:NWSLINK];
        
    }
    
    self.tempString = nil;
}


-(void)parseXmlData:(NSData*)data
{
    
    [mArray removeAllObjects];
    
    
    NSXMLParser *xmlP = [[NSXMLParser alloc] initWithData:data];
    xmlP.delegate = self;
    [xmlP parse];
    
    
}

-(void)downloadComplete:(TenDownLoad *)download
{
    NSLog(@"downloadtendowww....");
   
    [self parseXmlData:download.mDownloadData];
    NSLog(@"  >>>%@",mArray);
    //通知(界面)解析完成
    [mArray addObject:self.descriptionArray];
    [mArray addObject:self.nwsLink];
    [mArray addObject:self.nwsPubdate];
    NSLog(@"通知 down 完成。%d。。%d..%d..%d,,,,%d",self.nwsTitle.count,self.nwsPubdate.count,self.nwsLink.count,self.descriptionArray.count,mArray.count);
    
    for (NSString *tr in self.nwsTitle) {
        NSLog(@".....titls...%@",tr);
    }
    [delegate parseComplete:self];
    
    
}



@end
