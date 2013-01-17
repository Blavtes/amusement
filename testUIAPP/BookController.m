//
//  RootViewController.m
//  XmlDemo
//
///  Created by qianfeng on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "BookController.h"
#import "HttpParser.h"
#import "BookCell.h"
#import "BookItem.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "QFDatabase.h"
#import "KeyListViewController.h"
#import "NSString+URLEncoding.h"
#import "BookShowIt.h"
@interface  BookController ()

@end

@implementation BookController
//@synthesize delegaet;
@synthesize bookShow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}
-(IBAction)SearchHistoryClicked:(id)sender
{
    KeyListViewController *list = [[[KeyListViewController alloc] initWithNibName:@"KeyListViewController" bundle:nil] autorelease];
    list.delegate = self;
    list.method = @selector(searchByKey:);
    [self presentModalViewController:list animated:YES];
    [self.navigationController pushViewController:list animated:YES];
//    [self dismissModalViewControllerAnimated:YES];
}
//上一页按钮响应方法
-(IBAction)preClicked:(id)sender
{
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


//下一页按钮响应方法
-(IBAction)nextClicked:(id)sender
{
    if (![mTextField.text length]) {
        return;
    }
    if (isLoading) {
        return;
    }
    curPage++;
    
    [self searchByKey:lastKey];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    JSon_Xml = XML_;
    if (JSON_ == JSon_Xml) {
        mHttpParse = [[HttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[HttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    }
    //    mHttpParse=[[HttpParser alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
    mHttpParse.delegate = self;
    
    curPage = 0;
    perCount = 10;
    
    //读取数据库原有内容
    [ShareApp.mDatabase readDataWithFMDB:nil page:curPage count:0];
    array=[[NSMutableArray alloc] initWithCapacity:0];
    [array addObjectsFromArray:ShareApp.mDatabase.mNewsArray];
    [mTableView reloadData];

    self.navigationController.toolbarHidden = NO;
    
    
    
    
}
-(void)parseComplete:(HttpParser *)download
{
    NSLog(@"刷新界面");
    
    [array removeAllObjects];
    
    //接收解析结果
    [array addObjectsFromArray:download.mArray];
    
    [ShareApp.mDatabase insertToDatabase:array];
    
    //刷新界面
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)searchByKey:(NSString *)key
{
    isLoading=NO;
    
    if (![key isEqualToString:lastKey]) {
        curPage=0;
    }
    if ([key isEqualToString:@""]==YES) {
        return;
    }
    lastKey=[key copy];
    if ([ShareApp.mDatabase isExistKey:key]) {
        
        //数据库中记录条数少于要查看的条数就要启动网络请求，否则读数据库中数据 
        if ([ShareApp.mDatabase getCountByKey:key]>curPage*perCount) {
            
            [ShareApp.mDatabase readDataWithFMDB:key page:curPage count:perCount];
            
            //清空原有数据
            [array removeAllObjects];
            [array addObjectsFromArray:ShareApp.mDatabase.mNewsArray];
            [mTableView reloadData];
            return;
            
        }
        
    }
    NSString *key1 = [key urlEncodeString];
    //开始搜索
    NSString *str=[NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&start-index=%d&max-results=%d&apikey=%@",key1,curPage*perCount,perCount,DOUBAN_APP_KEY];
    [mHttpParse parseFromUrl:str key:key];
    isLoading=YES;
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
    return [array count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135.0f;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select.....");
    bookShow = [[BookShowIt alloc] initWithNibName:@"BookShowIt" bundle:nil];
    BookItem *item = [array objectAtIndex:indexPath.row];

    bookShow.bookItem = item;
    self.view = bookShow.view;
//    NSLog(@"item ...%@.....show   %@   id%@",item.title,bookShow.title.text,item.mid);
//    [bookShow setWebURL:item.mid];
//    [bookShow setWebURL:item.mid];
//    [delegaet showBookItem:(BookItem*)item];

//    [self.navigationController pushViewController:bookShow animated:YES];
    [self.navigationController presentModalViewController:bookShow animated:YES];

    
}
- (void) loadVisuableImage:(UITableView*)tableView
{
    NSArray *visuableCell = [tableView visibleCells];
    for ( BookCell *cell in visuableCell ) {
        NSIndexPath *path = [tableView indexPathForCell:cell];
        BookItem *bookItem = [array objectAtIndex:path.row];
        [cell.coverImageView setImageWithURL:[NSURL URLWithString:bookItem.imageurl]];
    }
}
//为什么用 异步下载 为了 肥皂滑  ui 流畅
// 1. 图片数据异步从网上下载
// 2. 需要图片的是否 下载
// (滚动停止 下载)
// 3. 下载完成 缓存起来

//手离开 就调用
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
    NSLog(@"auhoritwm.....");
    static NSString*cellName=@"cellName";
    BookCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil] lastObject];
    }
    BookItem *item=[array objectAtIndex:indexPath.row];
    cell.titleLabel.text=item.title;

    NSMutableString *author = [[[NSMutableString alloc] initWithCapacity:0] autorelease];
    for (NSString *str in item.author) {
        [author appendString:@"["];
        [author appendString:str];
        [author appendString:@"]"];
    }
    cell.authorLabel.text=author;
    NSLog(@"auhoritwm %@  is %@",item.author,author);
    cell.publisher.text=item.publisher;
    cell.price.text = item.price;
//    [cell.coverImageView setImageWithURL:[NSURL URLWithString:item.imageurl]];
    cell.rating = [item.rating floatValue];
    if ([item.rating floatValue] > 0) {
         cell.ratLabel.text = [NSString stringWithFormat:@"评分:%0.1f 分",[item.rating floatValue]];
    }
    NSLog(@"cell.rating.rating...%f",cell.rating);
    
//    UIView *v = [[[UIView alloc] init] autorelease];
//    if (indexPath.row %2 == 0) {
//        [v setBackgroundColor:[UIColor grayColor]];
//    }else{
//        [v setBackgroundColor:[UIColor lightGrayColor]];
//    }
//    cell.backgroundView = v;
    
    return cell;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
//    if (indexPath.row %2 == 0) {
//        cell.backgroundColor = [UIColor lightGrayColor];
//    }else{
//        cell.backgroundColor = [UIColor grayColor];
//    }
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
////    BookItem *item = [array objectAtIndex:indexPath.row];
//  
//    
////    [self dismissModalViewControllerAnimated:YES];
//}
@end