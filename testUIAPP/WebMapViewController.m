//
//  WebMapViewController.m
//  Bus
//
//  Created by yong on 9-3-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebMapViewController.h"


@implementation WebMapViewController
@synthesize myWenView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.hidesBackButton = YES;
	
	
	UIBarButtonItem *mapButton = [[UIBarButtonItem alloc]
									 initWithTitle:@"Map"
									 style:UIBarButtonItemStyleBordered
									 target:self
									 action:@selector(goToMap:)];
	
    self.navigationItem.rightBarButtonItem = mapButton;
	
	NSMutableString *googleSearch = [NSMutableString stringWithFormat:@"http://ditu.google.cn/maps?f=d&source=s_d&saddr='西直门'&daddr='北京西站'&hl=zh&t=m&dirflg=h"];
	[myWenView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[googleSearch stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
	
    [mapButton release];
}

- (IBAction) goToMap:(id)sender
{
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
	[self.navigationController popViewControllerAnimated:NO];
	[UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSInteger styleNum = [userDefault integerForKey:@"styleType"];
	
	switch (styleNum) {
		case 0:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
			self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//			self.mapStyleSegCtr.tintColor = [UIColor colorWithRed:0.48	green:0.56 blue:0.66 alpha:1.0];
//			self.mapNavigationBar.barStyle = UIBarStyleDefault;
			break;
		}
		case 1:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
			self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//			self.mapStyleSegCtr.tintColor = [UIColor darkGrayColor];
//			self.mapNavigationBar.barStyle = UIBarStyleBlackOpaque;
			break;
		}
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.myWenView=nil;
}


- (void)dealloc {
   
	[myWenView release];
    [super dealloc];

}


@end
