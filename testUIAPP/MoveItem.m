//
//  MoveItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveItem.h"

@implementation MoveItem
@synthesize name,country,mid,types,rating,duration,author,cast,year,authorInfo,summary,director,language,imageUrl,keystr;
- (void) dealloc
{
    self.rating = nil;
    self.duration = nil;
    self.types = nil;
    self.authorInfo = nil;
    self.mid = nil;
    self.country = nil;
    self.name = nil;
    self.keystr = nil;
    self.author = nil;
    self.language = nil;
    self.cast = nil;
    self.summary = nil;
    self.director = nil;
    self.imageUrl = nil;
    self.year = nil;
    
}
@end
