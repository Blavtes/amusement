//
//  HttpParserDelegate.h
//  XmlDemo
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpParser;
@protocol HttpParserDelegate <NSObject>
//解析完成协议方法
-(void)parseComplete:(HttpParser*)download;






@end
