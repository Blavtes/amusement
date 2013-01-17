//
//  NewsViewController.m
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "NewsItem.h"
#import "BookCell.h"
#import "NewsWebController.h"
#import "NewsViewItem.h"
#import <mach/mach_time.h>
@interface NewsViewController() <NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableArray *nwsTitle;
@property (nonatomic,strong) NSMutableArray *nwsLink;
@property (nonatomic,strong) NSMutableArray *nwsPubdate;
@property (nonatomic,strong) NSMutableArray *nwAuthor;
@property (nonatomic,strong) NSMutableString *tempString;

- (void) loadMore;

#define NWSTITLE @"nwsTitle"
#define NWSLINK @"nwsLink"
#define NWSPUBDATE @"nwsPubdate"
#define NWAUTHOR @"nwAuthor"
#define TEMPSTRING @"tempString"
@end
@implementation NewsViewController

@synthesize nwsTitle = _nwsTitle;
@synthesize nwsLink = _nwsLink;
@synthesize nwsPubdate = _nwsPubdate;
@synthesize tempString = _tempString;
@synthesize nwAuthor = _nwAuthor;
@synthesize myTableView;


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


- (void) loadMore
{
    if (isLoading) {
        return;
    }
    isLoading = YES;
    self.nwsLink = nil;
    self.nwsPubdate = nil;
    self.nwsTitle = nil;
    self.nwAuthor = nil;
    //同步队列 下载
    
    dispatch_async(quene, ^(void){
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        sleep(0.1f);
        [self lodingData];
        [self performSelectorOnMainThread:@selector(finishLoding:) withObject:nil waitUntilDone:NO];
        [pool release];
        isLoading = NO;
    });
}
- (void) finishLoding:(id)arg
{
    [myTableView reloadData]; 
}
//检测 是否 滑动倒了最后一行
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoading) {
        return;
    }
    float contentHeight = scrollView.contentSize.height;
    float contentY = scrollView.contentOffset.y;
    float visibleHeight = scrollView.bounds.size.height;
    if (contentY + visibleHeight > contentHeight +100.0f) {
        [self loadMore];
    }
}
//获取方法的 响应时间
CGFloat BNRTimeBlock (void (^block)(void)) {  
    mach_timebase_info_data_t info;  
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;  
    
    uint64_t start = mach_absolute_time ();  
    block ();  
    uint64_t end = mach_absolute_time ();  
    uint64_t elapsed = end - start;  
    
    uint64_t nanos = elapsed * info.numer / info.denom;  
    return (CGFloat)nanos / NSEC_PER_SEC;  
    
}
- (void) lodingData
{
    CGFloat time;
    time = BNRTimeBlock(^{
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://rss.sina.com.cn/news/marquee/ddt.xml"]];
        self.tempString = nil;
        [xmlParser setDelegate:self];
        [xmlParser parse];
    });
    if (time>3.0f) {
        [myTableView reloadData];
    }
    
    if (self.nwsTitle == nil) {
        NSLog(@"nwstitl...nomal...");
        self.nwsTitle = [[NSUserDefaults standardUserDefaults] objectForKey:NWSTITLE];
        self.nwsPubdate = [[NSUserDefaults standardUserDefaults] objectForKey:NWSPUBDATE];
        self.nwsLink = [[NSUserDefaults standardUserDefaults] objectForKey:NWSLINK];
        self.nwAuthor = [[NSUserDefaults standardUserDefaults] objectForKey:NWAUTHOR];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self lodingData];
    
  
     [myTableView reloadData];
    //  update the last update date
    quene = dispatch_queue_create("myQueue", NULL);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma NSXMLParserDelegate
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"title"]) {
        if (self.nwsTitle == nil) {
            self.nwsTitle = [NSMutableArray array];
        }
    }else if([elementName isEqualToString:@"link"])
    {
        if (self.nwsLink == nil) {
            self.nwsLink = [NSMutableArray array];
        }
    }else if([elementName isEqualToString:@"pubDate"]){
        if (self.nwsPubdate == nil) {
            self.nwsPubdate = [NSMutableArray array];
        }
    }else if([elementName isEqualToString:@"author"]){
        if (self.nwAuthor == nil) {
            self.nwAuthor = [NSMutableArray array];
        }
    }
}
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.tempString == nil) {
        self.tempString = [[[NSMutableString alloc] init] autorelease];
    }
    [self.tempString appendString:string];
}
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]) {
        [self.nwsTitle addObject:self.tempString];
    }else if([elementName isEqualToString:@"link"]){
        [self.nwsLink addObject:self.tempString];
    }else if([elementName isEqualToString:@"pubDate"]){
        [self.nwsPubdate addObject:self.tempString];
    }else if([elementName isEqualToString:@"author"]){
        [self.nwAuthor addObject:self.tempString];
    }
    NSLog(@"temstring %@",self.tempString);
    if (self.nwsTitle != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:self.nwsTitle forKey:NWSTITLE];
        [[NSUserDefaults standardUserDefaults] setObject:self.nwsPubdate forKey:NWSPUBDATE];
        [[NSUserDefaults standardUserDefaults] setObject:self.nwAuthor forKey:NWAUTHOR];
        [[NSUserDefaults standardUserDefaults] setObject:self.nwsLink forKey:NWSLINK];

    }
 
    self.tempString = nil;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSLog(@"tableView.....");
