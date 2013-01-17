//
//  PromotionController.m
//  testUIAPP
//
///  Created by Yong on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PromotionController.h"
#import "TenHttpParse.h"
#import "TenItem.h"
#import "NewsWebController.h"
@implementation PromotionController

@synthesize myTableView;
@synthesize itemArray;
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
- (void) viewWillAppear:(BOOL)animated
{
    if (downArray == nil && isLoading == NO) {
        mHttpParse=[[TenHttpParse alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
        mHttpParse.delegate = self;

//        NSString *url = [NSString stringWithFormat:@"%@",@"http://feed.10juhua.com/"];
           NSString *url = [NSString stringWithFormat:@"%@",@"http://feeds.qzone.qq.com/cgi-bin/cgi_rss_out?uin=2202409997"];
        //tenwords
        [mHttpParse parseFromUrl:url];
        isLoading = YES;

    }
    
    [myTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    if (downArray == nil) {
//        mHttpParse=[[TenHttpParse alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
//        mHttpParse.delegate = self;
//        
//        NSString *url = [NSString stringWithFormat:@"%@",@"http://feed.10juhua.com/"];
//        
//        [mHttpParse parseFromUrl:url];
//        isLoading = YES;
//        
//    }
	[myTableView reloadData];
//  
//    mHttpParse=[[TenHttpParse alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
//    mHttpParse.delegate = self;
//
//    NSString *url = [NSString stringWithFormat:@"%@",@"http://feed.10juhua.com/"];
//    
//    [mHttpParse parseFromUrl:url];
//    isLoading = YES;
    NSLog(@"loding...333....");


}
- (void) commentItemWithDownload:(NSArray*)array
{
    if (itemArray != nil) {
        [itemArray removeAllObjects];
    }
    
    itemArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [[array objectAtIndex:0] count]; i++) {
        TenItem *item = [[TenItem alloc] init];
        item.descriptions = [[array objectAtIndex:0] objectAtIndex:i];
        item.link = [[array objectAtIndex:1] objectAtIndex:i];
        item.pubDate = [[array objectAtIndex:2] objectAtIndex:i];
        [self.itemArray addObject:item];
        [item release];
        
    }
    for (TenItem *it in itemArray) {
        NSLog(@"..tlt..%@,pu...%@,.....%@",it.descriptions,it.pubDate,it.link);
    }
    NSLog(@"itemArray ...%@...%d",[itemArray objectAtIndex:0],[itemArray count]);
}
- (void) parseComplete:(TenHttpParse *)download
{
    NSLog(@"刷新界面...111..");
    if (downArray != nil) {
         [downArray removeAllObjects];
    }
   
    NSLog(@"down..%d",download.mArray.count);
    //接收解析结果
    downArray = [NSMutableArray arrayWithArray:download.mArray];
    NSLog(@"%@....couunt %d",downArray,[downArray count]);
    [self commentItemWithDownload:downArray];

    //刷新界面
    [myTableView reloadData];
    isLoading = NO;
}

- (UIView*) bubbleViewWithTitle:(NSString*)msg andPubDate:(NSString*)pub
{
    CGFloat maxWidth = 275;
    //    CGFloat width = 0.0f;
    NSLog(@"msg....%@",msg);
    //    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = [msg sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, 3000.0f) lineBreakMode:UILineBreakModeMiddleTruncation];
    
    UIFont *font1 = [UIFont systemFontOfSize:12.0f];
    CGSize sizeP = [pub sizeWithFont:font1 constrainedToSize:CGSizeMake(maxWidth, 3000.0f) lineBreakMode:UILineBreakModeMiddleTruncation];
    
    UIView *bubbleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height+sizeP.height+20)];
//    bubbleView.clipsToBounds = YES;
    bubbleView.backgroundColor = [UIColor clearColor];
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:bubbleView.frame];
    imagView.image = [UIImage imageNamed:@"tenback.png"];
    imagView.frame = CGRectMake(-25, -20, bubbleView.frame.size.width+120, bubbleView.frame.size.height+50);
    imagView.clipsToBounds = YES;
    imagView.alpha = 0.7;
    [bubbleView addSubview:imagView];
    [imagView release];
    NSLog(@"size....%f..%f",size.width,size.height);
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, size.width, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = UILineBreakModeWordWrap;
    bubbleText.text = msg;
    
    [bubbleView addSubview:bubbleText];
    [bubbleText release];
    
    
    UILabel *pubLabel = [[UILabel alloc] initWithFrame:CGRectMake(123, size.height+25, sizeP.width, sizeP.height)];
    pubLabel.backgroundColor = [UIColor clearColor];
    pubLabel.font = font1;
    pubLabel.numberOfLines = 0;
    pubLabel.lineBreakMode = UILineBreakModeWordWrap;
    pubLabel.text = pub;
    [bubbleView addSubview:pubLabel];
    NSLog(@"size..frame..%f..%f",bubbleView.frame.size.width,bubbleView.frame.size.height);
    [pubLabel release];
    return [bubbleView autorelease];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //.
    NSLog(@"itm count ...%d",[itemArray count]);
    return [self.itemArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@".....");
//    return 50;
    
    TenItem *item = [self.itemArray objectAtIndex:indexPath.row];
    NSString *msg = [NSString stringWithFormat:@"%@",item.descriptions];
    NSString *pub = [NSString stringWithFormat:@"%@",item.pubDate];
    UIView *sumView = [self bubbleViewWithTitle:msg andPubDate:pub];
    
    NSLog(@"henghti...%f....%@",sumView.frame.size.height,item.descriptions);
    return sumView.frame.size.height +20;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"...________..");
    
   
    static NSString *cellNameM = @"CellNameON";
    NSLog(@"..._____1___..");

    cell = [tableView dequeueReusableCellWithIdentifier:cellNameM];
    NSLog(@"...__2______..");

     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNameM];
    NSLog(@"...__3______..");

//    if ([self.itemArray count] == 0) {
//
//        return cell;
//    }
    NSLog(@"...____4____..");

     NSLog(@"...%d..3.3.3.3.",self.itemArray.count);
    TenItem *item = [itemArray objectAtIndex:indexPath.row];
    NSLog(@"...des ..%@....pub..%@",item.descriptions,item.pubDate);
       
        NSLog(@"..000...");
//        NSLog(@"..113231...%@",((TenItem*)[itemArray objectAtIndex:indexPath.row]).descriptions);
    
    NSString *msg = [NSString stringWithFormat:@"%@",item.descriptions];
    NSString *pub = [NSString stringWithFormat:@"%@",item.pubDate];
    UIView *sumView = [self bubbleViewWithTitle:msg andPubDate:pub];
    cell.frame = sumView.frame;
    NSLog(@"..222...");
    [cell.contentView addSubview:sumView];
//    cell.textLabel.text = item.descriptions;
    
    NSLog(@"..3331...");
    return cell;
}
//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  
//}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    TenItem *item = [itemArray objectAtIndex:indexPath.row];
    
    NewsWebController *newsWeb = [[[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil] autorelease];
    
    [newsWeb setWebURL:item.link];
    
    self.view = newsWeb.view;
    [self.navigationController presentModalViewController:newsWeb animated:YES];

    
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

- (void)dealloc {
    [myTableView release];
    [super dealloc];
}
@end
