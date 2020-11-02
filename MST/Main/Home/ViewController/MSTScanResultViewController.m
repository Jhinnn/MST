//
//  DFScanResultViewController.m
//  DiscoverFuture
//
//  Created by admin on 2019/1/30.
//  Copyright © 2019 Jhinnn. All rights reserved.
//

#import "MSTScanResultViewController.h"

@interface MSTScanResultViewController ()

@end

@implementation MSTScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描结果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    textLbl.textColor = HEXCOLOR(0x323232);
    textLbl.textAlignment = NSTextAlignmentCenter;
    textLbl.font = [UIFont systemFontOfSize:16];
    textLbl.numberOfLines = 0;
    textLbl.text = self.resultString;
    [self.view addSubview:textLbl];
}

- (void)left_button_event:(UIButton *)sender {
//    self.backBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)set_leftBarButtonItemWithImage {
    return [UIImage imageNamed:@"nav_icon_back"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
