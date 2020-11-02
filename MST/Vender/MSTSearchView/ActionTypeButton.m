//
//  ActionTypeButton.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "ActionTypeButton.h"

@implementation ActionTypeButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 43 + 19 + 9, self.width, 12); // 2 11 18
}
// 返回图片边界
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((self.width - 43)/2, 19, 43, 43); // 4 9 13 16 20
}

- (void)setHighlighted:(BOOL)highlighted {
    
}


@end
