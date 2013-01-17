//
//  TenHttpParseDelegate.h
//  HtmlParserTest
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TenHttpParse;
@protocol TenHttpParseDelegate <NSObject>
-(void)parseComplete:(TenHttpParse*)download;
@end
