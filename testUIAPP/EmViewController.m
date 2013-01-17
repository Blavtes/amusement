//
//  ViewController.m
//  GXScrollToolbar2
//
//  Created by Yong on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmViewController.h"
#import "MyLabel.h"
#import "PromotionController.h"
#import "EmItemViewController.h"
#import "SignViewController.h"
#import "CartoonViewController.h"
#define LABEL_TOP_MARGIN 4
#define LABEL_LEFT_MARGIN 5
#define LABEL_HEIGHT 24
#define LABEL_WIDTH 80 //62
//#define LABEL_FONT 14
@interface EmViewController (Private)
- (void) doInit;
@end
@implementation EmViewController
@synthesize currentController;
@synthesize contentView;
#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentTag = 0;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tangwei.jpg"]];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIScrollView *scrollViewBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32.0f)];
    [scrollViewBar setShowsHorizontalScrollIndicator:NO];
    scrollViewBar.delegate = self;
    scrollViewBar.backgroundColor = [[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"navbar_background.png"]] autorelease];
    UIView *navbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32.0f)];
    currentTag = 0;
    labelArray = [[NSMutableArray alloc] init];
    
    NSInteger xOffset = LABEL_LEFT_MARGIN;
    
    MyLabel *label_0 = [[MyLabel alloc] initWithFrame:CGRectMake(xOffset, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
    label_0.textColor = [UIColor whiteColor];
    label_0.text = @"10句话";
    label_0.tag = 0;
    [label_0 setDelegate:self];
    [labelArray addObject:label_0];
    [navbarView addSubview:label_0]; 
    [label_0 release];
    xOffset += LABEL_WIDTH;
    
    MyLabel *label_1 = [[MyLabel alloc] initWithFrame:CGRectMake(xOffset, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
    label_1.text = @"褪墨笑话";
    label_1.tag = 1;
    [label_1 setDelegate:self];
    [labelArray addObject:label_1];
    [navbarView addSubview:label_1];
    [label_1 release];
    xOffset += LABEL_WIDTH;
    
    MyLabel *label_2 = [[MyLabel alloc] initWithFrame:CGRectMake(xOffset, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
    label_2.text = @"星座星语";
    label_2.tag = 2;
    [label_2 setDelegate:self];
    [labelArray addObject:label_2];
    [navbarView addSubview:label_2];
    [label_2 release];
    xOffset += LABEL_WIDTH;
    
    
    MyLabel *label_3 = [[MyLabel alloc] initWithFrame:CGRectMake(xOffset, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
    label_3.text = @"黑背漫画";
    label_3.tag = 3;
    [label_3 setDelegate:self];
    [labelArray addObject:label_3];
    [navbarView addSubview:label_3];
    [label_3 release];
    xOffset += LABEL_WIDTH;
    
//    MyLabel *label_4 = [[MyLabel alloc] initWithFrame:CGRectMake(xOffset, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
//    label_4.text = @"待续";
//    label_4.tag = 4;
//    [label_4 setDelegate:self];
//    [labelArray addObject:label_4];
//    [navbarView addSubview:label_4];
//    [label_4 release];
//    xOffset += LABEL_WIDTH;
//    
//    MyLabel *label_5 = [[MyLabel alloc] initWithFrame:CGRectMake(xOffset, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
//    label_5.text = @"理财";
//    label_5.tag = 5;
//    [label_5 setDelegate:self];
//    [labelArray addObject:label_5];
//    [navbarView addSubview:label_5];
//    [label_5 release];

    
    [scrollViewBar addSubview:navbarView];
    
    [self.view addSubview:scrollViewBar];
   
    
    selectBackgroudView = [[UIImageView alloc] initWithFrame:CGRectMake(LABEL_LEFT_MARGIN, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
    selectBackgroudView.image = [UIImage imageNamed:@"navbar_selected_background.png"];
    [scrollViewBar insertSubview:selectBackgroudView belowSubview:navbarView];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 24, 320, 343)];
    [self.view addSubview:contentView];
    [navbarView release];
     [scrollViewBar release];
     [self doInit];
    if (currentTag <= 3) {
        [self.currentController.view removeFromSuperview];
        self.currentController = [_subControllers objectAtIndex:currentTag];
        NSLog(@"self,currentController..is %@",self.currentController.view);
        [self.contentView addSubview:self.currentController.view];
    }

    
}

- (void)resetLabel:(NSInteger)tag {
    NSLog(@"tag = %d", tag);
    NSLog(@"labelArray.count = %d", labelArray.count);
    for (int i = 0; i < labelArray.count; i++) {
        if (i != (int)tag) {
            ((UILabel *)[labelArray objectAtIndex:i]).textColor = [UIColor blackColor];
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        self.view.frame = CGRectMake(0, 0, 320, 343);
//        
//    }else{
//        self.view.frame = CGRectMake(0, 0, 480, 320);
//        self.contentView.frame = CGRectMake(0, 0, 480, 320);
//        self.currentController.view.frame = CGRectMake(0, 0, 480, 320);
//    }
    return YES;

}
#pragma mark MyLabel Delegate Methods
- (void)myLabel:(MyLabel *)myLabel touchesWtihTag:(NSInteger)tag {
    NSLog(@"touchesWtihTag %d", tag);
    [UIView beginAnimations:@"SetSelectBackground" context:NULL];
    [UIView setAnimationDuration:0.15];
    myLabel.textColor = [UIColor whiteColor];
    if (tag == currentTag) {
        return;
    }
    currentTag = tag;
    [self resetLabel:tag];
    [selectBackgroudView setFrame:CGRectMake(LABEL_LEFT_MARGIN + LABEL_WIDTH*tag, LABEL_TOP_MARGIN, LABEL_WIDTH, LABEL_HEIGHT)];
    [self.currentController.view removeFromSuperview];
    NSLog(@"subControllers count %d",_subControllers.count);
    self.currentController = [_subControllers objectAtIndex:tag];
//    [self presentModalViewController:[_subControllers objectAtIndex:tag] animated:YES];
    [self.contentView addSubview:self.currentController.view];
    NSLog(@"curr %@ ",self.currentController);

    [UIView commitAnimations];
    
    
    
}

-(void)dealloc {
    [selectBackgroudView release];
    [labelArray release];
    [_subControllers release];
    [contentView release];
    [super dealloc];
}

@end
@implementation EmViewController (Private)

- (void) doInit
{
    _subControllers = [[NSMutableArray alloc] init];
    PromotionController *pro = [[PromotionController alloc] initWithNibName:@"PromotionController" bundle:nil];
   EmItemViewController *emite = [[EmItemViewController alloc] initWithNibName:@"EmItemViewController" bundle:nil];
    SignViewController *sign = [[SignViewController alloc] initWithNibName:@"SignViewController" bundle:nil];
    CartoonViewController *cartoon = [[CartoonViewController alloc] initWithNibName:@"CartoonViewController" bundle:nil];
    [_subControllers addObject:pro];
    [_subControllers addObject:emite];
    [_subControllers addObject:sign];
    [_subControllers addObject:cartoon];
    
    [pro release];
    [emite release];
    [sign release];
    [cartoon release];
}

@end