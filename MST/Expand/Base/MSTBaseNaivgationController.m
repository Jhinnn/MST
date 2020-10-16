//
//  JXBaseNaivgationController.m
//  JXProjectDemo
//
//  Created by Khada Jhin on 2018/8/27.
//  Copyright © 2018年 Jhin. All rights reserved.
//

#import "MSTBaseNaivgationController.h"
@interface MSTBaseNaivgationController ()<UIGestureRecognizerDelegate>

@end

@implementation MSTBaseNaivgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题文字属性
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:17]
                                               };
    
    //导航栏背景颜色
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {  //self.viewControllers 为push过的controller数组
        //第二级隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}





@end
