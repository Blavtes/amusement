//
//  BookItem.m
//  DoubanDemo1
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookItem.h"

@implementation BookItem
@synthesize title,pubdate,author,summary,authorInfo,imageurl,mid,authors,attr,mdescription,keystr,mCount,rating,price,publisher;
-(void)dealloc
{
    self.rating = nil;
    self.authorInfo = nil;
    self.summary = nil;
    self.title=nil;
    self.author=nil;
    self.keystr=nil;
    self.authors = nil;
    self.mid=nil;
    self.imageurl=nil;
    self.pubdate = nil;
    self.attr=nil;
    self.mdescription=nil;
    self.publisher = nil;
    self.price = nil;
    [super dealloc];
}
@end
