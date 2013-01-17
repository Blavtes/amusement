//
//  MuiscShowItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicShowItem.h"

#import "MusicItem.h"
#import "MusicItemParser.h"
#import "UIImageView+WebCache.h"
#import "MusicShow.h"
#import "NewsWebController.h"
#import "NSString+URLEncoding.h"
@implementation MusicShowItem

@synthesize myTable;
@synthesize musicItem;
@synthesize sumar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.myTable.userInteractionEnabled = YES;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    JSon_Xml = XML_;
    if (JSON_ == JSon_Xml) {
        mHttpParse = [[MusicItemParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[MusicItemParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    } 
    array = [[NSMutableArray alloc] initWithCapacity:0];
    sumar = [[NSString alloc] init];
    arr = [[NSMutableArray alloc] initWithCapacity:0];
    //    mHttpParse=[[HttpParser alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
    mHttpParse.delegate = self;
    [mHttpParse parseFromUrl:musicItem.mid];
    isLoading = YES;
    
    [myTable reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (void) musicParseComplete:(MusicItemParser *)download
{
    NSLog(@"刷新界面1");
    
    [array removeAllObjects];
    //接收解析结果
    [array addObjectsFromArray:download.nArray];
    NSLog(@"arr ....%@  ...%@",array,download.nArray);
    //刷新界面
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:0];
    mus = [array lastObject];
    NSString *st = [NSString stringWithFormat:@"影片简介:%@",mus.summary];
    NSLog(@"str %@  ...%d..",mus.summary,st.length);
    
    NSMutableArray *sumArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0 ; i < [st length];i++) {
        
        [str appendString:[[st substringFromIndex:i] substringToIndex:1]];
        if ([str length] == 15) {
            [sumArray addObject:[str copy]];
            NSLog(@"arr str %@  ...%@",str,sumArray);
            [str setString:@""];
        }
        if (i == [st length]-1) {
            [sumArray addObject:str];
            NSLog(@"arr1 str %@",str);
        }
    }
    
    arr = [[NSMutableArray alloc] initWithArray:sumArray];
    strings = [NSString stringWithFormat:@"%@", mus.summary];
    
    [myTable reloadData];    
    isLoading = NO;
}
- (UIView*) bubbleView:(NSString*)msg
{
    CGFloat maxWidth = 295;
    //    CGFloat width = 0.0f;
    //    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    UIFont *font = [UIFont fontWithName:@"Arial" size:16];
    CGSize size = [msg sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, 3000.0f) lineBreakMode:UILineBreakModeMiddleTruncation];
    UIView *bubbleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];    
    bubbleView.backgroundColor = [UIColor clearColor];
    NSLog(@"size....%f..%f",size.width,size.height);
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, size.width, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = UILineBreakModeWordWrap;
    bubbleText.text = msg;
    [bubbleView addSubview:bubbleText];
    //    [bubbleText release];
    return [bubbleView autorelease];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"arr cou %d",[arr count]);
    //    return [arr count]+1;
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 205;
    }
    //    return 25.0f;
    
    UIView *sumView = [self bubbleView:strings];
    NSLog(@"height...%f...sting..%@",sumView.frame.size.height,strings);
    
    return sumView.frame.size.height+10;
    
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"is image..%@.",musicItem.titles);
        NSString *names = [musicItem.titles urlEncodeString];
        NSString *url = [NSString stringWithFormat:@"http://m.kugou.com"];
//        NSString *url = [NSString stringWithFormat:@"http://www.kugou.com/webkugouplayer/?isopen=1&chl=yueku_musicrank"];http://mp3.sogou.com/music.so?query=%@
        NSLog(@"..%@。。。。%@",musicItem.titles,names);
        NewsWebController *nw = [[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil];
        
        
        [nw setWebURL:url];
        self.view = nw.view;
        self.view.frame = nw.view.frame;
        [self.navigationController presentModalViewController:nw animated:YES];
    }
}

//- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    UIView *view = [touch view];
//    NSLog(@"touch ended...");
//    if ([view isKindOfClass:[UIButton class]]) {
//        NSLog(@"is image...");
//        NewsWebController *nw = [[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil];
//        
//        NSString *names = [musicItem.titles urlEncodeString];
//        NSLog(@"..%@",names);
//        NSString *url = [NSString stringWithFormat:@"http://cgi.music.soso.com/fcgi-bin/m.q?w=%@&source=1&t=0",names];
//        [nw setWebURL:url];
//        self.view = nw.view;
//        [self.navigationController presentModalViewController:nw animated:YES];
//    }
//}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        return @"简介:";
    }
    
    return [NSString stringWithFormat:@"音乐名:<%@>", musicItem.titles];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"show.....");
    static NSString *cellName = @"cell";
    NSLog(@"arr .......%@",arr);
    //    cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MusicShow *cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
            //        if (cell1 == nil) {
            NSLog(@"moveisehow");
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"MusicShow" owner:self options:nil] lastObject];
            cell1.name.text = [NSString stringWithFormat:@"名字:%@", musicItem.titles];
            //            cell1.titles = moveItem.name;
            NSLog(@"cell %@ ....cell.name %@....Move >.%@.",cell1,cell1.name.text,musicItem.titles);
            [cell1.image setImageWithURL:[NSURL URLWithString:musicItem.imageUrl]];
            cell1.image.userInteractionEnabled = YES;
            cell1.author.text = musicItem.author;
            cell1.rating = [musicItem.rating floatValue];
            cell1.ratingLabel.text =  [NSString stringWithFormat:@"评分:%0.1f 分",[musicItem.rating floatValue]];
            cell1.publisher.text = musicItem.publisher;
            cell1.pubDate.text = musicItem.pubDate;

            //        }
            return cell1;
        }  
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0&&strings != nil) {
            cell=[tableView dequeueReusableCellWithIdentifier:cellName];
            //        if (cell==nil) {
            NSLog(@"cell.....table..");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
            
            
            
            //        }
            UIView *sum = [self bubbleView:strings];
            cell.frame = sum.frame;
            [cell.contentView addSubview:sum];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellName];
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
            cell.textLabel.text = @"无";
        }
    }
#if 0
    UIView *v = [[[UIView alloc] init] autorelease];
    if (rand()%2 == 0) {
        [v setBackgroundColor:[UIColor darkGrayColor]];
    }else{
        [v setBackgroundColor:[UIColor grayColor]];
    }
    cell.backgroundView = v;
#endif
    return cell;
}

- (void)viewDidUnload
{
    
    [self setMyTable:nil];
    [arr removeAllObjects];
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
    
    [cell release];
    [musicItem release];
    [mus release];
    [array release];
    [mHttpParse release];
    [sumar release];
    [musicshow release];
    [myTable release];
    [super dealloc];
}

@end
