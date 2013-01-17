//
//  TenDownLoad.m
//  HtmlParserTest
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TenDownLoad.h"
#import "ASIHTTPRequest.h"
@implementation TenDownLoad
@synthesize delegate,mDownloadData;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType
{
    if (self=[super init]) {
        mDownloadType=type;
        mParseType=pType;
        
        self.mDownloadData=[NSMutableData dataWithCapacity:0];
    }
    return self;
}


-(void)downloadFromUrl:(NSString *)url
{
    mUrl=[url copy];
    
    NSURL *nsurll=[NSURL URLWithString:mUrl];
    
    switch (mDownloadType) {
        case DOWNLOAD_NORMAL:
        {
            NSLog(@"normal....");
            //创建请求
            NSURLRequest *request=[NSURLRequest requestWithURL:nsurll];
            //启动异步下载
            mUrlConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        }
            break;
        case DOWNLOAD_ASIHTTPREQUEST:
        {
            NSLog(@"asi...." );
            //创建实例
            ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:nsurll];
            //设置代理
            request.delegate=self;
            //启动异步下载
            [request startAsynchronous];
        }
            break;
        default:
            break;
    }
    
}
//asi协议方法
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"下载失败");
}
//asi下载完成
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"下载完成");
    [mDownloadData setLength:0];
    [mDownloadData appendData:[request responseData]];
    [delegate downloadComplete:self];
}
//收到服务器回应，准备接收数据
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //清空原有数据
    [mDownloadData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"下载出错");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //将收到的数据加入NSMutableData
    
    [mDownloadData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //通知代理类下载完成
    
    [delegate downloadComplete:self];
}

@end
