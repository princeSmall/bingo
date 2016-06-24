//
//  MovieHttpRequest.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/24.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Callback)(id obj);
typedef void (^Callbacks)(id obj,id obj1);

@interface MovieHttpRequest : NSObject


/** 
 *      我的界面用户信息
 *      user_id 用户id
 */
+ (void)createMineInfoRequestCallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *      修改我的用户信息
 *      user_id      用户id
 *      icon_img     头像地址
 *      nikename     昵称
 *      sex          性别(-1未知;0女;1,男)
 *      my_address   我的地址
 *      profession   职业身份
 *      come_from    来自
 */
+ (void)createModifyMineInfoWithInfoDict:(NSDictionary *)infoDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *      发布产品
 *      user_id       用户id
 *      deal_id       添加图片返回的id(没有为空)
 *      name          商品名称
 *      origin_price  价格
 *      current_price 咔么价
 *      city_id       城市id
 *      delivery_id   送货id(1商家2顺丰3申通)
 *      is_deposit    是否押金
 *      description描述
 */
+ (void)createPublishMineProductWithGoodsInfo:(NSDictionary *)goodsDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;



/**
 *      开通我的店铺
 *      name            店铺名
 *      user_id         用户id
 *      brief           店铺介绍
 *      address         店铺详细地址
 *      city_id         城市地址
 *      tel电话
 *      contact         联系人
 *      店铺分类         (is_shop发布商品:1是0否 is_space发布场地1是0否 is_staff发布人员1是0否)
 */
+ (void)createOpenMineStoreWithInfo:(NSDictionary *)storeDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  闪电租界面数据 价格列表,分类列表
 */
+ (void)createLightingRentViewDatasCallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  发布闪电租需求
 *  user_id         用户id
 *  keyword         关键词
 *  city_id         城市id
 *  cate_id         类型id
 *  price_id        价格id
 *  time_str        时间字符串
 *  remark          备注
 */
+ (void)createMakeMineLightingRentWithRequestInfo:(NSDictionary *)requestDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/*
 *  店铺设置显示
 */
+ (void)createSetingStoreViewDataCallBack:(Callback)callback andSCallBack:(Callback)scallback;


/*
 *  确认并提交店铺设置
 */
+ (void)createSettingMineStoreInfomation:(NSDictionary *)storeDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/*
 *  设置店铺logo
 */
+ (void)httpUpdateImageWithImage:(UIImage *) image CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/*
 *  发布人员_职称列表
 */
+ (void)createOccupationListCallBack:(Callback)callback andSCallBack:(Callback)scallback;



/**
 * @Author   KShame
 * @Features 发布人员
 * @Needs    name姓名 user_id用户id deal_id添加图片返回的id(没有为空) mobile_phone联系方式 post_id职称  current_price价格 feature特点  description简介
 * @return   f1 f99 msg
 */
+ (void)createPublishMinePersonnelWith:(NSDictionary *)personDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 * @Author   KShame
 * @Features 发布场地
 * @Needs    user_id用户id deal_id添加图片返回的id(没有为空) name场地名称 mobile_phone联系方式 acreage面积 current_price价格 feature特点 description场地描述
 * @return   f1 f99 msg
 */
+ (void)createPublishMineSiteWith:(NSDictionary *)siteDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  我的店铺 (收入,余额,店铺名,简介)
 */
+ (void)createMineStoreInfomationCallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  发布的需求
 */
+ (void)createMineRequestListWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  发布的需求抢单列表数据
 *  rentId 闪电租Id
 */
+ (void)createMineNeedsRushedListWithPage:(int)page andRentId:(NSString *)rentId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  收到的需求
 */
+ (void)createMineReceivedNeedsWithLocationId:(NSString *)locationId andPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  收到的需求立即抢单
 */
+ (void)createRushMineRecivedNeedsWith:(NSString *)requestId CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  点击收藏的商品
 */
+ (void)createCollectMyFavourableGoodWithGoodId:(NSString *)goodId CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  我收藏的商品列表数据
 */
+ (void)createMineCollectGoodsWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  点击收藏的店铺
 */
+ (void)createCollectMyFavourableStoreWithStoreId:(NSString *)StoreId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  我收藏的店铺列表数据
 */
