//
//  CartoonHttpDownLoad.m
//  testUIAPP
//
//  Created by Yong on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CartoonHttpDownLoad.h"


#import "GDataXMLNode.h"
#import "CartoonItem.h"
@implementation CartoonHttpDownLoad
static NSString *kItemStr  = @"item";
static NSString *kTitleStr     = @"title";
static NSString *kLinkStr   = @"link";
static NSString *kAuthorStr  = @"author";

static NSString *kGUIDStr  = @"guid";
static NSString *kCategoryStr  = @"category";
static NSString *kPubDateStr  = @"pubDate";
static NSString *kCommentsStr  = @"comments";

static NSString *kDescriptionStr = @"description";



@synthesize delegate, workingArray, workingEntry, elementsToParse;

-(id)init
{
    if (self=[super init]) {
        
        //关心的所有节点数组
        self.elementsToParse = [NSArray arrayWithObjects:kTitleStr, kLinkStr, kAuthorStr, kGUIDStr, kCategoryStr,kPubDateStr,kCommentsStr,kDescriptionStr, nil];
    }
    return self;
}
-(void)cartoonDownloadFromUrl:(NSString *)url
{
    NSLog(@"downloadFromUrl..begin...");
    if (!mData) {
        mData=[[NSMutableData alloc] initWithLength:0];
        
        workingArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    else{
        [mData setData:nil];
        [workingArray removeAllObjects];
    }
    
    //创建链接
    NSURL *newUrl=[[NSURL alloc] initWithString:url];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:newUrl];
    mUrlConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSString *)elementContent:(GDataXMLElement*)element withName:(NSString*)elementName
{
    NSArray *nameElementArray=[element elementsForName:elementName];
    return [[nameElementArray lastObject] stringValue];
}
-(void)parseItemElement:(GDataXMLElement*)element
{
    int i=0;
    CartoonItem *item=[[CartoonItem alloc] init];
    item.imageArrayUrl = [NSMutableArray arrayWithCapacity:0];
    for (NSString *elementName in elementsToParse) {
        NSString *value=[self elementContent:element withName:elementName];
        switch (i) {
            case 0:
                item.title=value;
                break;
            case 1:
                item.link=value;
                break;
            case 2:
                item.author=value;
                break;
            case 3:
                item.guid=value;
                break;
            case 4:
                item.category=value;
                break;
            case 5:
                item.pubDate=value;
                break;
            case 6:
                item.comments=value;
                break;
            case 7:
                item.description=value;
                break;
            default:
                break;
        }
        i++;
        NSLog(@"%@=%@",elementName,value);
    }
    [workingArray addObject:item];
    [item release];
    
}
-(void)parseXmlDataWithGdata:(NSData*)data
{
    NSError *error;
    GDataXMLDocument *doc= [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    if (doc == nil) { 
		return; 
	}
    NSArray *contentArray=[NSArray arrayWithObjects:@"/rss/channel/item",nil];
    for (int i=0;i<[contentArray count];i++) {
        NSArray *itemMembers = [doc nodesForXPath:[contentArray objectAtIndex:i] error:&error];
        for (GDataXMLElement *childMember in itemMembers) {
            [self parseItemElement:childMember];
        }
    }
    if (delegate) {
        NSLog(@"delegate...bigen..");
        [delegate cartoonDownloadComplete:workingArray];
    }
}
#pragma mark - 
#pragma mark Network connection
/* 1. 网络开始接收数据 */
/* 网络响应头接收完成，真正数据开始马上要来到了 */
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [mData setLength:0];
}
/* 2. 网络正在接收数据 */
/* data参数就是系统每次接收一大段数据就会调用该方法 */
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{  
    [mData appendData:data];
    /* 把网络传给我们的数据data附加到responseData之后即可 */
}
/* 2. 网络数据接收完成 */
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"%@",mData);
    //调用解析方法解析数据
    [self parseXmlDataWithGdata:mData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)dealloc
{
    [workingEntry release];
    [workingArray release];
    [super dealloc];
}
@end

