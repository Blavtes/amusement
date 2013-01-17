//
//  TenItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TenItem.h"

@implementation TenItem
@synthesize title,descriptions,guid,link,pubDate;
- (void) dealloc{
    self.title  = nil;
    self.descriptions = nil;
    self.guid = nil;
    self.link = nil;
    self.pubDate = nil;
    [super dealloc];
}
@end
