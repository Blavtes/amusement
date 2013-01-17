//
//  myimgeview.m
//  UIA
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "myimgeview.h"
#import"UIAViewController.h"

@implementation myimgeview

- (id)initWithImage:(UIImage *)image text:(NSString *)text
{
    self = [super init];
    if (self) 
    {
        UIImageView *imagview= [[UIImageView alloc]initWithImage:image];
        imagview.frame = CGRectMake(0,0,120,120);
        [self addSubview:imagview];
        [imagview release];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0,120,120,20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = text;
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        [label release];
    }
    return self;
}

-(void)setdege:(id)ID
{
	self.userInteractionEnabled = YES;
	dege = ID;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UIAViewController *tmp = (UIAViewController *)dege;
	[tmp Clickup:self.tag];
}
@end
