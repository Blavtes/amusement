//
//  MyLabel.h
//  GXScrollToolbar2
//
//  Created by Gabriel GX on 12-4-5.
//  Copyright (c) 2012年 顧欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyLabel;
@protocol MyLabelDelegate <NSObject>
@required
- (void)myLabel:(MyLabel *)myLabel touchesWtihTag:(NSInteger)tag;
@end

@interface MyLabel : UILabel {
    id <MyLabelDelegate> delegate; 
}
@property (nonatomic, assign) id <MyLabelDelegate> delegate;
@end
