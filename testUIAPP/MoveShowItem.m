//
//  MoveShowItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoveShowItem.h"
#import "MoveItem.h"
#import "MoveItemParser.h"
#import "UIImageView+WebCache.h"
#import "MovieShow.h"
#import "NewsWebController.h"
#import "NSString+URLEncoding.h"
@implementation MoveShowItem

@synthesize myTable;
@synthesize moveItem;
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
        mHttpParse = [[MoveItemParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[MoveItemParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    } 
    array = [[NSMutableArray alloc] initWithCapacity:0];
    sumar = [[NSString alloc] init];
    arr = [[NSMutableArray alloc] initWithCapacity:0];
    //    mHttpParse=[[HttpParser alloc] initWithType:DOWNLOAD_NORMAL     parseType:PARSE_XML];
    mHttpParse.delegate = self;
    [mHttpParse parseFromUrl:moveItem.mid];
    isLoading = YES;
    
    [myTable reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (void) parseComplete:(MoveItemParser *)download
{
    NSLog(@"刷新界面1");
    
    [array removeAllObjects];
    //接收解析结果
    [array addObjectsFromArray:download.nArray];
    NSLog(@"arr ....%@  ...%@",array,download.nArray);
    //刷新界面
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:0];
    mov = [array lastObject];
        NSString *st = [NSString stringWithFormat:@"影片简介:%@",mov.summary];
        NSLog(@"str %@  ...%d..",mov.summary,st.length);

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
    strings = [NSString stringWithFormat:@"%@", mov.summary];
    
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
        return 300;
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
        NSLog(@"is image....%@.",moveItem.name);
        NewsWebController *nw = [[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil];
        
//        NSString *names = [moveItem.name urlEncodeString];
        NSString *url = [NSString stringWithFormat:@"http://m.letv.com/"];
        [nw setWebURL:url];
        self.view = nw.view;
        [self.navigationController presentModalViewController:nw animated:YES];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    NSLog(@"touch ended...");
    if ([view isKindOfClass:[UIButton class]]) {
        NSLog(@"is image..323.");
        NewsWebController *nw = [[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil];
        
//        NSString *names = [moveItem.name urlEncodeString];
        NSString *url = [NSString stringWithFormat:@"http://m.letv.com/"];
        [nw setWebURL:url];
        self.view = nw.view;
        [self.navigationController presentModalViewController:nw animated:YES];
    }
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (section == 1) {
        return @"简介:";
    }
   
    return [NSString stringWithFormat:@"影片名:<%@>", moveItem.name];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"show.....");
    static NSString *cellName= @"cell";
    NSLog(@"arr .......%@",arr);
//    cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MovieShow *cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
    //        if (cell1 == nil) {
                NSLog(@"moveisehow");
                cell1 = [[[NSBundle mainBundle] loadNibNamed:@"MovieShow" owner:self options:nil] lastObject];
                cell1.name.text = [NSString stringWithFormat:@"名字:%@", moveItem.name];
//            cell1.titles = moveItem.name;
                NSLog(@"cell %@ ....cell.name %@....Move >.%@.",cell1,cell1.name.text,moveItem.name);
                [cell1.image setImageWithURL:[NSURL URLWithString:moveItem.imageUrl]];
            cell1.image.userInteractionEnabled = YES;
                
            if (mov.language != nil) {
                cell1.language.text = [NSString stringWithFormat:@"语言:%@",moveItem.language];
            }else{
                cell1.language.text = @"语言:未知";
            }
            if (mov.year != nil) {
                cell1.year.text = [NSString stringWithFormat:@"年代:%@",moveItem.year];
            }else{
                cell1.year.text = @"年代:未知";
            }
            if (mov.cast != nil) {
                cell1.cast.text = [NSString stringWithFormat:@"主演:%@",moveItem.cast];
            }else{
                cell1.cast.text = @"主演:未知";
            }
            if (mov.director != nil) {
                cell1.director.text = [NSString stringWithFormat:@"导演:%@",moveItem.director];
            }else{
                cell1.director.text = @"导演:未知";
            }
                
            if (mov.duration != nil) {
                cell1.duration.text = [NSString stringWithFormat:@"片长:%@",mov.duration];
            }else{
                cell1.duration.text = @"片长:未知";
            }
            cell1.types.text= [NSString stringWithFormat:@"类型:%@",mov.types];
            
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
            cell=[tableView dequeueReusableCellWithIdentifier:cellName];
          
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
    [moveItem release];
    [mov release];
    [array release];
    [mHttpParse release];
    [sumar release];
    [moveshow release];
    [myTable release];
    [super dealloc];
}
@end
