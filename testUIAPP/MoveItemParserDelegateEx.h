//
//  MoveItemParserDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MoveItemParser;
@protocol MoveItemParserDelegateEx <NSObject>
-(void)parseComplete:(MoveItemParser*)download;
@end
