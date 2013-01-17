//
//  MuiscShowItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicItemParserDelegateEx.h"
@class MusicItem;
@class MusicItemParser;
@class MusicShowItem;

#define JSON_ 1
#define XML_ 0 

#define DOUBAN_APP_KEY @"00f083deac336b8f02d18b9c049a42ad"
@interface MusicShowItem : UIViewController<UITableViewDataSource,UITableViewDelegate,MusicItemParserDelegateEx>
{
    MusicItem *musicItem;
    int JSon_Xml;
    //解析类实例
    MusicItemParser *mHttpParse;
    
    NSMutableArray *array;
    BOOL isLoading;
    NSString *sumar;
    UITableViewCell *cell;
    NSMutableArray *arr;
    MusicShowItem *musicshow;
    MusicItem *mus;
    NSString *strings;
}
@property (nonatomic,retain) NSString *sumar;
@property (nonatomic,retain) MusicItem *musicItem;

@property (retain, nonatomic) IBOutlet UITableView *myTable;
- (void) musicParseComplete:(MusicItemParser *)download;
@end
