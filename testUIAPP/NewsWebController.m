//
//  NewsWebController.m
//  testUIAPP
//
//  Created by Yong on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsWebController.h"

@implementation NewsWebController
@synthesize webView = _webView;
@synthesize webURL = _webURL;
@synthesize newsTitle = _newsTitle;

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
    [self didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;

    NSString *newWebURL = [NSString stringWithString:self.webURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newWebURL]]];
    self.navigationItem.title = self.newsTitle;
    self.webView.allowsInlineMediaPlayback = YES;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_webView release];
    [_webURL release];
    [_newsTitle release];
    [super dealloc];
}
@end
