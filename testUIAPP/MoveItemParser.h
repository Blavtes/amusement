//
//  MoveItemParser.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveItemDownloadDelegateEx.h"
#import "MoveItemParserDelegateEx.h"
#import "MoveItemDownload.h"
@interface MoveItemParser : NSObject<MoveItemDownloadDelegateEx>
{
    id<MoveItemParserDelegateEx>delegate;
    
    MoveItemDownload *nHttpDownload;
    NSInteger nDownloadType;
    NSInteger nParseType;
    NSMutableArray *nArray;
    NSString *mKey;
    
    
    
}
@property (nonatomic,assign) id<MoveItemParserDelegateEx>delegate;
@property (nonatomic,retain) NSMutableArray *nArray;

-(id)initWithType:(NSInteger)type parseType:(NSInteger)pType;

-(void)parseFromUrl:(NSString*)url;
@end
