//
//  CartoonDownloadDelegate.h
//  testUIAPP
//
//  Created by Yong on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CartoonDownloadDelegate <NSObject>

-(void)cartoonDownloadComplete:(NSArray*)array;
@end
