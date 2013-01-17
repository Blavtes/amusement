//
//  MusicItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicItem.h"

@implementation MusicItem
@synthesize titles,mid,rating,author,imageUrl,summary,keystr,pubDate,publisher;
- (void) dealloc
{
    self.summary = nil;
    self.rating = nil;
    self.pubDate = nil;
    self.mid = nil;
    self.publisher = nil;
    self.titles = nil;
    self.keystr = nil;
    self.author = nil;
    self.imageUrl = nil;
}
@end
