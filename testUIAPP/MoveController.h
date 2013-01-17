//
//  MoveController.h
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveHttpParserDelegateEx.h"
#define JSON_ 1
#define XML_ 0 

#define DOUBAN_APP_KEY @"00f083deac336b8f02d18b9c049a42ad"
@class MoveHttpParser;

@class MoveShowItem;
@interface MoveController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MoveHttpParserDelegateEx>
{
    IBOutlet UITextField* mTextField;
    IBOutlet UITableView *mTableView;

    int JSon_Xml;
    //解析类实例
    MoveHttpParser *mHttpParse;
    
    NSMutableArray *array;
    
    NSInteger curPage;
    NSInteger perCount;
    NSInteger totalCount;
    BOOL isLoading;
    NSString *lastKey;
    MoveShowItem *moveShowItem;
}
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) MoveShowItem *moveShowItem;
- (IBAction)preClicked:(id)sender;
- (IBAction)nextClicked:(id)sender;
-(void)searchByKey:(NSString*)key;
@end
