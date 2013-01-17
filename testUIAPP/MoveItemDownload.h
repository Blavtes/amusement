//
//  MoveItemDownload.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "ASIHTTPRequest.h"
#define DOWNLOAD_NORMAL 0
#define DOWNLOAD_ASIHTTPREQUEST 1
#define PARSE_XML 0
#define PARSE_JSON 1
#import "MoveItemDownloadDelegateEx.h"
@interface MoveItemDownload : NSObject<ASIHTTPRequestDelegate,NSURLConnectionDataDelegate>
{
    id<MoveItemDownloadDelegateEx>delegate;
    
    NSInteger nDownloadType;
    NSInteger nParseType;
    
    NSString *nUrl;
    NSURLConnection *nUrlConnection;
    NSMutableData *nDownloadData;
    
}
@property (nonatomic,assign) id<MoveItemDownloadDelegateEx>delegate;
@property (nonatomic,retain) NSMutableData *nDownloadData;
-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)downloadFromUrl:(NSString*)url;

@end
