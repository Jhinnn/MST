//
//  ScienceRoomCollectionView.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "ScienceRoomCollectionView.h"
#import "ScienceRoomCell.h"
#import "ScienceRoomMoreReusableView.h"
#import "DFScienceRoomItemDetailViewController.h"
#import "ShowDetailModel.h"
#import "DFScienceItemListViewController.h"
#import "DFScienceRoomViewController.h"
@interface ScienceRoomCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation ScienceRoomCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.bounces = NO;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"ScienceRoomCell" bundle:nil] forCellWithReuseIdentifier:@"ScienceRoomCell"];
        [self registerNib:[UINib nibWithNibName:@"ScienceRoomMoreReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ScienceRoomMoreReusableView"];
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



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

//cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - 10 - 30)/2, 120);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScienceRoomCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ScienceRoomCell" forIndexPath:indexPath];
    [cell setHomePageFstCell:_dataArr[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFScienceRoomItemDetailViewController *storeVC = [[DFScienceRoomItemDetailViewController alloc]init];
    ShowDetailModel *model = _dataArr[indexPath.item];
    storeVC.itemId = model.id;
    storeVC.title = model.title;
    storeVC.imageUrl = model.imgs;
    storeVC.itemRoomName = model.areaName;
    UINavigationController *currentNC = [self currentNC];
    [currentNC pushViewController:storeVC animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionFooter)
    {
        ScienceRoomMoreReusableView *headView =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ScienceRoomMoreReusableView" forIndexPath:indexPath];
        reusableview = headView;

//        headView.guessLbl.attributedText = guessStr;
//
//        // 更多
        [headView.moreButton addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
    }
    return reusableview;
}
//
//// 更多
- (void)clickMore
{
    
    DFScienceRoomViewController *roomVC = [[DFScienceRoomViewController alloc] init];
//    [self.navigationController pushViewController:roomVC animated:YES];
    
//    DFScienceItemListViewController *storeVC = [[DFScienceItemListViewController alloc]init];
//    storeVC.dataArray = _dataArr;
    UINavigationController *currentNC = [self currentNC];
    [currentNC pushViewController:roomVC animated:YES];
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
