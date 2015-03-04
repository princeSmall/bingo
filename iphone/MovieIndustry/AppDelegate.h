//
//  AppDelegate.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (void)wxPay;

@property (nonatomic,strong) NSString * user_id;
//收货地址单类
@property (nonatomic,strong) NSString * addressPalce;

@end

