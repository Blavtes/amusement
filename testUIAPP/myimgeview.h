//
//  myimgeview.h
//  UIA
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface myimgeview : UIImageView
{
	id dege;
}
-(void)setdege:(id)ID;
- (id)initWithImage:(UIImage *)image text:(NSString *)text;
@end
