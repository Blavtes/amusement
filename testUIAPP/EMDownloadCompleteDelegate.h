//
//  DownloadCompleteDelegate.h
//  JsonParserDemo
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EMDownloadCompleteDelegate <NSObject>

-(void)downloadComplete:(NSArray*)array;

@end
