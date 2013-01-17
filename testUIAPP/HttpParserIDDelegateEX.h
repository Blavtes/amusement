//
//  HttpParserIDDelegateEX.h
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpItemParser;
@protocol HttpParserIDDelegateEX <NSObject>
- (void) parseCompleteID:(HttpItemParser*)download;
@end
