//
//  CartoonCell.h
//  testUIAPP
//
//  Created by Yong on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartoonCell : UITableViewCell<UIScrollViewDelegate>
{
    UIImageView *imageShow;
    UIScrollView *scrollView;
}
@property (retain, nonatomic) IBOutlet UIImageView *imageShow;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end
