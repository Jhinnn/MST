//
//  DFScanResultViewController.h
//  DiscoverFuture
//
//  Created by admin on 2019/1/30.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "MSTBaseViewController.h"

typedef void(^BackBlock)(void);

@interface MSTScanResultViewController : MSTBaseViewController

@property (nonatomic, copy) NSString *resultString;
@property (nonatomic, copy) BackBlock backBlock;

@end
