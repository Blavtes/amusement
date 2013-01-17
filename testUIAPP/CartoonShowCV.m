//
//  CartoonShowCV.m
//  testUIAPP
//
//  Created by Yong on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CartoonShowCV.h"
#import "CartoonCell.h"
#import "UIImageView+WebCache.h"
@implementation CartoonShowCV
@synthesize imagUrlArray;
@synthesize myTabelView;
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
    // Do any additional setup after loading the view from its nib.
    [myTabelView reloadData];
}

- (void)viewDidUnload
{
    [myTabelView release];
    myTabelView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"imgaur..Count %d ",imagUrlArray.count);
    if ([imagUrlArray count] >= 8) {
         return [imagUrlArray count] - 3;
    }
    return [imagUrlArray count];
//    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500.0f;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"imgaur.s.Count %d ",imagUrlArray.count);
    static NSString *cellName = @"cellNameIndefier";
    CartoonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName]; 
    cell.scrollView.delegate = self;
    cell.scrollView.minimumZoomScale = 0.5;
    cell.scrollView.maximumZoomScale = 3.0f;
    cell = [[[NSBundle mainBundle] loadNibNamed:@"CartoonCell" owner:self options:nil] lastObject];
//    cell = [[CartoonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    NSLog(@"imag..url....%@",[imagUrlArray objectAtIndex:indexPath.row]);
    [cell.imageShow setImageWithURL:[imagUrlArray objectAtIndex:indexPath.row]];
//    cell.imageView.image = [UIImage imageNamed:@"1222.jpeg"];
    return cell;
}
- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollViews
{
    NSLog(@"scrollView delegate....");
    for (id subView  in scrollViews.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            return subView;
        }
    }
    return nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        self.view.frame = CGRectMake(0, 0, 320, 343);
//        
//    }else{
//        self.view.frame = CGRectMake(0, 0, 480, 800);
//        self.myTabelView.frame = CGRectMake(0, 0, 480, 800);
//    }
    return YES;
}

- (void)dealloc {
    [imagUrlArray release];
    [myTabelView release];
    [super dealloc];
}
@end
