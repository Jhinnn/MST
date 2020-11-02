//
//  UIImageView+JXAnimationImageView.h
//  JXProjectDemo
//
//  Created by Khada Jhin on 2018/8/28.
//  Copyright © 2018年 Jhin. All rights reserved.
//

#import <UIKit/UIKit.h>


//只要求UIImageView有这个方法,而不需要UIImageView子类有这个方法,苹果为了解决这个问题,就引入分类.
@interface UIImageView (AnimationImageView)

- (void)startScaleAnimation;

@end
