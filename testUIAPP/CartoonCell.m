//
//  CartoonCell.m
//  testUIAPP
//
//  Created by Yong on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CartoonCell.h"

@implementation CartoonCell
@synthesize imageShow;
@synthesize scrollView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect rect = CGRectMake(0, 0, 320, 500);
        scrollView = [[UIScrollView alloc] initWithFrame:rect];
        
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 3.0f;
        imageShow = [[UIImageView alloc] initWithFrame:rect];
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollViews
{
    NSLog(@"scrollView   cell...delegate....");
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
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        self.frame = CGRectMake(0, 0, 320, 343);
//        self.scrollView.frame = CGRectMake(0, 0, 320, 500);
//        self.imageShow.frame = CGRectMake(0, 0, 320, 500);
//        
//    }else{
//        self.frame = CGRectMake(0, 0, 480, 320);
//        self.scrollView.frame = CGRectMake(0, 0, 480, 500);
//        self.imageShow.frame = CGRectMake(0, 0, 480, 800);
//    }
    return YES;
}

- (void)dealloc {
    [imageShow release];
    [scrollView release];
    [super dealloc];
}
@end
