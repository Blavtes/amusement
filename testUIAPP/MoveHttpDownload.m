//
//  NewHttpDownload.m
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveHttpDownload.h"
#import "ASIHTTPRequest.h"
@implementation MoveHttpDownload
@synthesize delegate,nDownloadData;
- (id) initWithType:(NSInteger)type parseType:(NSInteger)pType
{
    if (self = [super init]) {
        nDownloadType = type;
        nParseType = pType;
        self.nDownloadData = [NSMutableData dataWithCapacity:0];
    }
    return self;
}
- (void) downloadFromUrl:(NSString *)url
{
    nUrl = [url copy];
    //设置 缓存
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*1024];
    //
    NSURL *nsurlll = [NSURL URLWithString:nUrl];
    switch (nDownloadType) {
        case DOWNLOAD_NORMAL:
        {
//            NSURLRequest *request = [NSURLRequest requestWithURL:nsurlll];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurlll cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
            //从请求中获取缓存输出
            NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
            //判断是否有缓存
            if (response != nil) {
                [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
                
            }
            //创建NSURLConnection
            nUrlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
            
        }
            break;
        case DOWNLOAD_ASIHTTPREQUEST:
        {
            ASIHTTPRequest *requset = [ASIHTTPRequest requestWithURL:nsurlll];
            requset.delegate = self;
            [requset startAsynchronous];
        }
            break;
        default:
            break;
    }
}
- (void) requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"download faile");
}
- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"download over");
    [nDownloadData setLength:0];
    [nDownloadData appendData:[request responseData]];
    [delegate downloadComplete:self];
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [nDownloadData setLength:0];
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"download faile");
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [nDownloadData appendData:data];
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [delegate downloadComplete:self];
}
//缓存
- (NSCachedURLResponse*) connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}

@end
