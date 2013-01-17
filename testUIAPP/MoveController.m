//
//  MoveController.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveController.h"
#import "MoveHttpParser.h"
#import "MoveItem.h"
#import "MoveCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+URLEncoding.h"
#import "MoveShowItem.h"
#define MOVENARRAY @"nArray"
#import "AppDelegate.h"
@implementation MoveController
@synthesize moveShowItem;
@synthesize array;
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
- (void)viewDidLoad
{
    [super viewDidLoad]; 
    JSon_Xml = XML_;
    if (JSON_ == JSon_Xml) {
        mHttpParse = [[MoveHttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[MoveHttpParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    }
    //    mHttpParse=[[HttpParser alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
    mHttpParse.delegate = self;
    
    curPage = 0;
    perCount = 10;
    
    //读取数据库原有内容
    NSString *key = @"周星驰";
    NSString *key1 = [key urlEncodeString];
    NSString *str=[NSString stringWithFormat:@"http://api.douban.com/movie/subjects?q=%@&start-index=%d&max-results=%d&apikey=%@",key1,curPage*perCount,perCount,DOUBAN_APP_KEY];
    [mHttpParse parseFromUrl:str key:key];
    isLoading=YES;
//    [ShareApp.mDatabase readDataWithFMDB:nil page:curPage count:0];
    if (self.array == nil && ShareApp.movieDownArray != nil) {
        
//        self.array = [[NSUserDefaults standardUserDefaults] objectForKey:@"movieDowning"];
         self.array = [NSMutableArray arrayWithArray:ShareApp.movieDownArray];
//        NSLog(@"array..loding..%@....%@",self.array,ShareApp.movieDownArray);
    }

    
//    [array addObjectsFromArray:ShareApp.mDatabase.mNewsArray];
    [mTableView reloadData];
    
    self.navigationController.toolbarHidden = NO;
    // Do any additional setup after loading the view from its nib.
}
- (void) parseComplete:(MoveHttpParser *)download
{
    NSLog(@"刷新界面");
    if (array != nil) {
       [array removeAllObjects]; 
    }
    
    
    //接收解析结果
    [array addObjectsFromArray:download.nArray];
    NSLog(@"arr ....%@  ...%@",array,download.nArray);
    //刷新界面
    if (self.array != nil) {
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
         [userInfo setObject:self.array forKey:MOVENARRAY];
        NSArray *a = [NSArray arrayWithArray:[userInfo objectForKey:MOVENARRAY]];
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
    isLoading=NO;
    
    if (![key isEqualToString:lastKey]) {
        curPage=0;
    }
    if ([key isEqualToString:@""]==YES) {
        return;
    }
    lastKey=[key copy];

    NSString *key1 = [key urlEncodeString];
    //开始搜索
    NSString *str=[NSString stringWithFormat:@"http://api.douban.com/movie/subjects?q=%@&start-index=%d&max-results=%d&apikey=%@",key1,curPage*perCount,perCount,DOUBAN_APP_KEY];
    [mHttpParse parseFromUrl:str key:key];
    if (array == nil) {
        array=[[NSMutableArray alloc] initWithCapacity:0];
    }
    isLoading=YES;
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
    return [array count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select.....");
    moveShowItem = [[MoveShowItem alloc] initWithNibName:@"MoveShowItem" bundle:nil];
    MoveItem *item = [array objectAtIndex:indexPath.row];
    
    moveShowItem.moveItem = item;
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
    for ( MoveCell *cell in visuableCell ) {
        NSIndexPath *path = [tableView indexPathForCell:cell];
        MoveItem *movItem = [array objectAtIndex:path.row];
        [cell.moveImage setImageWithURL:[NSURL URLWithString:movItem.imageUrl]];
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
    static NSString *cellName=@"Cell";
    MoveCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        NSLog(@"llllll");
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MoveCell" owner:self options:nil] lastObject];
    }
    NSLog(@"cell...%@",cell);
    MoveItem *item=[array objectAtIndex:indexPath.row];
    
    cell.moveName.text = item.name;
    
    NSLog(@"item %@",item);
    cell.moveCast.text= item.cast;

    cell.moveLanguage.text=item.language;
    cell.moveYear.text = item.year;
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
