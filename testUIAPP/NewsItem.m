//
//  NewsItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

@synthesize nwUrl = _nwUrl;
@synthesize nwDate = _nwDate,nwText = _nwText,nwTitle = _nwTitle,nwAuthor = _nwAuthor;

- (void) dealloc
{
    self.nwUrl = nil;
    self.nwTitle = nil;
    self.nwText = nil;
    self.nwDate = nil;
    self.nwAuthor = nil;
    [super dealloc];
}
@end
