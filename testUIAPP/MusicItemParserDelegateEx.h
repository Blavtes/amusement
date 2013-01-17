//
//  MusicItemParserDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicItemParser;
@protocol MusicItemParserDelegateEx <NSObject>
-(void)musicParseComplete:(MusicItemParser*)download;
@end
