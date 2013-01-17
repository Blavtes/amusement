//
//  HttpDownloadIDDelegateEx.h
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpItemDownload;
@protocol HttpDownloadIDDelegateEx <NSObject>
-(void)downloadCompleteID:(HttpItemDownload*)download;
@end
