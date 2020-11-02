//
//  ScienceNewCell.h
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivityModel;
@interface ScienceNewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

- (void)setScienceCell:(ActivityModel *)model;

@end
