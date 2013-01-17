//
//  NewHttpParser.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "MoveHttpParserDelegateEx.h"
#import "MoveHttpDownloadDelegateEx.h"
#import "MoveHttpDownload.h"

@interface MoveHttpParser : NSObject<MoveHttpDownloadDelegateEx>
{
    id<MoveHttpParserDelegateEx>delegate;
    
    MoveHttpDownload *nHttpDownload;
    NSInteger nDownloadType;
    NSInteger nParseType;
    NSMutableArray *nArray;
    NSString *mKey;
    
    
    
}
@property (nonatomic,assign) id<MoveHttpParserDelegateEx>delegate;
@property (nonatomic,retain) NSMutableArray *nArray;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url key:(NSString *)key;
@end
