//
//  JXBaseViewController.h
//  JXProjectDemo
//
//  Created by Khada Jhin on 2018/8/27.
//  Copyright © 2018年 Jhin. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol MSTBaseViewControllerDataSource<NSObject>

@optional
- (NSMutableAttributedString *)setTitle;
- (UIButton *)set_leftButton;
- (UIButton *)set_rightButton;
- (UIColor *)set_colorBackground;
- (CGFloat)set_navigationHeight;
- (UIView *)set_bottomView;
- (UIImage *)navBackgroundImage;
- (UIImage *)set_leftBarButtonItemWithImage;
- (UIImage *)set_rightBarButtonItemWithImage;

@end

@protocol MSTBaseViewControllerDelegate <NSObject>

@optional
- (void)left_button_event:(UIButton *)sender;
- (void)right_button_event:(UIButton *)sender;
- (void)title_click_event:(UIView *)sender;

@end

@interface MSTBaseViewController : UIViewController<MSTBaseViewControllerDataSource,MSTBaseViewControllerDelegate>


- (void)set_Title:(NSMutableAttributedString *)title;

@end

