//
//  MusicShow.m
//  testUIAPP
//
//  Created by Yong on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicShow.h"

@implementation MusicShow

@synthesize image;
@synthesize author;
@synthesize ratingLabel;
@synthesize publisher;
@synthesize pubDate;
@synthesize fgImageView;
@synthesize bgImageView;
@synthesize name;
@synthesize rating = _rating;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    [self viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (float) rating
{
    return _rating;
}
- (void) setRating:(float)rating
{
    _rating = rating;
    CGFloat newWidth = bgImageView.frame.size.width*rating/10.0f;
    CGRect rect = CGRectMake(144, 78, newWidth, bgImageView.frame.size.height);
    fgImageView.frame = rect;
    NSLog( @"rating is %f ,%@",rating,NSStringFromCGRect(rect));
    fgImageView.clipsToBounds = YES;
    [fgImageView setContentMode:UIViewContentModeTopLeft];
}
- (void)dealloc {

    [image release];
    [author release];
    [ratingLabel release];
    [publisher release];
    [pubDate release];
    [name release];
    [fgImageView release];
    [bgImageView release];
    [super dealloc];
}
@end
