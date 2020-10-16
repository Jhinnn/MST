//
//  HomeViewController.h
//  JXProjectDemo
//
//  Created by Khada Jhin on 2018/8/27.
//  Copyright © 2018年 Jhin. All rights reserved.
//

#import "MSTBaseViewController.h"
@interface MSTBaseViewController ()<UIAlertViewDelegate> {
    CGFloat navigationY;
    CGFloat navBarY;
    CGFloat verticalY;
    BOOL _isShowMenu;
}

@property CGFloat original_height;
@property(nonatomic ,strong)UIView *overlay;
@property (nonatomic, strong) UIView *noNetView;


@end

@implementation MSTBaseViewController

-(id)init {
    if (self == [super init]) {
        navBarY = 0;
        navigationY = 0;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    if ([self respondsToSelector:@selector(navBackgroundImage)]) {
        UIImage *bgimage = [self navBackgroundImage];
        [self setNavigationBack:bgimage];
    }
    if ([self respondsToSelector:@selector(setTitle)]) {
        NSMutableAttributedString *titleAttri = [self setTitle];
        [self set_Title:titleAttri];
    }
    if (![self leftButton]) {
        [self configLeftBaritemWithImage];
    }
    
    if (![self rightButton]) {
        [self configRightBaritemWithImage];
    }
}


-(void)setNavigationBack:(UIImage*)image {
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image ];
    [self.navigationController.navigationBar setShadowImage:image];
}

#pragma mark --- NORMAl

-(void)set_Title:(NSMutableAttributedString *)title {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    label.numberOfLines=0;//可能出现多行的标题
    [label setAttributedText:title];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    [label addGestureRecognizer:tap];
    self.navigationItem.titleView = label;
}

-(void)titleClick:(UIGestureRecognizer*)Tap {
    UIView *view = Tap.view;
    if ([self respondsToSelector:@selector(title_click_event:)]) {
        [self title_click_event:view];
    }
}

#pragma mark -- left_item
-(void)configLeftBaritemWithImage {
    if ([self respondsToSelector:@selector(set_leftBarButtonItemWithImage)]) {
        UIImage *image = [self set_leftBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self  action:@selector(left_click:)];
        item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.navigationItem.leftBarButtonItem = item;
    }
}

-(void)configRightBaritemWithImage {
    if ([self respondsToSelector:@selector(set_rightBarButtonItemWithImage)]) {
        UIImage *image = [self set_rightBarButtonItemWithImage];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self  action:@selector(right_click:)];
        item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.navigationItem.rightBarButtonItem = item;
    }
}

#pragma mark -- left_button
-(BOOL)leftButton {
    BOOL isleft =  [self respondsToSelector:@selector(set_leftButton)];
    if (isleft) {
        UIButton *leftbutton = [self set_leftButton];
        [leftbutton addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
        self.navigationItem.leftBarButtonItem = item;
    }
    return isleft;
}

#pragma mark -- right_button
-(BOOL)rightButton {
    BOOL isright = [self respondsToSelector:@selector(set_rightButton)];
    if (isright) {
        UIButton *right_button = [self set_rightButton];
        [right_button addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
    return isright;
}


-(void)left_click:(id)sender {
    if ([self respondsToSelector:@selector(left_button_event:)]) {
        [self left_button_event:sender];
    }
}

-(void)right_click:(id)sender {
    if ([self respondsToSelector:@selector(right_button_event:)]) {
        [self right_button_event:sender];
    }
}


@end

