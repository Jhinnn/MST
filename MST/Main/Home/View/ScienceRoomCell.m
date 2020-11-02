//
//  ScienceRoomCell.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "ScienceRoomCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+BgLayer.h"
@implementation ScienceRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _imageV.contentMode = UIViewContentModeScaleAspectFill;
//    _imageV.clipsToBounds = YES;
    
     [self.bgImageView LW_gradientColorWithRed:0/255.0 green:0/255.0 blue:0/255.0 startAlpha:0.8 endAlpha:0.1 direction:DirectionStyleToUn frame:CGRectMake(0, 0, kScreenWidth, 66)];
}

- (void)setHomePageFstCell:(ShowDetailModel *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgs]];
    self.titleLbl.text = model.title;
    self.contentLbl.text = model.desc;
    self.itemLbl.text = model.areaName;

}

@end
