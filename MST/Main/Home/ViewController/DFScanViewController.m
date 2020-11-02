//
//  ScanViewController.m
//  HLRCode
//
//  Created by 郝靓 on 2018/7/9.
//  Copyright © 2018年 郝靓. All rights reserved.
//

#import "DFScanViewController.h"
#import "MyBase64.h"
#import "JXNetRequest+Home.h"
#import "DFScanResultViewController.h"
#import "DFScoreViewController.h"
#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y

#define SHeight 20

#define SWidth (XCenter+30)

@interface DFScanViewController ()
{
    NSTimer *_timer;
    int num;
    BOOL upOrDown;
    
}
@end

@implementation DFScanViewController

#pragma mark ===========懒加载===========
//device
- (AVCaptureDevice *)device
{
    if (_device == nil) {
        //AVMediaTypeVideo是打开相机
        //AVMediaTypeAudio是打开麦克风
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}
//input
- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
//output  --- output如果不打开就无法输出扫描得到的信息
// 设置输出对象解析数据时感兴趣的范围
// 默认值是 CGRect(x: 0, y: 0, width: 1, height: 1)
// 通过对这个值的观察, 我们发现传入的是比例
// 注意: 参照是以横屏的左上角作为, 而不是以竖屏
//        out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //限制扫描区域(上下左右)
        [_output setRectOfInterest:[self rectOfInterestByScanViewRect:_imageView.frame]];
    }
    return _output;
}
- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}

//session
- (AVCaptureSession *)session
{
    if (_session == nil) {
        //session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}
//preview
- (AVCaptureVideoPreviewLayer *)preview
{
    if (_preview == nil) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _preview;
}

#pragma mark ==========ViewDidLoad==========
- (void)viewDidLoad
{

    
    //1 判断是否存在相机
    if (self.device == nil) {
//        [self showAlertViewWithMessage:@"未检测到相机"];
        
        return;
    }
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(chooseButtonClick)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_back"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(dismissAction)];
//
    //打开定时器，开始扫描
    [self addTimer];
    
    //界面初始化
    [self interfaceSetup];
    
    //初始化扫描
    [self scanSetup];
    
    
    
}

- (void)dismissAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark ==========初始化工作在这里==========
- (void)viewDidDisappear:(BOOL)animated
{
    //视图退出，关闭扫描
    [self.session stopRunning];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
}
//界面初始化
- (void)interfaceSetup
{
    //1 添加扫描框
    [self addImageView];
    
    //添加模糊效果
    [self setOverView];
    //添加开始扫描按钮
    //    [self addStartButton];
    
}

//添加扫描框
- (void)addImageView {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((Width-SWidth)/2, (Height-SWidth)/2, SWidth, SWidth)];
    //显示扫描框
    _imageView.image = [UIImage imageNamed:@"scanscanBg.png"];
    [self.view addSubview:_imageView];
    _line = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5, CGRectGetWidth(_imageView.frame), 3)];
    _line.image = [UIImage imageNamed:@"scanLine"];
    [self.view addSubview:_line];
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [lable setText:@"将二维码放入框内，自动识别"];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:14];
    lable.center = CGPointMake(_imageView.center.x , _imageView.center.y+ SWidth/2 + 30);
    [self.view addSubview:lable];
}

//初始化扫描配置
- (void)scanSetup
{
    //2 添加预览图层
    self.preview.frame = self.view.bounds;
    self.preview.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    //3 设置输出能够解析的数据类型
    //注意:设置数据类型一定要在输出对象添加到回话之后才能设置
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //4 开始扫描
    [self.session startRunning];
    
}

