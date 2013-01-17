//
//  MyRootViewController.m
//  JsonParserDemo
//
//  Created by Yong on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmItemViewController.h"
#import "EmHttpDownload.h"
#import "NewsWebController.h"
//#import "AppRecord.h"
#import "Humorous.h"

static NSString *const TopPaidAppsFeed =
@"http://feed.xiaohuayoumo.com/";

@implementation EmItemViewController

@synthesize array;
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

-(void)startDownload
{
    EmHttpDownload *httpdownload=[[EmHttpDownload alloc] init];
    httpdownload.delegate=self;
    
    
    [httpdownload downloadFromUrl:TopPaidAppsFeed];
    isLoding = YES;
    
}

#pragma mark - View lifecycle
- (void) viewWillAppear:(BOOL)animated
{
    self.array = [[NSUserDefaults standardUserDefaults] objectForKey:@"ARRAY"];
//     [[NSUserDefaults standardUserDefaults] synchronize];
    isLoding = YES;
    if (array.count == 0) {
        [self startDownload];
    }
    [mXibTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (UIView*) bubbleViewWithTitle:(NSString*)title andDes:(NSString*)des
{
    CGFloat maxWidth = 300;
    //    CGFloat width = 0.0f;
    NSLog(@"msg....%@",title);
    //    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize sTitle = [title sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, 3000.0f) lineBreakMode:UILineBreakModeMiddleTruncation];
    
    UIFont *font1 = [UIFont systemFontOfSize:14.0f];
    CGSize sizeD = [des sizeWithFont:font1 constrainedToSize:CGSizeMake(maxWidth, 3000.0f) lineBreakMode:UILineBreakModeMiddleTruncation];
    
    UIView *bubbleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeD.width+20, sTitle.height+sizeD.height+20+50)];
    bubbleView.backgroundColor = [UIColor clearColor];
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:bubbleView.frame];
    bubbleView.clipsToBounds = YES;
    imagView.image = [UIImage imageNamed:@"emback.png"];
    imagView.frame = CGRectMake(3, 10, bubbleView.frame.size.width-5, bubbleView.frame.size.height);
    imagView.clipsToBounds = YES;
    [bubbleView addSubview:imagView];
    [imagView release];
    NSLog(@"size....%f..%f",sTitle.width,sTitle.height);
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 220, sTitle.height)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.textAlignment = UITextAlignmentCenter;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = UILineBreakModeWordWrap;
    bubbleText.text = title;

    [bubbleView addSubview:bubbleText];
    [bubbleText release];
    
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(8, sTitle.height+5, sizeD.width, sizeD.height+50)];
    desc.backgroundColor = [UIColor clearColor];
    desc.font = font1;
    desc.numberOfLines = 0;
    desc.lineBreakMode = UILineBreakModeWordWrap;
    desc.text = des;
    [bubbleView addSubview:desc];
    [desc release];
    NSLog(@"size..frame..%f..%f",bubbleView.frame.size.width,bubbleView.frame.size.height);
    
    return [bubbleView autorelease];
}

#pragma mark - UITableView Delegate Start
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Humorous *item = [self.array objectAtIndex:indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@",item.title];
    NSString *des = [NSString stringWithFormat:@"%@",item.description];
    UIView *sumView = [self bubbleViewWithTitle:title andDes:des];
    
    NSLog(@"henghti...%f....%@",sumView.frame.size.height,item.description);
    return sumView.frame.size.height ;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row%2==0) {
//        cell.backgroundColor=[UIColor yellowColor];
//    }
//    else {
//        cell.backgroundColor=[UIColor whiteColor];
//    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"...________..");
    static NSString* cellName=@"CustomCell";
     NSLog(@"..._____1___..");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    } 
    NSLog(@"..._____2___..");
    
    Humorous* item=[array objectAtIndex:indexPath.row];
     NSLog(@"..._____21___..");
    NSString *title = [NSString stringWithFormat:@"%@",item.title];
    NSString *des = [NSString stringWithFormat:@"%@",item.description];

    UIView *vi = [self bubbleViewWithTitle:title andDes:des];
    cell.frame = vi.frame;
    [cell.contentView addSubview:vi];

     NSLog(@"..._____3___..");
    
    //cell.textLabel.text=appRecode.title;
    
    return [cell autorelease];
}
#pragma mark -DownloadCompleteDelegate
-(void)downloadComplete:(NSArray *)newArray
{
    [self.array removeAllObjects];
    array = [[NSMutableArray alloc] initWithCapacity:0];
    [self.array addObjectsFromArray:newArray];
    
    int i = 0;
    for (Humorous *hun in newArray) {
        NSLog(@"..%d.titl..%@...des...%@....aut..%@...pdu..%@",i++,hun.title,hun.description,hun.author,hun.pubDate);

    }
    [[NSUserDefaults standardUserDefaults] setObject:self.array forKey:@"ARRAY"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [mXibTableView reloadData];
    isLoding = NO;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Humorous *item = [array objectAtIndex:indexPath.row];
    NSLog(@".link..%@",item.link);
    
    NewsWebController *newsWeb = [[[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil] autorelease];
    
    [newsWeb setWebURL:item.link];

    self.view = newsWeb.view;
    [self.navigationController presentModalViewController:newsWeb animated:YES];
}

@end
