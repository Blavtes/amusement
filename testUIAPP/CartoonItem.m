//
//  CartoonItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CartoonItem.h"

@implementation CartoonItem
@synthesize title;
@synthesize link;
@synthesize author;
@synthesize guid;
@synthesize category;
@synthesize pubDate;
@synthesize comments;
@synthesize description;
@synthesize imageArrayUrl;
-(void)dealloc
{
    [imageArrayUrl release];
    [title release];
    [link release];
    [author release];
    [guid release];
    [category release];
    [pubDate release];
    [comments release];
    [description release];
    
    [super dealloc];
}
@end
