//
//  UIImageView+BgLayer.m
//  DiscoverFuture
//
//  Created by admin on 2019/4/17.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "UIImageView+BgLayer.h"

@implementation UIImageView (BgLayer)

- (void)LW_gradientColorWithRed:(CGFloat)red
                          green:(CGFloat)green
                           blue:(CGFloat)blue
                     startAlpha:(CGFloat)startAlpha
                       endAlpha:(CGFloat)endAlpha
                      direction:(DirectionStyle)direction
                          frame:(CGRect)frame
{
    //底部上下渐变效果背景
    // The following methods will only return a 8-bit per channel context in the DeviceRGB color space. 通过图片上下文设置颜色空间间
    UIGraphicsBeginImageContext(frame.size);
    //获得当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建颜色空间 /* Create a DeviceRGB color space. */
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    //通过矩阵调整空间变换
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    
    //通过颜色组件获得渐变上下文
    CGGradientRef backGradient;
    //253.0/255.0, 163.0/255.0, 87.0/255.0, 1.0,
    if (direction == DirectionStyleToUnder) {
        //向下
        //设置颜色 矩阵
        CGFloat colors[] = {
            red, green, blue, startAlpha,
            red, green, blue, endAlpha,
        };
        backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    } else {
        //向上
        CGFloat colors[] = {
            red, green, blue, endAlpha,
            red, green, blue, startAlpha,
        };
        backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    }
    
    //释放颜色渐变
    CGColorSpaceRelease(rgb);
    //通过上下文绘画线色渐变
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0.5, 0), CGPointMake(0.5, 1), kCGGradientDrawsBeforeStartLocation);
    //通过图片上下文获得照片
    self.image = UIGraphicsGetImageFromCurrentImageContext();
}

@end
