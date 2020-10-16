//
//  ThirdMacros.h
//  VegetablePlot
//
//  Created by Arthur on 2017/6/8.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

//网路请求地址
//// 正式地址
#define H5BASE_URL @"http://m.spacemore.com.cn:9202/jeecms7/"
#define BASE_URL @"http://m.spacemore.com.cn:9202/jeecms7/app/"

//// 测试地址
//#define BASE_URL @"http://192.168.90.70:9202/jeecms7/app/"
//#define H5BASE_URL @"http://192.168.90.70:9202/jeecms7/"

//友盟分享SDK的key
#define USHARE_DEMO_APPKEY @"5c18512cf1f5567ebd000ad1"

//融云即时通讯SDK的KEY
#define RONG_Cloud_APPKEY @"4z3hlwrv3n46t"

//--微信分享
#define kSocial_WX_Key @"wx33bc520f82568346"
#define kSocial_WX_Secret @"c99b1cbaccc3411e7d764a031f156029"

//--QQ分享
#define kSocial_QQ_Key @"101540059"
#define kSocial_QQ_Secret @"fa16b07dddcaf02721274ae0f02309d8"

//--新浪微博分享
#define kSocial_Sina_Key @"2253009003"
#define kSocial_Sina_Secret @"11fded89781f446ae875037aaf67d7c0"

//极光推送
#if DEBUG
//开发
#define kJPush_appkey @"e4f8a10813d524c97dc1a172"
#define kJPush_channel @"dev_channel"
#define kUmengKey @"586f678cf29d98487e001443"

#else
//生产
#define kJPush_appkey @"e4f8a10813d524c97dc1a172"
#define kJPush_channel @"appstore_channel"
#define kUmengKey @"586f66daae1bf84b2d0015d6"

#endif




#endif /* ThirdMacros_h */