#pragma mark --管理员验票
- (void)checkTicktActivityID:(NSString *)activityId userId:(NSString *)userId squece:(NSString *)sequece yzm:(NSString *)yzm {
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    
    [[JXNetRequest shareInstance] checkTitickWithAdminActivityId:activityId withUserId:userId withSequece:sequece withYzm:yzm withUUID:UUIDAPP Successful:^(id result) {
        
        [MBProgressHUD showSuccess:[result objectForKey:@"message"] ToView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //点击alert，开始扫描
            [self.session startRunning];
            //开启定时器
            [_timer setFireDate:[NSDate distantPast]];
        });

        
        
        
    } forFail:^(NSError *error) {
        
    }];
}

#pragma mark --用户扫描二维码加分
- (void)scanQRCodeAction:(NSString *)qrId withSorce:(NSString *)score {
    [[JXNetRequest shareInstance] scanActionWithAdminUuid:UUIDAPP withScore:score withFlag:@"0" withQRCodeId:qrId Successful:^(id result) {
        
        if ([result[@"code"] isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:[NSString stringWithFormat:@"您已获得%@积分",score] ToView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
                DFScoreViewController *revise =[[DFScoreViewController alloc] init];
                revise.flag = YES;
                [self presentViewController:revise animated:YES completion:^{
                    
                }];
            });
        }else {
            [MBProgressHUD showInfo:result[@"message"] ToView:self.view];
        }
        
        
    } forFail:^(NSError *error) {
        
    }];
    
    
}

- (UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

//递归
- (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}


#pragma mark --管理员扫描二维码加分和扣分
- (void)showAlertViewWithMessage:(NSString *)message withToken:(NSString *)uuid withFlag:(NSString *)flag
{
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"扫描结果" message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击alert，开始扫描
        [self.session startRunning];
        //开启定时器
        [_timer setFireDate:[NSDate distantPast]];
        
        [[JXNetRequest shareInstance] scoreFunWithAdminUuid:uuid withPeopleUuid:UUIDAPP withScore:[[alertVc textFields] objectAtIndex:0].text withFlag:flag withActivityId:@"" Successful:^(id result) {
            
            [MBProgressHUD showSuccess:[result objectForKey:@"message"] ToView:self.view];
            
        } forFail:^(NSError *error) {
            
        }];
    
    
//        NSLog(@"%@, %@", token,[[alertVc textFields] objectAtIndex:0].text);
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击alert，开始扫描
        [self.session startRunning];
        //开启定时器
        [_timer setFireDate:[NSDate distantPast]];
    }];
    
    
    // 添加行为
    [alertVc addAction:action2];
    [alertVc addAction:action1];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

//打开系统相册
- (void)chooseButtonClick
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //关闭扫描
        [self stopScan];
        
        //1 弹出系统相册
        UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
        //2 设置照片来源
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //3 设置代理
        pickVC.delegate = self;
        //4.转场动画
        self.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:pickVC animated:YES completion:nil];
    }
    else
    {
        [self showAlertViewWithTitle:@"打开失败" withMessage:@"相册打开失败。设备不支持访问相册，请在设置->隐私->照片中进行设置！"];
    }
    
}
//从相册中选取照片&读取相册二维码信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //1 获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //初始化一个监听器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >= 1) {
            //结果对象
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            [self showAlertViewWithTitle:@"读取相册二维码" withMessage:scannedResult];
        }
        else
        {
            [self showAlertViewWithTitle:@"读取相册二维码" withMessage:@"读取失败"];
        }
    }];
    
}

#pragma mark ===========重启扫描&闪光灯===========
//添加开始扫描按钮
- (void)addStartButton
{
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(60, 420, 80, 40);
    startButton.backgroundColor = [UIColor orangeColor];
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"扫描" forState:UIControlStateNormal];
    [self.view addSubview:startButton];
}
- (void)startButtonClick
{
    //清除imageView上的图片
    self.imageView.image = [UIImage imageNamed:@""];
    //开始扫描
    [self starScan];
    
}


