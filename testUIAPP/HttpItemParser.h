//
//  HttpItemParser.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HttpParserIDDelegateEX.h"
#import "HttpDownloadIDDelegateEx.h"

#import "HttpItemDownload.h"

@interface HttpItemParser : NSObject<HttpDownloadIDDelegateEx>
{
    id<HttpParserIDDelegateEX>delegate;
    
    HttpItemDownload *nHttpDownload;
    NSInteger nDownloadType;
    NSInteger nParseType;
    NSMutableArray *nArray;
    NSString *mKey;
    
    
    
}
@property (nonatomic,assign) id<HttpParserIDDelegateEX>delegate;
@property (nonatomic,retain) NSMutableArray *nArray;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url;
@end
