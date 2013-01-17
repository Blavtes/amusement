//
//  ChinaNewsTableView.m
//  testUIAPP
//
//  Created by Yong on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChinaNewsTableView.h"
#import "NewsCell.h"
#import "NewsItem.h"
#import "BookCell.h"
#import "NewsWebController.h"
#import "NewsViewItem.h"
@interface ChinaNewsTableView() <NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableArray *nwsTitle;
@property (nonatomic,strong) NSMutableArray *nwsLink;
@property (nonatomic,strong) NSMutableArray *nwsPubdate;
@property (nonatomic,strong) NSMutableArray *nwAuthor;
@property (nonatomic,strong) NSMutableString *tempString;

@end
@implementation ChinaNewsTableView

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://rss.sina.com.cn/news/china/focus15.xml"]];
    self.tempString = nil;
    [xmlParser setDelegate:self];
    [xmlParser parse];
    [myTableView reloadData];
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
    self.tempString = nil;
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSLog(@"tableView.....");
//    return [self.newsTitle count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"newTitle count %d",[self.nwsTitle count]);
    return ([self.nwsTitle count]-2);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"celll");
    static NSString *cellName = @"foreignNewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    //    NSLog(@"cell name %@   %@",cellName,cell);
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] lastObject];
        //         NSLog(@"cell naeme %@   %@",cellName,cell);
        //        
        
    }
    NSString *title = [self.nwsTitle objectAtIndex:indexPath.row+2];
    //     NSLog(@"title  %@",title);
    NSArray *array = [NSArray arrayWithArray:[title componentsSeparatedByString:@"\n"]];
    //    NSLog(@"array  %@  ...%@",array,[array lastObject]);
    for (NSString *str in array) {
        NSArray *array1 = [NSArray arrayWithArray:[str componentsSeparatedByString:@"\t"]];
        NSLog(@"array1 %@ ....last...%@",array1,[array1 lastObject]);
        if ([[array1 objectAtIndex:([array1 count]-1)] isEqualToString:@""] == NO ) {
            
            cell.newsTtile.text =  [NSString stringWithFormat:@"[国内]:%@",[array1 objectAtIndex:([array1 count]-1)]];
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
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    [str appendString:[self.nwsLink objectAtIndex:self.myTableView.indexPathForSelectedRow.row+2]];
    [str deleteCharactersInRange:NSMakeRange(0, 4)];
    NewsWebController *newsWeb = [[[NewsWebController alloc] initWithNibName:@"NewsWebController" bundle:nil] autorelease];
    [newsWeb setWebURL:str];
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
