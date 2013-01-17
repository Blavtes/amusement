//
//  MoveShowItem.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveItemParserDelegateEx.h"
@class MoveItem;
@class MoveItemParser;
@class MovieShow;

#define JSON_ 1
#define XML_ 0 

#define DOUBAN_APP_KEY @"00f083deac336b8f02d18b9c049a42ad"
@interface MoveShowItem : UIViewController<UITableViewDataSource,UITableViewDelegate,MoveItemParserDelegateEx>
{
    MoveItem *moveItem;
    int JSon_Xml;
    //解析类实例
    MoveItemParser *mHttpParse;
    
    NSMutableArray *array;
    BOOL isLoading;
    NSString *sumar;
    UITableViewCell *cell;
    NSMutableArray *arr;
    MovieShow *moveshow;
    MoveItem *mov;
    NSString *strings;
}
@property (nonatomic,retain) NSString *sumar;
@property (nonatomic,retain) MoveItem *moveItem;

@property (retain, nonatomic) IBOutlet UITableView *myTable;
- (void) parseComplete:(MoveItemParser *)download;
@end
