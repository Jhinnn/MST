//
//  Macros.h
//  VegetablePlot
//
//  Created by Arthur on 2017/6/6.
//  Copyright © 2017年 Arthur. All rights reserved.
//

// MainScreen Height&Width&Bounds
#define kScreenH      [[UIScreen mainScreen] bounds].size.height
#define kScreenW       [[UIScreen mainScreen] bounds].size.width


// 判断是否是iPhone X

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define SafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)//底部安全区域的高度


// 字体大小(常规/粗体)
#define BOLDFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)     [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//userdefaultes
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

//圆角-视图/角度/宽度/颜色
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]] // view圆角

// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]

// 按照效果图适应比例 iphone6尺寸
#define AutoWith(x) (x/375.0*[UIScreen mainScreen].bounds.size.width)
#define AutoHeight(x) (x/667.0*[UIScreen mainScreen].bounds.size.height)


#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]


//线的颜色
#define kLineColor HEXCOLOR(0xe5e5e5)

#define ATLINECOLOR [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1]


#define NOTIF_ADD(n, f)     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
#define NOTIF_POST(n, o)    [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
#define NOTIF_REMV()        [[NSNotificationCenter defaultCenter] removeObserver:self]

/// 弱引用
#define dfWeakObj(o) __weak typeof(o) o##Weak = o;

//App版本号
#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]

//获取图片资源
#define IMG_NAME(name)  [UIImage imageNamed:[NSString stringWithFormat:@"%@", name]]

#define UIColorFromString(string) [UIColor colorWithString:string]

//全局主色调 背景
#define ThemeColor RGB(42, 132, 233)



