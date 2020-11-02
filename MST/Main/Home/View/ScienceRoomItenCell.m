//
//  ScienceRoomItenCell.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/21.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "ScienceRoomItenCell.h"
#import "UIImageView+WebCache.h"
#import "RoomItemModel.h"

@interface  ScienceRoomItenCell()

@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *titles;
@end


@implementation ScienceRoomItenCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
//    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushAction)];
//    _imagev.userInteractionEnabled = YES;
//    [_imagev addGestureRecognizer:gr];
//
    _imagev.contentMode = UIViewContentModeScaleAspectFill;
    _imagev.clipsToBounds = YES;
}

- (void)setHomePageFstCell:(RoomItemModel *)model {
    [_imagev sd_setImageWithURL:[NSURL URLWithString:model.imgs]];
    _titleLbl.text = model.title;
    
    self.ids = model.id;
    self.images = model.imgs;
    self.titles = model.title;
}

//- (void)pushAction {
////    if (self.imageBlock) {
////        self.imageBlock(self.ids, self.images,self.titles);
////    }
//}

@end
