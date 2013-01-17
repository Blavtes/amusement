//
//  SignDownLoadDelegate.h
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SignDownLoadDelegate <NSObject>
-(void)signDownloadComplete:(NSArray*)array;
@end
