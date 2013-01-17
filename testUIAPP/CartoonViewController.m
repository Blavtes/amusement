//
//  CartoonViewController.m
//  testUIAPP
//
//  Created by Yong on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CartoonViewController.h"
#import "CartoonHttpDownLoad.h"
#import "CartoonItem.h"
#import "UIImageView+WebCache.h"
#import "CartoonShowCV.h"
#import "NewsWebController.h"
@implementation CartoonViewController

static NSString *const TopPaidAppsFeed =
@"http://feeds.qzone.qq.com/cgi-bin/cgi_rss_out?uin=622000418";
static NSString *const moreUrl = @"http://622000418.qzone.qq.com/";
@synthesize subArray;
@synthesize array;
@synthesize mXibTableView;
- (void) dealloc
{
    [subArray release];
    [arrowView release];
    [array release];

    [httpdownload release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"loading.....CartoonView");
        array = [[NSArray alloc] init];
        subArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)startDownload
{
    NSLog(@"startDownload...");
    httpdownload=[[CartoonHttpDownLoad alloc] init];
    httpdownload.delegate=self;
    
    
    [httpdownload cartoonDownloadFromUrl:TopPaidAppsFeed];
}
- (void) viewWillAppear:(BOOL)animated
{
    if (subArray.count == 0) {
        [self startDownload];

    }
    [mXibTableView reloadData];
}
#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    static int index;
    NSLog(@"viewDidLoad..%d",index);
    [mXibTableView reloadData];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //[mCodeTableView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        self.view.frame = CGRectMake(0, 0, 320, 343);
//        
//    }else{
//        self.view.frame = CGRectMake(0, 0, 480, 320);
//        self.mXibTableView.frame = CGRectMake(0, 0, 480, 320);
//    }
    return YES;
}

#pragma mark - UITableView Delegate Start
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"subarray count >...%d",[subArray count]);
    return [subArray count]+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor grayColor];
    }
    else {
        cell.backgroundColor=[UIColor lightGrayColor];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"set cell..tebleView");
    static NSString* cellName=@"CustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    if (indexPath.row < subArray.count) {
        cell.textLabel.text = ((CartoonItem*)[subArray objectAtIndex:indexPath.row]).title;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.numberOfLines = 0;
    }else{
        cell.textLabel.text = @"查看更多...";
         cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < subArray.count ) {
        NSLog(@"...imag %@",((CartoonItem*)[subArray objectAtIndex:indexPath.row]).imageArrayUrl);
        NSArray *imgArray = [NSArray arrayWithArray:((CartoonItem*)[subArray objectAtIndex:indexPath.row]).imageArrayUrl];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < imgArray.count - 1; i++) {
            NSString *imgUrl = [imgArray objectAtIndex:i];
            NSString *imgUrl1 = [imgArray objectAtIndex:i+1];
            if ([imgUrl isEqualToString:imgUrl1] == YES) {
                continue;
            }else{
                [arr addObject:imgUrl];
            }
        }
        NSLog(@"imagr...%@",arr);
        
        CartoonShowCV *cart = [[CartoonShowCV alloc] initWithNibName:@"CartoonShowCV" bundle:nil];
        cart.imagUrlArray = [NSArray arrayWithArray:arr];
        
        self.view = cart.view;
        
        [self.navigationController presentModalViewController:cart animated:YES];
    
    }else{
        NewsWebController *newsWeb = [[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil];
        [newsWeb setWebURL:moreUrl];
        
        self.view = newsWeb.view;
        [self.navigationController presentModalViewController:newsWeb animated:YES];
    }
}
- (void) cutStringWithPic:(NSString*)des
{
    NSLog(@"cut description..");
    static NSString *s = @"http://user.qzone.qq.com/622000418/blog/";
    NSArray *arrays = [des componentsSeparatedByString:@"\""];
    for (int i = 0; i < [arrays count]; i++) {
        NSString *string = [arrays objectAtIndex:i];
        if (string.length >7 &&[[string substringWithRange:NSMakeRange(0, 7)] isEqualToString:@"http://"] == YES) {
            
            if ([[string substringWithRange:NSMakeRange(0, s.length)] isEqualToString:s] != YES) {
                [imageArray addObject:string];
            }
            
        }
    }
    //    [imageArray addObject:subArray];
}
#pragma mark -DownloadCompleteDelegate
-(void)cartoonDownloadComplete:(NSArray *)newArray
{
    array=[newArray retain];
    NSLog(@"....cartoon delegate");
    
    for (CartoonItem *item  in newArray) {
        imageArray = [[NSMutableArray alloc] initWithCapacity:0];
        NSString *des = item.description;
//        NSLog(@"...,,..%@.des %d",item.category,des.length);
        [self cutStringWithPic:des];
        item.imageArrayUrl = [NSArray arrayWithArray:imageArray];
        [subArray addObject:item];
    }
//    for (CartoonItem  *s  in subArray) {
//        
//        NSLog(@"sub strings ...%d.....img.%@.%@",[subArray count],[s imageArrayUrl],s);
//    }
    [mXibTableView reloadData];
    
}

@end
