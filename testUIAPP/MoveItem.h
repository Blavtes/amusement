//
//  MoveItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface MoveItem : NSObject
{
    NSString *name;
    //演员
    NSString *cast;
    NSString *year;
    NSString *language;
    NSString *director;
    NSString *imageUrl;
    NSString *author;
    NSString *authorInfo;
//    详情
    NSString *summary;
    NSString *keystr;
    NSString *mid;
    NSString *country;
    NSString *duration;
    NSString *types;
    NSString *rating;
}
@property (nonatomic,retain) NSString *rating;
@property (nonatomic,retain) NSString *duration;
@property (nonatomic,retain) NSString *types;
@property (nonatomic,retain) NSString *authorInfo;
@property (nonatomic,retain) NSString *country;
@property (nonatomic,retain) NSString *mid;
@property (nonatomic,retain) NSString *keystr;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *cast;
@property (nonatomic,retain) NSString *year;
@property (nonatomic,retain) NSString *language;
@property (nonatomic,retain) NSString *director;
@property (nonatomic,retain) NSString *imageUrl;
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSString *summary;
@end
