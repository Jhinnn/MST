//
//  SearchView.h
//  DiscoverFuture
//
//  Created by Jhin on 2018/11/27.
//  Copyright © 2018 Jhinnn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchTouchBlock)(void);
typedef void(^ScanTouchBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MSTSearchView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UIImageView *searchImage;
@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, copy) SearchTouchBlock searchBlock;
@property (nonatomic, copy) ScanTouchBlock scanBlock;

@end

NS_ASSUME_NONNULL_END
