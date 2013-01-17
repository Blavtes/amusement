//
//  NewsViewItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewItem.h"

@interface NewsViewItem() <NSXMLParserDelegate>


@property (nonatomic,strong) NSMutableString *tempString;
@property (nonatomic,strong) NSMutableArray *nwArray;
@end

@implementation NewsViewItem
@synthesize nwTitle;
@synthesize author;
@synthesize date;
@synthesize myTableView;

@synthesize tempString = _tempString;
@synthesize nwArray = _nwArray;
@synthesize url;
@synthesize content;

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
    NSXMLParser *xmlParse = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    self.tempString = nil;
    [xmlParse setDelegate:self];
    [xmlParse parse];
    [myTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"div class=\"blkContainerSblk\""]) {
        if (self.nwArray == nil) {
            self.nwArray = [NSMutableArray array];
        }
    }
}
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.tempString == Nil) {
        self.tempString = [[[NSMutableString alloc] init] autorelease];
    }
    [self.tempString appendString:string];
}
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if([elementName isEqualToString:@"p"]){
        [self.content appendString:self.tempString];
    }
    NSLog(@"tem context %@",self.tempString);
    self.tempString = Nil;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] init] autorelease];
        
    }
    cell.detailTextLabel.text = self.content;
    return cell;
}
- (void)viewDidUnload
{
    [self setNwTitle:nil];
    [self setAuthor:nil];
    [self setDate:nil];
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
    [nwTitle release];
    [author release];
    [date release];
    [_nwArray release];
    [myTableView release];
    [super dealloc];
}
@end
