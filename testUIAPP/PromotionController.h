//
//  PromotionController.h
//  testUIAPP
//
//  Created by Yong on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenHttpParseDelegate.h"
@class TenHttpParse;

@interface PromotionController : UIViewController<NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate,TenHttpParseDelegate>{

    TenHttpParse *mHttpParse;
    NSMutableArray *downArray;
    UITableViewCell *cell;
    NSMutableArray *itemArray;
    NSMutableString *tempString;
    BOOL isLoading;
}
@property (nonatomic,retain) NSMutableArray *itemArray;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end