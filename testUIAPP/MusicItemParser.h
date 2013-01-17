//
//  MusicItemParser.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "MusicItemDownloadDelegateEx.h"
#import "MusicItemParserDelegateEx.h"
#import "MusicItemDownload.h"
@interface MusicItemParser : NSObject<MusicItemDownloadDelegateEx>
{
    id<MusicItemParserDelegateEx>delegate;
    
    MusicItemDownload *nHttpDownload;
    NSInteger nDownloadType;
    NSInteger nParseType;
    NSMutableArray *nArray;
    NSString *mKey;
    
    
    
}
@property (nonatomic,assign) id<MusicItemParserDelegateEx>delegate;
@property (nonatomic,retain) NSMutableArray *nArray;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url;
@end
