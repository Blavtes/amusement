//
//  SignItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignItem.h"

@implementation SignItem
@synthesize title,author,link,guid,descriptions,category,pubDate,comments;
- (void) dealloc
{
    self.title = nil;
    self.author = nil;
    self.link = nil;
    self.guid = nil;
    self.descriptions = nil;
    self.category = nil;
    self.pubDate = nil;
    self.comments = nil;
}
@end
