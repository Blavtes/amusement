//
//  HttpItemDownload.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HttpItemDownload.h"

#import "MoveItemDownload.h"
#import "ASIHTTPRequest.h"
@implementation HttpItemDownload



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
    NSURL *nsurlll = [NSURL URLWithString:nUrl];
    switch (nDownloadType) {
        case DOWNLOAD_NORMAL:
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:nsurlll];
            nUrlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
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
    [delegate downloadCompleteID:self];
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
    [delegate downloadCompleteID:self];
}
@end
