//
//  Const.h
//  Delivery_iOS
//
//  Created by 童乐 on 15/10/19.
//  Copyright (c) 2015年 yuejue. All rights reserved.
//

#ifndef Delivery_iOS_Const_h
#define Delivery_iOS_Const_h


#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define screenWidth  [[UIScreen mainScreen] bounds].size.width

#define isScreen3_5 ([[UIScreen mainScreen] bounds].size.height == 480 ? YES : NO)   //是否为3.5寸屏
#define isScreen4 ([[UIScreen mainScreen] bounds].size.height == 568 ? YES : NO)   //是否为4寸屏
#define isiPhone6 ([[UIScreen mainScreen] bounds].size.height == 667 ? YES : NO)   //是否为iPhone6

#define isiOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)    //是否高于iOS7
#define isiOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)    //是否高于iOS7

#define APPLICATION_WINDOW [[[UIApplication sharedApplication] delegate] window]

#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define BGColor RGBColor(236,236,243, 1)
#define DefaultFont [UIFont systemFontOfSize:16.0f]

#define Network_Error   @"我无法与服务器取得联系,请检查网络..."
#define RequestSuccess  @"success"

#define AccountLogined  @"您的账号在其他地方登陆..."

/** 正式服务器地址 */
#define URL_PREFIX @"http://kamefilm.uj345.net/"

/** 测试服务器地址 */
//#define URL_PREFIX @"http://192.168.1.190:8080/"

/** 图片地址 */
#define IMAGE_PREFIX @"http://kamefilm.uj345.net"


#define appVersion   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]//手机端app版本号



/** ===============  接口地址  ================*/

#define serviceMineInfo @""



#endif












