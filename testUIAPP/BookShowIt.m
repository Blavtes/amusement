//
//  BookShowIt.m
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookShowIt.h"
#import "UIImageView+WebCache.h"
#import "BookItem.h"
#import "HttpItemParser.h"
#import "BookShow.h"
@implementation BookShowIt

@synthesize myTable;

@synthesize book;
@synthesize bookItem;
@synthesize webURL = _webURL;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    JSon_Xml = XML_;
    if (JSON_ == JSon_Xml) {
        mHttpParse = [[HttpItemParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_JSON];
    }else{
        mHttpParse = [[HttpItemParser alloc] initWithType:DOWNLOAD_NORMAL parseType:PARSE_XML];
    } 
    array=[[NSMutableArray alloc] initWithCapacity:0];
    sumar = [[NSString alloc] init];
    arr = [[NSMutableArray alloc] initWithCapacity:0];
    mHttpParse.delegate = self;
    [mHttpParse parseFromUrl:bookItem.mid];
    
    self.navigationController.hidesBottomBarWhenPushed = NO;
//    self.tabbar.nibFileName = @"BottomTabBar";
 
    isLoading = YES;
    [myTable reloadData];
//    bookcontroller.delegaet = self;
    // Do any additional setup after loading the view from its nib.
}
- (void) parseCompleteID:(HttpItemParser *)download
{
    NSLog(@"刷新界面1");
    
    [array removeAllObjects];
    //接收解析结果
    [array addObjectsFromArray:download.nArray];
    NSLog(@"arr ....%@  ...%@",array,download.nArray);
    //刷新界面
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:0];
   self.book = [array lastObject];
    
    NSString *st = [NSString stringWithFormat:@"本书简介:%@", self.book.summary];
    NSLog(@"str %@  ...%d..%@..",self.book.summary,st.length,self.book.price);
    
    NSMutableArray *sumArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0 ; i < [st length];i++) {
        
        [str appendString:[[st substringFromIndex:i] substringToIndex:1]];
         CGSize po = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320,2000)];
//        if ([str length] == 15) {
           if (po.height >= 2000) {

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
    
    
    strings = [NSString stringWithFormat:@"%@", book.summary];
    NSLog(@"string ...%@,...%@",strings,book.summary);
    [myTable reloadData];    
    isLoading = NO;
}
- (UIView*) bubbleView:(NSString*)msg
{
    CGFloat maxWidth = 295;
//    CGFloat width = 0.0f;
//    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
      UIFont *font = [UIFont systemFontOfSize:16.0f];
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
//    return [arr count]+3;
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    return 1;
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.book.authorInfo == nil) {
        if (section == 1) {
            return @"简介:";
        }
    }else if (section == 1) {
        return @"关于作者:";
    }if (section == 2) {
        return @"本书简介:";
    }
    
    return [NSString stringWithFormat:@"书名：<%@>", book.title];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 205;
    }
    if (self.book.authorInfo == nil) {
        UIView *sumView = [self bubbleView:strings];
        NSLog(@"height...%f...sting..%@",sumView.frame.size.height,strings);
        
        return sumView.frame.size.height+10;
    }else if(indexPath.section == 1){
        UIView *b = [self bubbleView:self.book.authorInfo];
        return b.frame.size.height+10;
    }else{
        UIView *sumView = [self bubbleView:strings];
        NSLog(@"height...%f...sting..%@",sumView.frame.size.height,strings);
        
        return sumView.frame.size.height+10;
    }
    
    return 100;

}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.book.authorInfo == nil) {
        return 2;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"show.....");
    static NSString *cellName= @"cell";
    NSLog(@"arr .......%@...book...%@,..author..%d",arr,self->book.price,[self.book.author count]);
    if (indexPath.section == 0) {
    
        if (indexPath.row == 0) {
            BookShow *cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"BookShow" owner:self options:nil] lastObject];
    //         self.bookItem-->book
            cell1.title.text = [NSString stringWithFormat:@"书名:%@", book.title];
            
            isLoading = YES;
            NSMutableString *authors = [[NSMutableString alloc] initWithCapacity:0];
            for (NSString *str in self.bookItem.author) {
                [authors appendString:@"["];
                [authors appendString:str];
                [authors appendString:@"]"];
            }
            
            
            
            cell1.author.text = [NSString stringWithFormat:@"作者:%@",self.book.authors];
            cell1.price.text = [NSString stringWithFormat:@"价格:%@",self.book.price];
            
            [cell1.image setImageWithURL:[NSURL URLWithString:self.bookItem.imageurl]];
            cell1.pubDate.text = [NSString stringWithFormat:@"出版日期:%@",self.book.pubdate];
            NSString *url = [NSString stringWithFormat:@"%@",self.bookItem.mid];
            NSLog(@"url..id ...%@",url);
            
            
            cell1.publisher.text = [NSString stringWithFormat:@"出版社:%@",self.book.publisher];
            cell1.selectionStyle = UITableViewCellSelectionStyleBlue;
            
            
            return cell1;
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            
            
            cell=[tableView dequeueReusableCellWithIdentifier:cellName];
//            if (cell==nil) {
                NSLog(@"cell.....table..");
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            }
            UIView *sumView = [self bubbleView:self.book.authorInfo];
            cell.frame = sumView.frame;
            NSLog(@"sumview....%@....sting..%@",sumView.frame,strings);
            [cell.contentView addSubview:sumView];
        }
        
    }
    else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            
        
        cell=[tableView dequeueReusableCellWithIdentifier:cellName];
//        if (cell==nil) {
            NSLog(@"cell.....table..");
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
//        if ([arr count]==0) {
//            NSLog(@"oooo");
//            return cell;
//        }
        
        NSLog(@"sf...%@..sum.. ..sum...%@ ..%d,count %d....%@",cell,sumar,sumar.length,arr.count,strings);
        UIView *sumView = [self bubbleView:strings];
        cell.frame = sumView.frame;
        NSLog(@"sumview....%@....sting..%@",sumView.frame,strings);
        [cell.contentView addSubview:sumView];

        
        
        
        
//        cell.textLabel.text = [NSString stringWithFormat:@"%@",[arr objectAtIndex:indexPath.row-1]];
//        
//        cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap; 
    }
    }
#if 0
    UIView *v = [[[UIView alloc] init] autorelease];
    if (indexPath.row %2 == 1) {
        [v setBackgroundColor:[UIColor grayColor]];
    }else{
        [v setBackgroundColor:[UIColor lightGrayColor]];
    }
    cell.backgroundView = v;
#endif
    return cell;
}

- (void)viewDidUnload
{
    [self setTitle:nil];

//    [self setSummary:nil];


    [self setWebURL:nil];

    
    [self setMyTable:nil];
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


    [_webURL release];
    [lableText release];
    [array release];
    [sumar release];
    [bookItem release];
    [book release];
    [cell release];
    [mHttpParse release];
    [arr release];
    [myTable release];
    [super dealloc];
}
//- (IBAction)goHome:(id)sender {
//  
////    [self dismissModalViewControllerAnimated:YES];
//    
//    [self.navigationController dismissModalViewControllerAnimated:YES];
////    self.navigationController.hidesBottomBarWhenPushed = NO;
//
////    [self.navigationController popViewControllerAnimated:YES];
//}
@end
