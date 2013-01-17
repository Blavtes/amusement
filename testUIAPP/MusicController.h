//
//  MusicController.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MusicHttpParserDelegateEx.h"

#define JSON_ 1
#define XML_ 0 

#define DOUBAN_APP_KEY @"00f083deac336b8f02d18b9c049a42ad"
@class MusicHttpParser;

@class MusicShowItem;

@interface MusicController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MusicHttpParserDelegateEx>
{
    IBOutlet UITextField* mTextField;
    IBOutlet UITableView *mTableView;
    int JSon_Xml;
    //解析类实例
    MusicHttpParser *mHttpParse;
    
    NSMutableArray *array;
    
    NSInteger curPage;
    NSInteger perCount;
    NSInteger totalCount;
    BOOL isLoading;
    NSString *lastKey;
    MusicShowItem *moveShowItem;
    //    id <BookControllerEx>delegaet;
    
    
}
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) MusicShowItem *moveShowItem;
//@property (nonatomic,retain) id<BookControllerEx> delegaet;
- (IBAction)preClicked:(id)sender;
- (IBAction)nextClicked:(id)sender;
-(void)searchByKey:(NSString*)key;

@end
