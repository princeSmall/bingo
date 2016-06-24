//
//  AppDelegate.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerShippingAddressController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (void)wxPay;

@property (nonatomic,strong) NSString * user_id;
//收货地址单类
@property (nonatomic,strong) NSString * addressPalce;

@property (nonatomic,strong) UITabBarController *tbbC;
//订单id号
@property (nonatomic,strong)NSString * orderid;
@property (nonatomic,strong)UIViewController * ShowViewController;

//选择收货地址页面标记
@property (nonatomic,strong)ManagerShippingAddressController *managerShip;

@end

