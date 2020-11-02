//
//  ScienceNewCell.m
//  DiscoverFuture
//
//  Created by admin on 2019/3/18.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "ScienceNewCell.h"
#import "ActivityModel.h"

@implementation ScienceNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setScienceCell:(ActivityModel *)model {
    
    self.titleLbl.text = model.title;
    
}

@end
