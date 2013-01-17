//
//  NSString+URLEncoding.m
//  DoubanBook
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)
- (NSString*) urlEncodeString
{
    NSString *result = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@";/?:@&=$+{}<>,",kCFStringEncodingUTF8);
    return [result autorelease];
}
@end