- (void)systemLightSwitch:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma mark ===========添加提示框===========
//提示框alert
- (void)showAlertViewWithTitle:(NSString *)aTitle withMessage:(NSString *)aMessage
{
    
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:aTitle message:[NSString stringWithFormat:@"%@",aMessage] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"tishi" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击alert，开始扫描
        [self.session startRunning];
        //开启定时器
        [_timer setFireDate:[NSDate distantPast]];
    }]];
    [self presentViewController:alert animated:true completion:^{
        
    }];
    
}


#pragma mark ===========扫描的代理方法===========
//得到扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            NSString *stringValue = [metadataObject stringValue];
            if (stringValue != nil) {
                [self.session stopRunning];
                // 1.解码
                //QVBQS1BIVF8xIzIjNTUjOTk0NDkxIzY5NTkxNA==
                
                NSString *edsStr = [MyBase64 textFromBase64String:stringValue];
                // 2.获取字符串最后一位判断是添加积分 还是 扣除积分
                NSArray *words = [edsStr componentsSeparatedByString:@"#"];
                if (words.count == 3) {
                    NSString *center = words[1];
                    NSString *theLast = words[2];
                    NSString *theFirst = words[0];
                    if ([theLast isEqualToString:@"0"] && [theFirst isEqualToString:@"APPKPHT_2"]) { //管理员扫描用户二维码添加积分
                        [self showAlertViewWithMessage:@"添加积分" withToken:center withFlag:@"0"];
                    }else if ([theLast isEqualToString:@"1"] && [theFirst isEqualToString:@"APPKPHT_2"]) { //管理员扫描用户二维码扣除积分
                        [self showAlertViewWithMessage:@"扣除积分" withToken:center withFlag:@"1"];
                    }else if (![self isBlankString:theLast] && ![self isBlankString:center] && [theFirst isEqualToString:@"APPKPHT_3"]) { //主动扫码
                        [self scanQRCodeAction:center withSorce:theLast];
                    }
                }else if (words.count == 5) {  //活动验票
                    NSString *activityId = words[1];
                    NSString *userId = words[2];
                    NSString *path = words[0];
                    NSString *squce = words[3];
                    NSString *yzm = words[4];
                    if ([path isEqualToString:@"APPKPHT_1"] && ![self isBlankString:activityId] && ![self isBlankString:userId] && ![self isBlankString:squce] && ![self isBlankString:yzm]) {
                        [self checkTicktActivityID:activityId userId:userId squece:squce yzm:yzm];
                    }
                }else  {
                    DFScanResultViewController *vc = [[DFScanResultViewController alloc] init];
                    vc.backBlock = ^{
                        //点击alert，开始扫描
                        [self.session startRunning];
                        //开启定时器
                        [_timer setFireDate:[NSDate distantPast]];
                    };
                    vc.resultString = stringValue;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
        
    }
}


#pragma mark ============添加模糊效果============
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(_imageView.frame);
    CGFloat y = CGRectGetMinY(_imageView.frame);
    CGFloat w = CGRectGetWidth(_imageView.frame);
    CGFloat h = CGRectGetHeight(_imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.5;
    UIColor *backColor = [UIColor blackColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}

#pragma mark ============添加扫描效果============

- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
}
//控制扫描线上下滚动
- (void)timerMethod
{
    if (upOrDown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5+num, CGRectGetWidth(_imageView.frame)-10, 3);
        if (num == (int)(CGRectGetHeight(_imageView.frame)-10)) {
            upOrDown = YES;
        }
    }
    else
    {
        num --;
        _line.frame = CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5+num, CGRectGetWidth(_imageView.frame)-10, 3);
        if (num == 0) {
            upOrDown = NO;
        }
    }
}
//暂定扫描
- (void)stopScan
{
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    //隐藏扫描线
    _line.hidden = YES;
}
- (void)starScan
{
    //开始扫描
    [self.session startRunning];
    //打开定时器
    [_timer setFireDate:[NSDate distantPast]];
    //显示扫描线
    _line.hidden = NO;
}


- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)set_leftBarButtonItemWithImage {
    return [UIImage imageNamed:@"nav_icon_back"];
}


@end












