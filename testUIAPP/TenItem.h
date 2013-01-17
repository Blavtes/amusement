//
//  TenItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenItem : NSObject
{
    NSString *title;
    NSString *descriptions;
    NSString *pubDate;
    NSString *link;
    NSString *guid;
    
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *descriptions;
@property (nonatomic,retain) NSString *pubDate;
@property (nonatomic,retain) NSString *link;
@property (nonatomic,retain) NSString *guid;
@end
