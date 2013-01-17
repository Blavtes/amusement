//
//  NewsItem.m
//  XmlParserDemo
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Humorous.h"

@implementation Humorous
@synthesize title;
@synthesize link;
@synthesize author;
@synthesize guid;
@synthesize category;
@synthesize pubDate;
@synthesize comments;
@synthesize description;

-(void)dealloc
{
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
