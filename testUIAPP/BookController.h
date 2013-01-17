//
//  BookController.h
//  testUIAPP
//
//  Created by yong on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpParserDelegate.h"

#define JSON_ 1
#define XML_ 0 

#define DOUBAN_APP_KEY @"00f083deac336b8f02d18b9c049a42ad"
@class HttpParser;

@class BookShowIt;
//@protocol BookControllerEx <NSObject>
//
//- (void) showBookItem:(BookItem*)book;
//
//@end
@interface BookController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,HttpParserDelegate>
{
    IBOutlet UITextField* mTextField;
    IBOutlet UITableView *mTableView;
    int JSon_Xml;
    //解析类实例
    HttpParser *mHttpParse;
    
    NSMutableArray *array;
    
    NSInteger curPage;
    NSInteger perCount;
    NSInteger totalCount;
    BOOL isLoading;
    NSString *lastKey;
    BookShowIt *bookShow;
//    id <BookControllerEx>delegaet;
    

}
@property (nonatomic,retain) BookShowIt *bookShow;
//@property (nonatomic,retain) id<BookControllerEx> delegaet;
- (IBAction)preClicked:(id)sender;
- (IBAction)nextClicked:(id)sender;
-(void)searchByKey:(NSString*)key;
//-(IBAction)SearchHistoryClicked:(id)sender;

@end