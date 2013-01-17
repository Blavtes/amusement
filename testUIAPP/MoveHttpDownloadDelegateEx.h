//
//  NewHttpDownloadDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MoveHttpDownload;
@protocol MoveHttpDownloadDelegateEx <NSObject>
- (void) downloadComplete:(MoveHttpDownload*)delegate;
@end
