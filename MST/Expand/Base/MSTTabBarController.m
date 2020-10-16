//
//  JXViewController.m
//  JXProjectDemo
//
//  Created by Khada Jhin on 2018/8/27.
//  Copyright © 2018年 Jhin. All rights reserved.
//

#import "MSTTabBarController.h"
#import "MSTBaseNaivgationController.h"
#import "MSTHomeViewController.h"
#import "MSTLiveViewController.h"
#import "MSTMineViewController.h"
@interface MSTTabBarController ()

@end

@implementation MSTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
}


- (void)setUpAllChildViewController {
    MSTHomeViewController *home = [[MSTHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tab_icon_1_1"] selectedImage:[UIImage imageNamed:@"tab_icon_1_2"] title:@"首页"];
    
    MSTLiveViewController *live = [[MSTLiveViewController alloc] init];
    [self setUpOneChildViewController:live image:[UIImage imageNamed:@"tab_icon_3_1"] selectedImage:[UIImage imageNamed:@"tab_icon_3_2"] title:@"直播"];
    
    MSTMineViewController *mine = [[MSTMineViewController alloc] init];
    [self setUpOneChildViewController:mine image:[UIImage imageNamed:@"tab_icon_4_1"] selectedImage:[UIImage imageNamed:@"tab_icon_4_2"] title:@"我的"];
}
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MSTBaseNaivgationController *nav = [[MSTBaseNaivgationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
