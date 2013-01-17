//
//  MusicItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicItem : NSObject

{
    NSString *titles;
    //演员

    NSString *imageUrl;
    NSString *author;
    //    详情
    NSString *summary;
    NSString *keystr;
    NSString *mid;

    NSString *pubDte;
    NSString *publisher;

    NSString *rating;
    
    
}
@property (nonatomic,retain) NSString *rating;
@property (nonatomic,retain) NSString *summary;
@property (nonatomic,retain) NSString *mid;
@property (nonatomic,retain) NSString *keystr;
@property (nonatomic,retain) NSString *titles;
@property (nonatomic,retain) NSString *imageUrl;
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSString *pubDate;
@property (nonatomic,retain) NSString *publisher;
@end

