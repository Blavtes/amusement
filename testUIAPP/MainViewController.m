//
//  MainViewController.m
//  testUIAPP
//
//  Created by Yong on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "RecommeViewController.h"
#import "TabBar.h"
#import "PromotionController.h"
#import "PartitionViewController.h"
#import "SearchViewController.h"
#import "UIAViewController.h"
#import "MapViewController.h"
#import "WebMapViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EmViewController.h"
#import "PromotionController.h"
#import "VideoRootViewController.h"
@interface MainViewController (Private)

- (void) doInit;

@end
@implementation MainViewController
@synthesize mainTitle;
@synthesize tabBar;
@synthesize currentController;
@synthesize contentView;
@synthesize titleArray = _titleArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"main";
        [self doInit];
        
    }
    return self;
}
//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self doInit];
//    }
//    return self;
//}
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
    self.tabBar.nibFileName = @"BottomTabBar";
    self.tabBar.delegate = self;
    self.tabBar.selectedIndex = 0;

   
    // Do any additional setup after loading the view from its nib.
}
- (void) didItemSelectedWithIndex:(NSInteger)index
{
//    NSLog(@"didItemSelectedWithIndex  %d %@",index,self.currentController);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];  
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view.superview cache:YES];  
    [UIView commitAnimations];
//    CATransition *animation = [CATransition animation];
//    animation.type = @"cube";
//    animation.duration = 3.0f;
//    animation.subtype = kCATransitionFromRight;
//    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    if (index == 3) {
        self.navigationController.hidesBottomBarWhenPushed = NO;

        [self.navigationController popToViewController:[_subViewControllers objectAtIndex:index ] animated:YES];
//        [self.navigationController pushViewController:[_subViewControllers objectAtIndex:index ] animated:YES];

    }
    NSArray *array = [[[NSArray alloc] initWithObjects:@"推荐",@"娱乐",@"新闻",@"视频",@"设置", nil] autorelease];
    if(index <= 3){
        self.mainTitle.text = [array objectAtIndex:index];
        [self.currentController.view  removeFromSuperview];
        self.currentController = [_subViewControllers objectAtIndex:index];
        [self.contentView addSubview:self.currentController.view];
//        NSLog(@"title %@ ....%@",self.navigationController.title,self.navigationController.title);
        self.navigationController.title = [NSString stringWithFormat:@"%@",[array objectAtIndex:index]];
//        NSLog(@"title  ....%@",self.currentController.navigationController.title);
    }
    NSLog(@"didItemSelectedWithIndex  %d %@",index,self.currentController);
    
}
- (void)viewDidUnload
{
    [self setTabBar:nil];
    [self setTabBar:nil];
    [self setMainTitle:nil];
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

- (IBAction)onReplyButton:(id)sender {

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];  
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view.superview cache:YES];  
    [UIView commitAnimations];
    if (currentController == [_subViewControllers objectAtIndex:0]) {
        NSLog(@"selecet  0...");
        [self.currentController.view removeFromSuperview];
       RecommeViewController *controller = [[[RecommeViewController alloc] initWithNibName:@"RecommeViewController" bundle:nil] autorelease];
        self.currentController = controller;
        [self.contentView addSubview:self.currentController.view];
        
    } 
    if (currentController == [_subViewControllers objectAtIndex:3]) {
        NSLog(@"selecet  3...");
        [self.currentController.view removeFromSuperview];
//        MapViewController *searchViewController = [[[MapViewController alloc] initWithNibName:@"MapView" bundle:nil] autorelease];
        VideoRootViewController *searchViewController = [[VideoRootViewController alloc] initWithNibName:@"VideoRootViewController" bundle:nil];
        self.currentController = searchViewController;
        [self.contentView addSubview:self.currentController.view];
//        [self.navigationController pushViewController:searchViewController animated:YES];
        
    } 
    if (currentController == [_subViewControllers objectAtIndex:2]) {
        NSLog(@"news....selecet");
        [self.currentController.view removeFromSuperview];
        liv = [[[UIAViewController alloc] initWithNibName:@"UIAViewController" bundle:nil] autorelease];
        self.currentController = liv;
        self.title = @"新闻中心";

        
        [self.contentView addSubview:self.currentController.view];
    }
    if (currentController == [_subViewControllers objectAtIndex:1]) {
        [self.currentController.view removeFromSuperview];
         EmViewController *promtionController = [[[EmViewController alloc] initWithNibName:@"EmViewController" bundle:nil] autorelease];
        [promtionController.currentController.view removeFromSuperview];
//        PromotionController *pro = [[PromotionController alloc] initWithNibName:@"PromotionController" bundle:nil];
        self.currentController = promtionController;
        [self.contentView addSubview:self.currentController.view];
        
    }
   
    
}
- (void) setMainTitleWithDelegate:(UIAViewController *)delegate
{
    NSArray *textArray = [NSArray arrayWithObjects:@"头条",@"国外",@"娱乐",@"体育",@"国内",nil];
    NSLog(@"title setNow %@",[textArray objectAtIndex:delegate.currenttag-1000]);
    self.mainTitle.text = [NSString stringWithFormat:@"新闻*%@",[textArray objectAtIndex:delegate.currenttag-1000]];
}
- (void)dealloc {
//    [TabBar release];
//    [tabBar release];
    [mainTitle release];
    [super dealloc];
}
@end

@implementation MainViewController (Private)

- (void) doInit
{
    _subViewControllers = [[NSMutableArray alloc] init];
    RecommeViewController *controller = [[[RecommeViewController alloc] initWithNibName:@"RecommeViewController" bundle:nil] autorelease];
    [_subViewControllers addObject:controller];
    EmViewController *promtionController = [[[EmViewController alloc] initWithNibName:@"EmViewController" bundle:nil] autorelease];
//    ForthViewController *forth = [[ForthViewController alloc] initWithNibName:@"ForthViewController" bundle:nil];
    [_subViewControllers addObject:promtionController];
//    PartitionViewController *partitionController = [[PartitionViewController alloc] initWithNibName:@"PartitionViewController" bundle:nil];
//    [_subViewControllers addObject:partitionController];
    liv = [[[UIAViewController alloc] initWithNibName:@"UIAViewController" bundle:nil] autorelease];
    [_subViewControllers addObject:liv];
    liv.delegate = self;
//    MapViewController *searchViewController = [[[MapViewController alloc] initWithNibName:@"MapView" bundle:nil] autorelease];
//    WebMapViewController *searchViewController = [[WebMapViewController alloc] initWithNibName:@"WebMapView" bundle:nil];
    VideoRootViewController *vi = [[VideoRootViewController alloc] initWithNibName:@"VideoRootViewController" bundle:nil];
    [_subViewControllers addObject:vi];
//    [_subViewControllers addObject:searchViewController];
}

@end