+ (void)createMineCollectStoreWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/*
 *  商品管理列表数据
 *  page        加载第几页数据
 *  type        is_rent  0:全部 1:已出租
 *  keyword     key      关键字
 */
+ (void)createManagerMyGoodsListWithPage:(int)page andType:(NSString *)type andKeyword:(NSString *)keyword CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *   举报内容列表接口
 */
+ (void)createGetReportReasonsCallBack:(Callback)callback andSCallBack:(Callback)scallback;


/*
 *  确认举报接口
 */
+ (void)createComfirmSendReportWithReportedId:(NSString *)reportedId andContent:(NSString *)content CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  交易记录口
 */
+ (void)createTradeRecordListWithPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  发现页面展览文章数据
 */
+ (void)createDiscoverViewDisplayArticleCallBack:(Callback)callback andSCallBack:(Callback)scallback;

/*
 *  发现页面文章列表数据
 */
+ (void)createDiscoverArticleListWithPage:(int)page andKeyword:(NSString *)keyword CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  相关的文章
 */
+ (void)createRelatedArticlesWithArtile:(NSString *)articleId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  文章详情
 */
+ (void)createArticleDetailWithArticleId:(NSString *)articleId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  文章评论列表
 */
+ (void)createArticleCommentListWithArticleId:(NSString *)articleId andPage:(int)page CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  添加对文章评论接口
 */
+ (void)createAddArticleCommentWithInfoDict:(NSDictionary *)commentDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  添加对评论点赞接口
 */
+ (void)createAddMineBlessWithCommentId:(NSString *)commentId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  送货方式
 */
+ (void)createRequestDeliveyWayCallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  周二抢页面数据
 */
+ (void)createTuesdayGoodSellActivityCallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  周二抢历史抢购记录列表
 */
+ (void)createTuesdayActivityHistoryListWithGoodId:(NSString *)goodId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  专场商品
 */
+ (void)createSpecialGoodsShowCallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  帮助列表
 */
+ (void)createHelpNormalQuestionlistWithPage:(int)page andKeyword:(NSString *)keyword CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  物流详情
 */
+ (void)createCheckDeliveyDetailWithOrderId:(NSString *)orderId CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  确认收货
 */
+ (void)createComfirmReceiveMineOrderWithOrderNum:(NSString *)ordernum CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  取消订单 Shop_order_cancel
 */
+ (void)createConfirmCancelMineOrderWithOrdernum:(NSString *)ordernum CallBack:(Callback)callback andSCallBack:(Callback)scallback;



/**
 *  删除订单  Delete_Order_Url
 */
+ (void)createDelecteMineOrderWithOrderId:(NSString *)orderId CallBack:(Callback)callback andSCallBack:(Callback)scallback;



/**
 *  周二抢评论接口
 */
+ (void)createTuesdaySendCommentWithCommentDict:(NSDictionary *)commentDict CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  周二抢评论列表接口
 */
+ (void)createTuesdayCommentListDatasWithPage:(int)page andGoodId:(NSString *)goodId CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  周二抢评论点赞接口
 */
+ (void)createActiveBlessWithCommentId:(NSString *)commentId CallBack:(Callback)callback andSCallBack:(Callback)scallback;

/**
 *  确认归还接口 GoodManager_Returen
 */
+ (void)createGoodManagerConfirmReturenWithTradeId:(NSString *)tradeId AndOrderID:(NSString *)order_id CallBack:(Callback)callback andSCallBack:(Callback)scallback;


/**
 *  我的积分记录列表 MinePoint_Record
 */
+ (void)createMinePointRecordCallBack:(Callback)callback andSCallBack:(Callback)scallback;



/**
 *  我的收入明细列表 MineIncome_Details
 *  timeStatue    tai  时间状态 1:昨天  2:本周  3:上月  4:全部
 *  incomeStatue  pan 1:收入  2:提现
 */
+ (void)createMineIncomeDetailWithTime:(NSString *)timeStatue andSegmentStatue:(NSString *)incomeStatue CallBack:(Callback)callback andSCallBack:(Callback)scallback;



+ (AFHTTPRequestOperationManager *)postImageRequest:(NSString *)URLString UIImagePhotos:(NSArray*)photos withfileInputs:(NSArray *) fileInputs
                                         parameters:(NSMutableDictionary *)parameters CallBack:(Callback)callback andSCallBack:(Callback)scallback;

@end
