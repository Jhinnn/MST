//
//  SciencePageTableView.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "SciencePageTableView.h"
#import "ScienceNewCell.h"
#import "SciencePageNewFooterView.h"
#import "DFScienceActivityDetailViewController.h"
#import "ActivityModel.h"

@implementation SciencePageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"ScienceNewCell" bundle:nil] forCellReuseIdentifier:@"ScienceNewCell"];
        [self registerClass:[SciencePageNewFooterView class] forHeaderFooterViewReuseIdentifier:@"SciencePageNewFooterView"];
        self.arrData = [NSMutableArray new];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScienceNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScienceNewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setScienceCell:self.arrData[indexPath.row]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return self.arrData.count == 0 ? 0 : 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DFScienceActivityDetailViewController *vc = [[DFScienceActivityDetailViewController alloc] init];
    ActivityModel *model = self.arrData[indexPath.row];
    vc.activityID  = model.id;
    vc.imageUrl = model.imgs;
    vc.titles = model.title;
    if ([model.status isEqualToString:@"2"]) {
        vc.status = YES;
    }else {
        vc.status = NO;
    }
    vc.applyFlag = model.applyFlag;
    UINavigationController *currentNC = [self currentNC];
    [currentNC pushViewController:vc animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SciencePageNewFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SciencePageNewFooterView"];
    if (footView && self.arrData.count != 0) {
        footView = [[SciencePageNewFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    }
    
    return footView;
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
