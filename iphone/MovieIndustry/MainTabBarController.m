//
//  MainTabBarController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MainTabBarController.h"
#import "HHIndexViewController.h"
#import "HHOrderViewController.h"
#import "HHDiscoverController.h"
#import "HHMeViewController.h"
#import "LoginInController.h"
//这是银联支付要导入的头文件
#import "UPPaymentControl.h"
//这是微信支付需要导入的头文件
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义Tabbar
        HHIndexViewController *indexVc = [[HHIndexViewController alloc] init];

    indexVc.tabBarItem.title = @"首页";
    indexVc.tabBarItem.image = [[UIImage imageNamed:@"index_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    indexVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"index_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    indexVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:indexVc];
    
    HHOrderViewController *orderVc = [[HHOrderViewController alloc] init];
    orderVc.tabBarItem.title = @"订单";
    orderVc.tabBarItem.image = [[UIImage imageNamed:@"order_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"order_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:orderVc];
    
    HHDiscoverController *discoverVc = [[HHDiscoverController alloc] init];
    discoverVc.tabBarItem.title = @"发现";
    discoverVc.tabBarItem.image = [[UIImage imageNamed:@"discover_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:discoverVc];
    
    
    HHMeViewController *meVc = [[HHMeViewController alloc] init];
    meVc.tabBarItem.title = @"我的";
    meVc.tabBarItem.image = [[UIImage imageNamed:@"me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:meVc];
    
    
    ////设置了avigationbar 会使self.automaticallyAdjustsScrollViewInsets = NO失效
    nc1.navigationBar.barTintColor=kNavBarColor;
    nc1.navigationBar.translucent=NO;
    nc2.navigationBar.barTintColor=kNavBarColor;
    nc2.navigationBar.translucent=NO;
    nc3.navigationBar.barTintColor=kNavBarColor;
    nc3.navigationBar.translucent=NO;
    nc4.navigationBar.barTintColor=kNavBarColor;
    nc4.navigationBar.translucent=NO;
    //设置控制器
    NSMutableArray *array = [NSMutableArray arrayWithObjects:nc1,nc2,nc3,nc4, nil];
    self.viewControllers = array;
    
    //设置字体样式
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:12] ,NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    //设置字体靠近图片
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    self.navigationController.navigationBar.barTintColor=kNavBarColor;
    self.navigationController.navigationBar.translucent=NO;
    
    [self.tabBar setBackgroundImage:[self createImageWithColor:kNavBarColor]];
    [self.tabBar setTintColor:kNavBarColor];
    self.tabBar.translucent = NO;
    
#warning 银联支付方法调用  需要订单id
#warning 银联支付方法调用  需要订单id
#warning 银联支付方法调用  需要订单id
    
    //在要调起的位置 执行如下语句即可   over
//    [[UPPaymentControl defaultControl] startPay:@"201603011229196401538"fromScheme:@"UPPayDemo" mode:@"00" viewController:self];
    //微信接入
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self WXpayDemo:@"201601191229196401538"];
    });
}

- (void)WXpayDemo:(NSString *)orderid{
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:@"wxd8f37269581ddec2" mch_id:@"1300124601"];
    //设置密钥
    [req setKey:@"SDL94P6OUQ1I6A82ED4TP7APCKOF53SQ"];
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demoWith:@"dd" withOrderId:orderid withPrise:@"1"];
    if(dict == nil) {
        //错误提示
    } else {
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = [dict[@"timestamp"] intValue];
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        if (![WXApi isWXAppInstalled]) {
            NSLog(@"没有安装微信");
        }
        [WXApi sendReq:req];
        [WXApi openWXApp];
    }
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (!APP_DELEGATE.user_id) {
        
        if ([item.title isEqualToString:@"订单"]||[item.title isEqualToString:@"我的"])
        {
            LoginInController *loginVc = [[LoginInController alloc] init];
            UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self presentViewController:navC animated:YES completion:nil];
            
        }
        
    }
}


- (void)setCurrentSelectedIndex:(NSUInteger )index
{
    self.selectedIndex = index;
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
