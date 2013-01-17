//
//  SignShowItem.m
//  testUIAPP
//
//  Created by Yong on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignShowItem.h"
#import "SignItemCell.h"
@implementation SignShowItem
@synthesize myTableView;
@synthesize item;

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
    [myTableView reloadData];

    
    // Do any additional setup after loading the view from its nib.
}
- (UIView*) bubbleView:(NSString*)msg
{
    CGFloat maxWidth = 310;
    //    CGFloat width = 0.0f;
    //    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    UIFont *font = [UIFont fontWithName:@"Arial" size:16];
    CGSize size = [msg sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, 3000.0f) lineBreakMode:UILineBreakModeMiddleTruncation];
    UIView *bubbleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];    
    bubbleView.backgroundColor = [UIColor clearColor];
    NSLog(@"size....%f..%f",size.width,size.height);
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, size.width, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = UILineBreakModeWordWrap;
    bubbleText.text = msg;
    [bubbleView addSubview:bubbleText];
    //    [bubbleText release];
    return [bubbleView autorelease];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 74;
    }
    if (indexPath.section == 1) {
       return [self bubbleView:item.descriptions].frame.size.height+10;
    }
    return 100;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"内容";
    }
    return @"";
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellItemShow";
    if (indexPath.section == 0) {
        SignItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SignItemCell" owner:self options:nil] lastObject];
        if (item.title != nil) {
             cell.titleLabel.text = item.title;
        }
        if (item.author != nil) {
            cell.authorLabel.text = item.author;
        }
        if (item.pubDate != nil) {
            cell.pubDateLabel.text = item.pubDate;
        }
        if (item.link != nil) {
            cell.linkLabel.text = item.link;
        }
        if (item.category != nil) {
        cell.categoryLabel.text = item.category;
        }
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        UIView *v = [self bubbleView:item.descriptions];
        cell.frame = v.frame;
        [cell.contentView addSubview:v];
        return cell;
    }
    return nil;
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
