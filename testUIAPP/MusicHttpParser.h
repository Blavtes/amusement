//
//  MusicHttpParser.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicHttpDownload.h"
#import "MusicHttpDownloadDelegateEx.h"
#import "MusicHttpParserDelegateEx.h"
@interface MusicHttpParser : NSObject<MusicHttpDownloadDelegateEx>
{
    id<MusicHttpParserDelegateEx>delegate;
    
    MusicHttpDownload *nHttpDownload;
    NSInteger nDownloadType;
    NSInteger nParseType;
    NSMutableArray *nArray;
    NSString *mKey;
    
    
    
}
@property (nonatomic,assign) id<MusicHttpParserDelegateEx>delegate;
@property (nonatomic,retain) NSMutableArray *nArray;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url key:(NSString *)key;
@end
