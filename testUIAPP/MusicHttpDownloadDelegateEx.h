//
//  MusicHttpDownloadDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicHttpDownload;
@protocol MusicHttpDownloadDelegateEx <NSObject>
- (void) musicDownloadComplete:(MusicHttpDownload*)delegate;
@end
