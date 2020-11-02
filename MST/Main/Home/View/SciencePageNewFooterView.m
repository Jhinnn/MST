//
//  SciencePageNewFooterView.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "SciencePageNewFooterView.h"
#import "DFScienceActivityViewController.h"
@implementation SciencePageNewFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(100, 0, kScreenWidth - 200, 55);
    [moreButton setTitleColor:HEXCOLOR(0x646464) forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreButton setTitle:@"查看更多 >" forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreButton];
}

- (void)moreAction:(UIButton *)btn {
    DFScienceActivityViewController *activityVC = [[DFScienceActivityViewController alloc] init];
    UINavigationController *currentNC = [self currentNC];
    [currentNC pushViewController:activityVC animated:YES];
}

#pragma 获取当前UINavigationController
- (UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

//递归
- (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}


@end
