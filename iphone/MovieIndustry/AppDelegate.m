//
//  AppDelegate.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginInController.h"
#import "MainTabBarController.h"
#import "HHLocationService.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "MovieRefundMoneyViewController.h"
//微信支付
#import "WXApi.h"
#import "WeiboSDK.h"
//银联支付。
#import "UPPaymentControl.h"
//极光推送
#import "APService.h"



@interface AppDelegate ()<WXApiDelegate>
@property (nonatomic,strong)HHLocationService *locationService;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window.backgroundColor = [UIColor whiteColor];
    
    UserLoginModel * model = [UserLoginModel UnarchiverUser];
    if (model) {
        self.user_id = model.user_id;
    }


//    我们也可以使用UIApplication的statusBarStyle方法来设置状态栏，不过，首先需要停止使用View controller-based status bar appearance。在project target的Info tab中，插入一个新的key，名字为View controller-based status bar appearance，并将其值设置为NO。
    ///设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    MainTabBarController *mainTabBar = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTabBar;
    
//    [self loginViewController];
    _locationService = [[HHLocationService alloc] init];
    //开启定位服务
    [_locationService openLocationService];
    
    ///注册分享
    [ShareSDK registerApp:@"1107dba9a7858"];
    //初始化社交平台
    [self initializePlat];
    [WXApi registerApp:@"wxa6cb25669b7a1894"];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    // Required
    //设置别名
//    [APService setAlias:APP_DELEGATE.userLogin.userid
//       callbackSelector:@selector(tagsAliasCallback:tags:alias:)
//                 object:self];
    [APService setupWithOption:launchOptions];
    return YES;
}
//- (void)tagsAliasCallback:(int)iResCode
//                     tags:(NSSet *)tags
//                    alias:(NSString *)alias {
//    NSString *callbackString = [NSString stringWithFormat:@"%d, \n,alias: %@\n", iResCode, alias];
//    
//    //返回iResCode＝0表示成功
//    NSLog(@"TagsAlias回调:%@", callbackString);
//}
- (void)initializePlat
{
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"1984277828"
                               appSecret:@"97b55a27de9db9428731dc46b58f36f8"
                             redirectUri:@"http://www.comefilm.com"
                             weiboSDKCls:[WeiboSDK class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    //    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wxa6cb25669b7a1894"
                           appSecret:@"d4624c36b6795d1d99dcf0547af5443d"
                           wechatCls:[WXApi class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    [ShareSDK connectQQWithQZoneAppKey:@"1105026292"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
}



- (void)loginViewController
{
    LoginInController *loginVc = [[LoginInController alloc] init];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    self.window.rootViewController = loginNav;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //第一次打开或者从后台进入前端的时候启动
    
    //     Object_User * objectUser = [NSKeyedUnarchiver unarchiveObjectWithFile:LoginPath];
    //    APP_DELEGATE.userLogin = objectUser;
    //    if (objectUser) {
    //
    //    }
    //
#warning
    /*
     这里需要调用  接口去刷新 推送数据  拿到某一个用户的userid 然后拿到每个图标上面的数字，并将TA展示出。
     同一个接口，去刷新界面上面的图标。 这种情况下，应用内并不能收到推送的通知，无法解析。
     调用接口后，再进行回掉，将数据库中的记录清空
     这样推送功能 就差不多。
     */
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [APService setBadge:0];
    [APService resetBadge];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


//上面支付时已经传给了支付宝客户端回调shema名称
//NSString *appScheme = URLScheme;
//具体设置shema方法此处就不再累赘，这儿需要处理来自支付宝shema回调，才能完成上面方法的block回调
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    //跳转支付宝钱包进行支付，处理支付结果
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
            
        }];
        //这边是微信支付
    }else if([url.host isEqualToString:@"pay"]){
        
       [WXApi handleOpenURL:url delegate:self];
        //银联支付
    }else {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"code"] = code;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"银联支付结果" object:nil userInfo:dict];
        }];
    }
    return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    return YES;
}

//SSO授权回调 检查是否已加入handleOpenURL的处理方法
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                            wxDelegate:self];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    NSLog(@"%@",deviceToken);
    [APService registerDeviceToken:deviceToken];
    NSSet * set = [NSSet setWithObjects:@"a", nil];
    [APService setTags:set alias:@"M0000000000065" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias{
    NSLog(@"设置别名回调__%d%@%@",iResCode,tags,alias);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"收到消息" object:nil userInfo:userInfo];
    //    [rootViewController addNotificationCount];
    
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//调起微信支付
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"微信支付成功" object:nil];
            }
                break;
                
            case WXErrCodeCommon:{

            }
                break;
                
            case WXErrCodeUserCancel:{
 
            }
                break;
                
            default:
                break;
        }
    }
}



+ (void)wxPay{
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"url:%@",urlString);
        NSMutableString *retcode = [dict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = [stamp intValue];
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            BOOL isSure = [WXApi sendReq:req];
            if (isSure) {
                NSLog(@"okOKO");
            }else{
                NSLog(@"nono");
            }
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        }
    }
}




@end
