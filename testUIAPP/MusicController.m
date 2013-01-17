//
//  MusicController.m
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicController.h"
#import "NSString+URLEncoding.h"
#import "MusicHttpParser.h"
//#import "AppDelegate.h"
#import "MoveHttpParser.h"
#import "MusicItem.h"
#import "MusicCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+URLEncoding.h"
#import "MusicShowItem.h"
#define MUSICNARRAY @"nArray"
@implementation MusicController
@synthesize moveShowItem;
@synthesize  array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) dealloc
{
    [mHttpParse release];
    [array release];
    [moveShowItem release];
    [lastKey release];
    [mTableView release];
    [mTextField release];
}
- (void) viewWillAppear:(BOOL)animated
{
    JSon_Xml = XML_;
    if (JSON_ == JSon_Xml) {
        mHttpParse = [[MusicHttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[MusicHttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    }
    //    mHttpParse=[[HttpParser alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
    mHttpParse.delegate = self;
    
    curPage = 0;
    perCount = 10;
    
    //读取数据库原有内容
    NSString *key = @"周星驰";
    NSString *key1 = [key urlEncodeString];
    NSString *str = [NSString stringWithFormat:@"http://api.douban.com/music/subjects?q=%@&start-index=%d&max-results=%d&apikey=%@",key1,curPage*perCount,perCount,DOUBAN_APP_KEY];
    [mHttpParse parseFromUrl:str key:key];
    isLoading = YES;
    [mTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad]; 
    JSon_Xml = XML_;
    if (JSON_ == JSon_Xml) {
        mHttpParse = [[MusicHttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[MusicHttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    }
    //    mHttpParse=[[HttpParser alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
    mHttpParse.delegate = self;
    
    curPage = 0;
    perCount = 10;
    
    //读取数据库原有内容
    NSString *key = @"周星驰";
    NSString *key1 = [key urlEncodeString];
    NSString *str = [NSString stringWithFormat:@"http://api.douban.com/music/subjects?q=%@&start-index=%d&max-results=%d&apikey=%@",key1,curPage*perCount,perCount,DOUBAN_APP_KEY];
    [mHttpParse parseFromUrl:str key:key];
    isLoading = YES;

//    if (self.array == nil && ShareApp.movieDownArray != nil) {
//        
//
//        self.array = [NSMutableArray arrayWithArray:ShareApp.movieDownArray];
//        //        NSLog(@"array..loding..%@....%@",self.array,ShareApp.movieDownArray);
//    }
    
    
    //    [array addObjectsFromArray:ShareApp.mDatabase.mNewsArray];
    [mTableView reloadData];
    
    self.navigationController.toolbarHidden = NO;
    // Do any additional setup after loading the view from its nib.
}
- (void) musicParseComplete:(MoveHttpParser *)download
{
    NSLog(@"刷新界面");
    if (self.array != nil) {
        [self.array removeAllObjects]; 
    }else{
        self.array = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    //接收解析结果
    [self.array addObjectsFromArray:download.nArray];
    NSLog(@"arr ....%@  ...%@",self.array,download.nArray);
    //刷新界面
    if (self.array != nil) {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:self.array forKey:MUSICNARRAY];
        NSArray *a = [NSArray arrayWithArray:[userInfo objectForKey:MUSICNARRAY]];
        NSLog(@"array.....down..%@.. a.%@",self.array,a);
    }
    
    [mTableView reloadData];
    isLoading = NO;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)searchByKey:(NSString *)key
{
    isLoading = NO;
    
    if (![key isEqualToString:lastKey]) {
        curPage = 0;
    }
    if ([key isEqualToString:@""] == YES) {
        return;
    }
    lastKey = [key copy];
    
    NSString *key1 = [key urlEncodeString];
    //开始搜索
    NSString *str = [NSString stringWithFormat:@"http://api.douban.com/music/subjects?q=%@&start-index=%d&max-results=%d&apikey=%@",key1,curPage*perCount,perCount,DOUBAN_APP_KEY];
    [mHttpParse parseFromUrl:str key:key];
    if (array == nil) {
        array = [[NSMutableArray alloc] initWithCapacity:0];
    }
    isLoading = YES;
}
- (IBAction)preClicked:(id)sender {
    if (![mTextField.text length]) {
        return;
    }
    if (isLoading) {
        return;
    }
    if (curPage>0) {
        
        curPage--;
    }
    else{
        return;
    }
    
    [self searchByKey:lastKey];
}

- (IBAction)nextClicked:(id)sender {
    if (![mTextField.text length]) {
        return;
    }
    if (isLoading) {
        return;
    }
    curPage++;
    
    [self searchByKey:lastKey];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //    NSString *str = [textField.text urlEncodeString];
    [self searchByKey:textField.text];
    
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"arry count...%d，%@",array.count,[array objectAtIndex:0]);
    return [array count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135.0f;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select.....");
    moveShowItem = [[MusicShowItem alloc] initWithNibName:@"MusicShowItem" bundle:nil];
    MusicItem *item = [array objectAtIndex:indexPath.row];
    
    moveShowItem.musicItem = item;
    self.view = moveShowItem.view;
    NSLog(@"movie id ....%@",item.mid);
    //    [bookShow setWebURL:item.mid];
    //    [bookShow setWebURL:item.mid];
    //    [delegaet showBookItem:(BookItem*)item];
    
    //    [self.navigationController pushViewController:bookShow animated:YES];
    [self.navigationController presentModalViewController:moveShowItem animated:YES];
    
    
}
- (void) loadVisuableImage:(UITableView*)tableView
{
    NSArray *visuableCell = [tableView visibleCells];
    for ( MusicCell *cell in visuableCell ) {
        NSIndexPath *path = [tableView indexPathForCell:cell];
        MusicItem *movItem = [array objectAtIndex:path.row];
        [cell.coverImageView setImageWithURL:[NSURL URLWithString:movItem.imageUrl]];
    }
}

//decelerate == yes 正在减速
// decelerate == no 没有减速，已经停下来了。
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    UITableView *tableView = (UITableView*) scrollView;
    if (decelerate == YES) {
        //不需要加载。。还没停下来
    }else if (decelerate == NO){
        [self loadVisuableImage:tableView];
    }
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadVisuableImage:(UITableView*)scrollView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"move.....");
    static NSString *cellName = @"Cell";
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        NSLog(@"llllll");
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MusicCell" owner:self options:nil] lastObject];
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    NSLog(@"cell...%@",cell);
    MusicItem *item = [array objectAtIndex:indexPath.row];
//    cell.textLabel.text = item.titles;
   
    NSLog(@"item %@  %@...%@..%@...%@",item.titles,item.pubDate,item.author,item.publisher,item.imageUrl);
     cell.titleLabel.text = item.titles;
    cell.authorLabel.text = item.author;
    cell.pubDate.text = item.pubDate;
    //    [cell.moveImage setImageWithURL:[NSURL URLWithString:item.imageUrl]];

    cell.rating = [item.rating floatValue];
    if ([item.rating floatValue] > 0) {
        cell.ratLabel.text = [NSString stringWithFormat:@"评分:%0.1f 分",[item.rating floatValue]];
    }
    
    NSLog(@"cell.rating.rating...%f",cell.rating);
#if 0
    UIView *v = [[[UIView alloc] init] autorelease];
    if (indexPath.row %2 == 0) {
        [v setBackgroundColor:[UIColor grayColor]];
    }else{
        [v setBackgroundColor:[UIColor lightGrayColor]];
    }
    cell.backgroundView = v;
#endif
    return cell;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
#if 0
    if (indexPath.row %2 == 0) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }else{
        cell.backgroundColor = [UIColor grayColor];
    }
#endif
}
@end
