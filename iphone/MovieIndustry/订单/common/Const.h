//
//  Const.h
//  Delivery_iOS
//
//  Created by 猫爷MACIO on 15/10/19.
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

#define BGColor RGBColor(241,241,241, 1)
#define DefaultFont [UIFont systemFontOfSize:16.0f]

#define Network_Error   @"我无法与服务器取得联系,请检查网络..."
#define RequestSuccess  @"success"

#define AccountLogined  @"您的账号在其他地方登陆..."

/** 百度地图key */
#define BAIDU_MAP_KEY   @"oeuYqrQzwZGaWPPo7fXdZokV"

/** 百度云推送key */
#define BAIDU_PUSH_KEY  @"Ofz3XKRgmHgXi5T2gt162dBm"

/** 正式服务器地址 */
#define URL_PREFIX @"http://www.uj345.com/"

/** 测试服务器地址 */
//#define URL_PREFIX @"http://192.168.1.190:8080/"

/** 图片地址 */
#define IMAGE_PREFIX @"http://www.uj345.com/shunroad/"

#define AREA_NOTI  @"refrshArea"
#define CITY_NOT   @"cityName"


#define appVersion   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]//手机端app版本号

#define curAppId  @"787064311"


/** ===============  接口地址  ================*/

/**登陆/注册 */
#define serviceLogin @"shunroad/sload/su_login.shun"

/**获取验证码 */
#define serviceGetVerifyCode @"shunroad/sload/su_code.shun"

/**地图首页数据 */
#define serviceHomepageMapViewData @"shunroad/sload/su_login2.shun"


/** 收件人/寄件人列表 */
#define serviceMyLinkersInfo @"shunroad/sload/su_listcontact.shun"

/** 添加收件人/寄件人 */
#define serviceAddNewLinkmanInfo @"shunroad/sload/su_addcontact.shun"

/** 修改收件人/寄件人 */
#define serviceModifyLinkmanInfo @"shunroad/sload/su_upaddcontact.shun"

/** 快递公司列表 */
#define serviceCourierCompanyList @"shunroad/sload/su_companylist.shun"

/** 我的订单列表 */
#define serviceMineOrderlist @"shunroad/sload/su_orderPager.shun"

/** 发布寄快递任务 */
#define serviceCreateNewDelivery @"shunroad/sload/su_releaseadd.shun"

/** 我的钱包 */
#define serviceMineWalletInfo @"shunroad/sload/su_mymoney.shun"

/** 订单详情 */
#define serviceOrderDetails  @"shunroad/sload/su_loaduorderaction.shun"

/** 个人中心 */
#define servicePersonalCenter @"shunroad/sload/su_listuserdetalts.shun"

/** 取消寄件 */
#define serviceCancelMyOrder @"shunroad/sload/su_delelereorder.shun"

/** 上传图片 */
#define  serviceUploadImages  @"shunroad/sload/sf_updateimage.shun"

/** 首页数据源 */
#define serviceHomepageDataSource @"shunroad/sload/su_alluser.shun"

/** 修改个人用户信息 */
#define serviceModifyPersonInfo @"shunroad/sload/su_updateuser.shun"

/** 接单提示(从信息界面回主界面) */
#define serviceMyOrderCourierInfo @"shunroad/sload/su_putorderPrompt.shun"

/** 信心界面数据*/
#define serviceMessagaeInfomation @"shunroad/sload/su_promptList.shun"

/** 评价快递员*/
#define serivceJudgeMineCourier @""

/** 首页更新经纬度 */
#define serviceHomepageUpdateLocation @"shunroad/sload/su_updajinwei.shun"

/** 移动经纬度,获取快递员信息 */
#define serviceMoveLocationGetCourier @"shunroad/sload/su_listalluser2.shun"

/** 查件历史记录 */
#define serviceDeliveryHistoryInfo @"shunroad/sload/su_billnumber.shun"

/** 查件最终结果 */
#define serviceCheckDeliveryInfoResult @"shunroad/sload/su_juheDemo.shun"


/** 评价显示快递员信息 */
#define serviceDisplayJudgeCourier @"shunroad/sload/su_taskorderaction2.shun"

/** 提交对快递员的评价 */
#define servicePostCourierJudgement @"shunroad/sload/su_pingjia.shun"


/** 重新发单 */
#define serviceSendMineCanceledOrder @"shunroad/sload/su_redustorder.shun"


/** 充值生成订单 */
#define servicePayProductOrder @"shunroad/sload/su_orderup.shun"

/** 支付费用界面数据 */
#define servicePaymentDeliveryInfo @"shunroad/sload/su_paymentinterface.shun"

/** 支付订单费用 */
#define servicePaymentDeliveryFeeRequest @"shunroad/sload/su_putmoney.shun"


/** 地址查询 */
#define serviceSearchMineLocation @"shunroad/sload/su_getsh_region.shun"


/** HTML数据 */
#define serviceHtmlDats @"shunroad/sload/su_postdoucument.shun"


/** 意见与反馈 */
#define servicePostMineRecommend @"shunroad/sload/su_feedbackadd.shun"


/** 设置支付密码 */
#define serviceSetPayPassword @"shunroad/sload/su_updatepassword.shun"


/** 设置勿扰模式状态 */
#define serviceSetBotherStatues @"shunroad/sload/su_opennotdisturb.shun"


#define serviceSetBequietStatues @"shunroad/sload/su_opennotMute.shun"

/** 设置channelid */
#define serviceLoginChannelId @"shunroad/sload/su_addupbaidu.shun"


/** 删除寄件人/收件人地址 */
#define serviceDelecteLinkmanInfo @"shunroad/sload/su_deletecontact.shun"


/** 快递员详情 */
#define serviceCourierInfoDetail @"shunroad/sload/su_discountlist.shun"



#endif












