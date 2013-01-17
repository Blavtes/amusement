//
//  RatingView.h
//  BookCellTest
//
//  Created by qianfeng on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView
{
    float _rating;
    UIImageView *bgImageView;
    UIImageView *fgImageView;
}
@property (assign) float rating;
@end
