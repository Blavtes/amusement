//
//  SignItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignItem : NSObject
{
    NSString *title;
    NSString *descripitions;
    NSString *link;
    NSString *pubDate;
    NSString *author;
    NSString *category;
    NSString *guid;
    NSString *comments;
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *descriptions;
@property (nonatomic,retain) NSString *link;
@property (nonatomic,retain) NSString *pubDate;
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSString *category;
@property (nonatomic,retain) NSString *guid;
@property (nonatomic,retain) NSString *comments;

@end
