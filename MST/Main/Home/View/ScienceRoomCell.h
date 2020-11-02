//
//  ScienceRoomCell.h
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDetailModel.h"
@interface ScienceRoomCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemLbl;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

- (void)setHomePageFstCell:(ShowDetailModel *)model;

@end
