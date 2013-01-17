//
//  MovieShow.m
//  testUIAPP
//
//  Created by Yong on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MovieShow.h"
#import "NewsWebController.h"
#import "NSString+URLEncoding.h"
@implementation MovieShow


@synthesize image;
@synthesize name;
@synthesize cast;
@synthesize language;
@synthesize year;
@synthesize director;
@synthesize duration;
@synthesize types;
@synthesize titles;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        imgPhoto = [[EGOImageButton alloc]initWithPlaceholderImage:[UIImage imageNamed:@"thumb_pic.png"] delegate:self];
//        [imgPhoto setFrame:CGRectMake(0, 0, 0, 0)];
//        
//        [imgPhoto addTarget:self action:@selector(ImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];        
//        [self addSubview:imgPhoto];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void) dealloc
{
    self.name = nil;
    self.language = nil;
    self.cast = nil;
    self.year = nil;
    self.titles = nil;
    self.image = nil;
    self.director = nil;
    [duration release];
    [types release];
    [super dealloc];
}

- (IBAction)playerMovie:(id)sender {
 
    
    
}
@end
