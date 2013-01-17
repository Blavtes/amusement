//
//  YoukuVideoViewController.m
//  LoveBeeAudioVisual
//
//  Created by liuyan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YoukuVideoViewController.h"

@interface YoukuVideoViewController ()

@end

@implementation YoukuVideoViewController

@synthesize HUD = _HUD;
@synthesize webView = _webView;
@synthesize urlRequest = _urlRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.HUD = nil;
    self.urlRequest = nil;
    self.webView = nil;
    [super dealloc];
}

- (void)backPress
{
	if(nil != self.webView)
	{
		[self.webView goBack];
	}
}


- (void)viewDidLoad
{
    
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate=self;
    self.webView.frame = CGRectMake(0, 0, 320, 367);
    
    [self.view addSubview:self.webView];
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.delegate = self;
    [self.view addSubview:self.HUD];
    
    
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"后 退" style:UIBarButtonItemStyleBordered target:self action:@selector(backPress)];	
	self.navigationItem.rightBarButtonItem=backButton;
    
    NSString *strUrl=[NSString stringWithFormat: @"http://m.youku.com/"]; 
    
    NSURL* url = [[NSURL alloc] initWithString:strUrl];
    
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL: url];
    
    @try
    {
        [self.webView loadRequest: urlRequest];
        
    }
    @catch (NSException * e) 
    {
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"出现异常，可能是网络连接问题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	@finally 
    {
		[urlRequest release];
        [url release];
        
	}
	
	[backButton release];	
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self.HUD show:YES];
    self.HUD.labelText = @"正在加载，请稍后......";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self.HUD hide:YES];
	//- (void)hide:(BOOL)animated;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
	
	NSLog(@"Hud: %@", hud);
    // Remove HUD from screen when the HUD was hidded
    //[self.HUD removeFromSuperview];
    //[self.HUD release];
}

@end
