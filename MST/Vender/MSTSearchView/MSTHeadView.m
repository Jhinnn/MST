//
//  SearchView.m
//  DiscoverFuture
//
//  Created by Jhin on 2018/11/27.
//  Copyright © 2018 Jhinnn. All rights reserved.
//

#import "MSTHeadView.h"
#import "Masonry.h"
@implementation MSTHeadView


- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        [self viewConfig];
        [self layoutPageSubviews];
    }
    
    return self;
}

- (void)viewConfig {
    
    [self addSubview:self.scanButton];
    [self addSubview:self.logoImage];
    [self addSubview:self.topView];
    
    [self.topView addSubview:self.searchImage];
    [self.topView addSubview:self.searchLabel];

}

- (void)layoutPageSubviews {

    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(5);
        make.top.equalTo(self).width.offset(STATUS_BAR_HEIGHT + 7);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-5);
        make.top.equalTo(self).width.offset(STATUS_BAR_HEIGHT + 7);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImage.mas_left).with.offset(43);
        make.right.equalTo(self.scanButton.mas_left).with.offset(-13);
        make.height.equalTo(@30);
        make.top.equalTo(self).width.offset(STATUS_BAR_HEIGHT + 7);
    }];

    [self.searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(15);
        make.centerY.equalTo(self.topView);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];

    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImage.mas_right).with.offset(5);
        make.right.equalTo(self.topView).with.offset(-17);
        make.centerY.equalTo(self.topView);
        make.height.equalTo(self.topView);
    }];
}


- (void)touchesEvent {
    
    if (self.searchBlock) {
        self.searchBlock();
    }
    
}

- (void)scanAction:(UIButton *)button {
    if (self.scanBlock) {
        self.scanBlock();
    }
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.layer.masksToBounds = YES;
        _topView.layer.cornerRadius = 15;
        _topView.backgroundColor = RGB(240, 240, 240);
    }
    return _topView;
}
- (UILabel *)searchLabel {
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] init];
        _searchLabel.textColor = HEXCOLOR(0xA6A6A6);
        _searchLabel.font = [UIFont systemFontOfSize:14];
        _searchLabel.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesEvent)];
        [_searchLabel setUserInteractionEnabled:YES];
        [_searchLabel addGestureRecognizer:tap];
    }
    return _searchLabel;
}


- (UIImageView *)searchImage {
    if (!_searchImage) {
        _searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_search"]];
    }
    return _searchImage;
}


- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"place"]];
        _logoImage.layer.masksToBounds = YES;
        _logoImage.layer.cornerRadius = 15;
    }
    return _logoImage;
}


- (UIButton *)scanButton {
    if (!_scanButton) {
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanButton setImage:[UIImage imageNamed:@"nav_icon_scan"] forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}



@end
