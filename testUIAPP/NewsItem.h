//
//  NewsItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
@interface NewsItem : NSObject
{
    NSString *_nwTitle;
    NSString *_nwDate;
    NSString *_nwUrl;
    NSString *_nwAuthor;
    NSString *_nwText;
}
@property (nonatomic,copy) NSString *nwTitle;
@property (nonatomic,copy) NSString *nwDate;
@property (nonatomic,copy) NSString *nwUrl;
@property (nonatomic,copy) NSString *nwAuthor;
@property (nonatomic,copy) NSString *nwText;
@end
