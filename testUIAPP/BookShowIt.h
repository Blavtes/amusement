//
//  BookShowIt.h
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BookController.h"
#import "BookItem.h"
#import "HttpParser.h"

#import "HttpParserDelegateEx.h"
@class HttpItemParser;
#import "HttpItemParser.h"
#define BOOKITEM_ID 0
#define JSON_ 1
#define XML_ 0 
@interface BookShowIt : UIViewController<UITableViewDataSource,UITableViewDataSource,HttpParserIDDelegateEX>
{
//    BookController *bookcontroller;
    BookItem *bookItem;
//     HttpParser *mHttpParse;
    BOOL isLoading;

     HttpItemParser *mHttpParse;
     int JSon_Xml;
     NSMutableArray *array;

    NSString *sumar;
    UITableViewCell *cell;
    NSMutableArray *arr;
    
//
    NSString *strings;
    UILabel *lableText;
    BookItem *book;

}
@property (nonatomic,retain) NSString *webURL;
@property (nonatomic,assign) BookItem *bookItem;
@property (nonatomic,assign) BookItem *book;

@property (retain, nonatomic) IBOutlet UITableView *myTable;


//- (IBAction)goHome:(id)sender;
-(void)parseCompleteID:(HttpParser *)download;
@end
