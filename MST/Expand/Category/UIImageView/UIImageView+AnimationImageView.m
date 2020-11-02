//
//  UIImageView+JXAnimationImageView.m
//  JXProjectDemo
//
//  Created by Khada Jhin on 2018/8/28.
//  Copyright © 2018年 Jhin. All rights reserved.
//

#import "UIImageView+AnimationImageView.h"

@implementation UIImageView (AnimationImageView)

- (void)startScaleAnimation {
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    animation.keyPath = @"transform.scale";
    animation.duration = 8.0;
    animation.values = @[@1.0, @1.2, @1.0];
    animation.keyTimes = @[@0.0, @0.5, @1.0];
    animation.repeatCount = CGFLOAT_MAX;
    animation.calculationMode = kCAAnimationLinear;
    [animation setIsAccessibilityElement:NO];
    [animation setFillMode:kCAFillModeForwards];
    [self.layer addAnimation:animation forKey:@"SCALE"];
}

@end
