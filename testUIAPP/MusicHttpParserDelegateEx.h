//
//  MusicHttpParserDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicHttpParser;
@protocol MusicHttpParserDelegateEx <NSObject>
-(void)musicParseComplete:(MusicHttpParser*)download;
@end
