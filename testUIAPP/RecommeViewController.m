//
//  RecommeViewController.m
//  testUIAPP
//
//  Created by qianfeng on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecommeViewController.h"
//#import "TabBar.h"
#import "RecommeTabBar.h"
#import "BookController.h"
#import "PromotionController.h"
#import "NewsViewController.h"
#import "MoveController.h"
#import "MusicController.h"
@interface RecommeViewController (Private)
- (void) doInit;
@end
@implementation RecommeViewController
@synthesize tabBar;
@synthesize currentController;
@synthesize contentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self doInit];
    }
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self doInit];
    }
    return  self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
static int indexs = 0;
- (void)viewDidLoad
{
    
    self.tabBar.nibFileName = @"RecommeTabBar";
    self.tabBar.delegate = self;
    self.tabBar.selectedIndex = indexs;
    
    [self doInit];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void) didItemSelectedWithIndex:(NSInteger)index
{
     NSLog(@"index %d",index);
    NSLog(@"didItemSelectedWithIndex  %d %@",index,self.currentController);
    if (index <= 2) {
        indexs = index;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];  
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.superview cache:YES];  
        [UIView commitAnimations];
        
        [self.currentController.view removeFromSuperview];
        self.currentController = [_subControllers objectAtIndex:index];
        self.title = @"1234";
        [self.contentView addSubview:self.currentController.view];
        NSLog(@" %@ ",self.currentController);
        
    }
}
- (void)viewDidUnload
{
    [self setTabBar:nil];
    [self setContentView:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
@implementation RecommeViewController (Private)

- (void) doInit
{
    _subControllers = [[NSMutableArray alloc] init];
    BookController *book = [[BookController alloc] initWithNibName:@"BookController" bundle:nil];
//    PromotionController *pro = [[PromotionController alloc] initWithNibName:@"PromotionController" bundle:nil];
    NewsViewController *new = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    MoveController *mov = [[MoveController alloc] initWithNibName:@"MoveController" bundle:nil];
    MusicController *music = [[MusicController alloc] initWithNibName:@"MusicController" bundle:nil];
     [_subControllers addObject:mov];
    [_subControllers addObject:book];
   
    [_subControllers addObject:music];
    
    [book release];
    [new release];
    [mov release];
    [music release];
}

@end