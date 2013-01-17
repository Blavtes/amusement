//
//  MyLabel.m
//  GXScrollToolbar2
//
//  Created by Gabriel GX on 12-4-5.
//  Copyright (c) 2012年 顧欣. All rights reserved.
//

#import "MyLabel.h"

#define LABEL_FONT 13

@implementation MyLabel
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 公共属性
        self.textColor = [UIColor blackColor]; 
        self.textAlignment = UITextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:LABEL_FONT];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;   
    }
    return self;
}


// 点击该label的时候, 来个高亮显示
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:[UIColor whiteColor]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self setTextColor:COLOR(59,136,195,1.0)];

    
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    
    NSLog(@"points.x = %f", points.x);
    
    if (points.x >= 0 && points.y >= 0 && points.x <= self.frame.size.width && points.y <= self.frame.size.height) {
        [delegate myLabel:self touchesWtihTag:self.tag];
    }
}

- (void)dealloc {
    [super dealloc];
}

@end
