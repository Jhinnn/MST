//
//  ScienceRoomItenCell.h
//  DiscoverFuture
//
//  Created by admin on 2019/3/21.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RoomItemModel;

typedef void(^ImageBlock)(NSString *itemId,NSString *imageUrl,NSString *title);

@interface ScienceRoomItenCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (nonatomic, copy) ImageBlock imageBlock;

- (void)setHomePageFstCell:(RoomItemModel *)model;




@end
