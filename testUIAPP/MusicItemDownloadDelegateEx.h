//
//  MusicItemDownloadDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MusicItemDownload;
@protocol MusicItemDownloadDelegateEx <NSObject>


- (void) musicDownloadComplete:(MusicItemDownload*)delegate;
@end
