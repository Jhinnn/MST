//
//  ScienceRoomCollectionView.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "ScienceRoomItemCollcetionView.h"
#import "ScienceRoomItenCell.h"
#import "DFScienceRoomItemDetailViewController.h"
#import "RoomItemModel.h"
@interface ScienceRoomItemCollcetionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation ScienceRoomItemCollcetionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.bounces = NO;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = HEXCOLOR(0xF5F5F5);
//        self.backgroundColor = [UIColor redColor];
        [self registerNib:[UINib nibWithNibName:@"ScienceRoomItenCell" bundle:nil] forCellWithReuseIdentifier:@"ScienceRoomItenCell"];
    }
    return self;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 10.0f, 0.0f, 10.0f);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

//cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-30)/2, 105);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScienceRoomItenCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ScienceRoomItenCell" forIndexPath:indexPath];
//    cell.imageBlock = ^(NSString *itemId, NSString *imageUrl, NSString *title) {
//        DFScienceRoomItemDetailViewController *storeVC = [[DFScienceRoomItemDetailViewController alloc]init];
//
//        storeVC.itemId = itemId;
//        storeVC.title = title;
//        storeVC.imageUrl = imageUrl;
//        UINavigationController *currentNC = [self currentNC];
//        [currentNC pushViewController:storeVC animated:YES];
//    };
    [cell setHomePageFstCell:_dataArr[indexPath.item]];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFScienceRoomItemDetailViewController *storeVC = [[DFScienceRoomItemDetailViewController alloc]init];
    RoomItemModel *model = _dataArr[indexPath.item];
    storeVC.itemId = model.id;
    storeVC.title = model.title;
    storeVC.imageUrl = model.imgs;
    storeVC.itemRoomName = self.itemRoomName;
    UINavigationController *currentNC = [self currentNC];
    [currentNC pushViewController:storeVC animated:YES];
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