//    return [self.newsTitle count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"nwstitl..count %d,lik.count %d,",[self.nwsTitle count],[self.nwsLink count]);
    for (int i = 0; i < [self.nwsTitle count]; i++) {
        NSLog(@"count %d..%@",i,[self.nwsTitle objectAtIndex:i]);
    }
    NSLog(@"newTitle count %d",[self.nwsTitle count]);
    return ([self.nwsTitle count]-2 +1 );
    //.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.nwsTitle count]-2) {
        return 44.0f;
    }
    return 60.0f;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"celll");
    static NSString *cellName = @"cellName";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    //.
    if (indexPath.row == [self.nwsTitle count]-2 ) {
        cellName = @"LoadingMoreCell";
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LoadingMoreCell" owner:self options:nil] lastObject];
            return cell;
        }
    }
//    NSLog(@"cell name %@   %@",cellName,cell);
    if (cell == nil) {
       cell=[[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
//         NSLog(@"cell naeme %@   %@",cellName,cell);

    }
    NSString *title = [self.nwsTitle objectAtIndex:indexPath.row+2];
//     NSLog(@"title  %@",title);
  NSArray *array = [NSArray arrayWithArray:[title componentsSeparatedByString:@"\n"]];
//    NSLog(@"array  %@  ...%@",array,[array lastObject]);
    for (NSString *str in array) {
        NSArray *array1 = [NSArray arrayWithArray:[str componentsSeparatedByString:@"\t"]];
        NSLog(@"array1 %@ ....last...%@",array1,[array1 lastObject]);
        if ([[array1 objectAtIndex:([array1 count]-1)] isEqualToString:@""] == NO ) {
            
            cell.newsTtile.text = [array1 objectAtIndex:([array1 count]-1)];
             NSLog(@"title  %@",[array1 objectAtIndex:([array1 count]-1)]);
        }
    }
    NSString *pubDate = [self.nwsPubdate objectAtIndex:indexPath.row+1];
    cell.newsDate.text = pubDate;
    UIView *v = [[[UIView alloc] init] autorelease];
    if (indexPath.row %2 == 0) {
        [v setBackgroundColor:[UIColor grayColor]];
    }else{
        [v setBackgroundColor:[UIColor lightGrayColor]];
    }
    cell.backgroundView = v;

    return cell;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    if (indexPath.row %2 == 0) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }else{
        cell.backgroundColor = [UIColor grayColor];
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLoading) {
        return;
    }
    NSLog(@"didselect %d,self.%d",indexPath.row,[self.nwsTitle count]-2);
    if (indexPath.row - [self.nwsTitle count]+2 == 0) {
        NSLog(@"didselect %d",indexPath.row);
       
        [self loadMore];
        [myTableView reloadData];
        return;
    }
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:[self.nwsLink objectAtIndex:self.myTableView.indexPathForSelectedRow.row+2]];
    [str deleteCharactersInRange:NSMakeRange(0, 4)];
    NewsWebController *newsWeb = [[[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil] autorelease];
   
#if 0   
    NSLog(@"Url %@",str);
    NewsViewItem *news = [[NewsViewItem alloc] initWithNibName:@"NewsViewItem" bundle:nil];
    NSString *title = [self.newsTitle objectAtIndex:indexPath.row+2];
      NSLog(@"title  %@",title);
    NSArray *array = [NSArray arrayWithArray:[title componentsSeparatedByString:@"\n"]];
      NSLog(@"array  %@  ...%@",array,[array lastObject]);
    for (NSString *str in array) {
        NSArray *array1 = [NSArray arrayWithArray:[str componentsSeparatedByString:@"\t"]];
        NSLog(@"array1 %@ ....last...%@",array1,[array1 lastObject]);
        if ([[array1 objectAtIndex:([array1 count]-1)] isEqualToString:@""] == NO ) {
           news.newTitle.text =  [array1 objectAtIndex:([array1 count]-1)];
        }
    }
    NSString *pubDate = [self.newsPubdate objectAtIndex:indexPath.row+1];
    news.date.text = pubDate;
    
    NSString *pubAuthor = [self.newAuthor objectAtIndex:indexPath.row+1];
    news.author.text = pubAuthor;
    [news setUrl:str];
#endif
    
    [newsWeb setWebURL:str];
    [str release];
    self.view = newsWeb.view;
    [self.navigationController presentModalViewController:newsWeb animated:YES];
//    [self presentModalViewController:newsWeb animated:YES];
}

- (void)dealloc {
    [myTableView release];
    [_nwAuthor release];
    [_nwsLink release];
   
    [_nwsPubdate release];
    [_nwsTitle release];

    [super dealloc];
}
@end
