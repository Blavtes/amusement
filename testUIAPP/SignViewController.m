//
//  SignViewController.m
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignViewController.h"
#import "SignHttpDownload.h"
#import "SignItem.h"
#import "SignShowItem.h"
#import "NewsWebController.h"
@implementation SignViewController
@synthesize array,subArray;

static NSString *const TopPaidAppsFeed =
@"http://feeds.qzone.qq.com/cgi-bin/cgi_rss_out?uin=772937290";
static NSString *const moreUrl = @"http://772937290.qzone.qq.com/";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        array = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void) startDownLoad
{
    SignHttpDownload *httpDownload = [[SignHttpDownload alloc] init];
    httpDownload.delegate = self;
    [httpDownload downloadFromUrl: TopPaidAppsFeed];
}
//- (void) viewWillAppear:(BOOL)animated
//{
//    if (array.count  == 0 &&isLoading == NO) {
//        isLoading = YES;
//    NSLog(@".begin..isloading...");
//        [self startDownLoad];
//    }
//    
//    [myTabelView reloadData];
//}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    isLoading = NO;
    if (array.count  == 0 &&isLoading == NO) {
        isLoading = YES;
        NSLog(@".begin..isloading...");
        [self startDownLoad];
    }
    [myTabelView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) cutStringWithDescription:(NSString*)des
{
    int n = 0;
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:0];
    NSMutableString *stringEnd = [[NSMutableString alloc] initWithCapacity:0];
    //分割< @$@#>
    for (int i = 0; i < des.length-1; i++) {
        NSString *str1 = [des substringWithRange:NSMakeRange(i, 1)];
        if ([str1 isEqualToString:@"<"] != YES ) {
            [string appendString:str1];
        }else{
            for (int j = i; j < des.length - 1; j ++) {
                NSString *str2 = [des substringWithRange:NSMakeRange(j+1, 1)];
                if ([str2 isEqualToString:@">"] == YES){
                    n = j+1-i;
                    break;
                }
            }
            i += n;
        }
    }
    //分割 [url/url]
    for (int i = 0; i < string.length-1; i++) {
        NSString *str1 = [string substringWithRange:NSMakeRange(i, 1)];
        if ([str1 isEqualToString:@"["] != YES ) {
            [stringEnd appendString:str1];
            //            NSLog(@"string...%@",string);
        }else{
            for (int j = i; j < string.length - 1; j ++) {
                NSString *str2 = [string substringWithRange:NSMakeRange(j+1, 1)];
                if ([str2 isEqualToString:@"]"] == YES){
                    n = j+1-i;
                    break;
                }
            }
            i += n;
        }
    }
    [subArray addObject:stringEnd];
//    NSLog(@"....stings cut ..%@",string);

}
- (void) signDownloadComplete:(NSArray *)newArray
{
    NSLog(@"download ssign......%d.",newArray.count);
    if (array != nil) {
        [array removeAllObjects];
    }
    array = [[NSMutableArray alloc] initWithCapacity:0];
    subArray  = [[NSMutableArray alloc] initWithCapacity:0];
    for (SignItem *item  in newArray) {
        
        NSString *des = item.descriptions;
        [self cutStringWithDescription:des];

//        NSLog(@"descr..item...%@",str);
        
//        NSLog(@"author....%@",item.author);
    }
    for (int i = 0; i < [newArray count]; i++) {
        SignItem *item = [[SignItem alloc] init];
        item.title = ((SignItem*)[newArray objectAtIndex:i]).title;
        item.author = ((SignItem*)[newArray objectAtIndex:i]).author;
        item.category = ((SignItem*)[newArray objectAtIndex:i]).category;
        item.link = ((SignItem*)[newArray objectAtIndex:i]).link;
        item.pubDate = ((SignItem*)[newArray objectAtIndex:i]).pubDate;
        item.descriptions = [subArray objectAtIndex:i];
        item.comments = ((SignItem*)[newArray objectAtIndex:i]).comments;
        [self.array addObject:item];
        [item release];
    }
    [myTabelView reloadData];
    isLoading = NO;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"...array count %d",[array count]);
    return [array count]+1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor grayColor];
    }
    else {
        cell.backgroundColor=[UIColor lightGrayColor];
    }
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"SignCell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    if (indexPath.row < array.count) {        
        SignItem *item = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = item.title;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }else{
        cell.textLabel.text = @"查看更多...";
         cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return cell;
   
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"....didselectRow");
    if (indexPath.row < array.count) {
        SignItem *item = [array objectAtIndex:indexPath.row];
        showItem = [[SignShowItem alloc] initWithNibName:@"SignShowItem" bundle:nil];
        showItem.item = item;
        self.view = showItem.view;
        [self.navigationController presentModalViewController:showItem animated:YES];
    }else{
        NewsWebController *newsWeb = [[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil];
        [newsWeb setWebURL:moreUrl];
        
        self.view = newsWeb.view;
        [self.navigationController presentModalViewController:newsWeb animated:YES];
    }
    
    
}
@end
