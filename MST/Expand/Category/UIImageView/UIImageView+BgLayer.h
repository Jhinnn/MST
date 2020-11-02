//
//  UIImageView+BgLayer.h
//  DiscoverFuture
//
//  Created by admin on 2019/4/17.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DirectionStyle){
    DirectionStyleToUnder = 0,  //向下
    DirectionStyleToUn = 1      //向上
};
NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (BgLayer)

- (void)LW_gradientColorWithRed:(CGFloat)red
                          green:(CGFloat)green
                           blue:(CGFloat)blue
                     startAlpha:(CGFloat)startAlpha
                       endAlpha:(CGFloat)endAlpha
                      direction:(DirectionStyle)direction
                          frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
