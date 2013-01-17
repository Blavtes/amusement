//
//  NewHttpParserDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MoveHttpParser;
@protocol MoveHttpParserDelegateEx <NSObject>
-(void)parseComplete:(MoveHttpParser*)download;
@end
