//
//  FilmInterface.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#ifndef MovieIndustry_FilmInterface_h
#define MovieIndustry_FilmInterface_h


#define PREFIX @"http://kamefilm.uj345.net/"
///没有反斜杠 某些接口下载图片
#define PREFIX2 @"http://kamefilm.uj345.net"
//dian.php/Home/Apigwc/huidiao
///商品详情H5goods_id
#define GoodsDesc [NSString stringWithFormat:@"%@dian.php/Home/Index/Commodity post#",PREFIX]
///购物车列表
#define GoodsCar_URL  [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/list_gwcs",PREFIX]

//http://kamefilm.uj345.net/shop.php?ctl=api_order&act=qing&data=[%2760%27]
////初始化确认订单
#define Shop_Order_Init  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=qing",PREFIX]

// 选择商品颜色等属性http://kamefilm.uj345.net/shop.php?ctl=api_order&act=xuanze&deal_id=66
#define Goods_Attr_Xuanze [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=xuanze",PREFIX]
////回调接口
#define Callback_Interface [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/huidiao",PREFIX]

///加入购物车
#define JoinGoodsCars_URL [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/jiaru",PREFIX]
///删除购物车
#define DeleteGoodsCars_URL [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/gwcshanchu",PREFIX]

///商家详情
#define Shop_Detail_Url  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=shang",PREFIX]

///删除订单
#define Delete_Order_Url  [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/ddshanchu",PREFIX]

//dian.php/Home/Apiding/dingdan
///订单详情
#define Order_Detail_Url  [NSString stringWithFormat:@"%@dian.php/Home/Apiding/dingdan",PREFIX]
///送货方式
#define Shipping_Method_Url  [NSString stringWithFormat:@"%@dian.php/Home/Apiding/song",PREFIX]

//周金林咔么APP接口开发进度追踪表
///登陆短信接口
#define Send_note_login  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=send_note_login",PREFIX]
///登陆接口
#define Register_login  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=register_login",PREFIX]
///更换手机原因分类接口
#define Appeal_mobile_type  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=appeal_mobile_type",PREFIX]
///更换手机号接口
#define Appeal_mobile  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=appeal_mobile",PREFIX]
///首页轮播接口
#define Adv_list  [NSString stringWithFormat:@"%@index.php?ctl=api_index&act=adv_list",PREFIX]
///广告H5详细页
#define Adv_info  [NSString stringWithFormat:@"%@index.php?ctl=api_index&act=adv_info",PREFIX]
///热搜词接口
#define Search_word  [NSString stringWithFormat:@"%@index.php?ctl=api_search&act=search_word",PREFIX]
///帮助列表接口
#define Search_help  [NSString stringWithFormat:@"%@index.php?ctl=api_search&act=search_help",PREFIX]
///帮助H5详细页
#define Help_info  [NSString stringWithFormat:@"%@index.php?ctl=api_search&act=help_info",PREFIX]
///城市列表接口
#define City_list  [NSString stringWithFormat:@"%@index.php?ctl=api_city&act=city_list",PREFIX]
///城市列表搜索接口
#define City_list_search  [NSString stringWithFormat:@"%@index.php?ctl=api_city&act=city_list_search",PREFIX]
///好友列表
#define Api_friend_list  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=api_friend_list",PREFIX]
///添加好友时搜索好友
#define Search_list  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=search_list",PREFIX]
///添加好友
#define Add_friend  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=add_friend",PREFIX]
///修改好友备注
#define Edit_remark  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=edit_remark",PREFIX]
///删除好友
#define Delete_friend  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=delete_friend",PREFIX]
///允许陌生人查看照片
#define Edit_photo  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=edit_photo",PREFIX]
///添加黑名单,不让他看,不看他时用户列表
#define Add_friend_list  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=add_friend_list",PREFIX]
///黑名单列表
#define Blacklist_list  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=blacklist_list",PREFIX]
///添加黑名单
#define Add_blacklist  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=add_blacklist",PREFIX]
///删除黑名单
#define Delete_blacklist  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=delete_blacklist",PREFIX]
///不让他看列表
#define Dynamic_list  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=dynamic_list",PREFIX]
///添加不让他看
#define Add_dynamic  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=add_dynamic",PREFIX]
///删除不让他看
#define Delete_dynamic  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=delete_dynamic",PREFIX]
///不看他列表
#define Dynamic_list_two  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=dynamic_list_two",PREFIX]
///添加不看他
#define Add_dynamic_two  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=add_dynamic_two",PREFIX]
///删除不看他
#define Delete_dynamic_two  [NSString stringWithFormat:@"%@index.php?ctl=api_privacy&act=delete_dynamic_two",PREFIX]
///ios版本接口
#define IOS_Versions  [NSString stringWithFormat:@"%@index.php?ctl=api_versions&act=ios_versions",PREFIX]
///进入闪电租调用接口
#define Rent_before  [NSString stringWithFormat:@"%@index.php?ctl=api_rent&act=rent_before",PREFIX]
///发布闪电租接口
#define Add_rent  [NSString stringWithFormat:@"%@index.php?ctl=api_rent&act=add_rent",PREFIX]
///获取推送信息接口(每次打开软件后调用)
#define Add_push  [NSString stringWithFormat:@"%@index.php?ctl=api_push&act=add_push",PREFIX]
///收到的需求列表接口
#define Receive_list  [NSString stringWithFormat:@"%@index.php?ctl=api_rent&act=receive_list",PREFIX]
///抢单接口
#define Edit_rent  [NSString stringWithFormat:@"%@index.php?ctl=api_rent&act=edit_rent",PREFIX]
///发布的需求列表接口
#define Issue_list  [NSString stringWithFormat:@"%@index.php?ctl=api_rent&act=issue_list",PREFIX]
///发布的需求抢单列表接口
#define Issue_list_in  [NSString stringWithFormat:@"%@index.php?ctl=api_rent&act=issue_list_in",PREFIX]
///首页文章列表接口
#define Article_list  [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=article_list",PREFIX]

///文章详细页接口
#define Article_info  [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=article_info",PREFIX]
///文章评论列表接口
#define Comment_list  [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=comment_list",PREFIX]
///添加文章评论接口
#define Add_article_comment  [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=add_article_comment",PREFIX]
///展览文章列表接口
#define Exhibition_article_list  [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=exhibition_article_list",PREFIX]
///发现文章列表接口
#define Discover_article_list  [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=discover_article_list",PREFIX]
///添加商户收藏接口
#define Add_location_collect [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=add_location_collect",PREFIX]
///添加商品收藏接口
#define Add_deal_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=add_deal_collect",PREFIX]
///添加帖子收藏接口
#define Add_post_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=add_post_collect",PREFIX]
///添加课程收藏接口
#define Add_course_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=add_course_collect",PREFIX]
///删除商户收藏接口
#define Delete_location_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=delete_location_collect",PREFIX]
///删除商品收藏接口
#define Delete_deal_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=delete_deal_collect",PREFIX]
///删除帖子收藏接口
#define Delete_post_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=delete_post_collect",PREFIX]
///删除课程收藏接口
#define Delete_course_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=delete_course_collect",PREFIX]
///商户收藏列表接口
#define List_location_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=list_location_collect",PREFIX]
///商品收藏列表接口
#define List_deal_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=list_deal_collect",PREFIX]
///帖子收藏列表接口
#define List_post_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=list_post_collect",PREFIX]
///课程收藏列表接口
#define List_course_collect  [NSString stringWithFormat:@"%@index.php?ctl=api_collect&act=list_course_collect",PREFIX]
///消息列表接口
#define Msg_list  [NSString stringWithFormat:@"%@index.php?ctl=api_msg&act=msg_list",PREFIX]
///未读消息数接口
#define Msg_count  [NSString stringWithFormat:@"%@index.php?ctl=api_msg&act=msg_count",PREFIX]
///查看其它用户信息相册接口
#define Friend_info  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=friend_info",PREFIX]
///图片上传接口
#define Image_upload  [NSString stringWithFormat:@"%@index.php?ctl=api_common&act=image_upload",PREFIX]
///上传图片数量读取接口
#define Read_img_num  [NSString stringWithFormat:@"%@index.php?ctl=api_common&act=read_img_num",PREFIX]
///修改用户信息
#define Edit_user_info  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=edit_user_info",PREFIX]
///获取用户信息
#define Gain_user_info  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=gain_user_info",PREFIX]
///获取商户信息
#define Gain_location_info  [NSString stringWithFormat:@"%@index.php?ctl=api_user&act=gain_location_info",PREFIX]
///收入明细列表接口
#define Money_logo_list  [NSString stringWithFormat:@"%@index.php?ctl=api_money&act=money_logo_list",PREFIX]
///提现之前调用接口
#define Account_info  [NSString stringWithFormat:@"%@index.php?ctl=api_money&act=account_info",PREFIX]
///提现申请接口
#define Add_withdraw  [NSString stringWithFormat:@"%@index.php?ctl=api_money&act=add_withdraw",PREFIX]
///提现明细列表接口
#define List_withdraw  [NSString stringWithFormat:@"%@index.php?ctl=api_money&act=list_withdraw",PREFIX]
///举报内容列表接口
#define Report_list  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=report_list",PREFIX]
///举报接口
#define Report_add  [NSString stringWithFormat:@"%@index.php?ctl=api_friend&act=report_add",PREFIX]


#pragma mark - 李沅龙咔么APP接口开发进度追踪表10.30
//开通店铺
#define Shop_register  [NSString stringWithFormat:@"%@shop.php?ctl=api_register&act=register",PREFIX]
///开通/设置_店铺logo
//#define Shop_preview  [NSString stringWithFormat:@"%@shop.php?ctl=api_register&act=preview",PREFIX]


#define Shop_preview  [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/shangchun",PREFIX]

///店铺设置显示
#define Shop_location_info  [NSString stringWithFormat:@"%@shop.php?ctl=api_register&act=location_info",PREFIX]
///我的店铺(收入)
#define Shop_my_location  [NSString stringWithFormat:@"%@shop.php?ctl=api_register&act=my_location",PREFIX]
///店铺设置
#define Shop_location_set  [NSString stringWithFormat:@"%@shop.php?ctl=api_register&act=location_set",PREFIX]
///产品发布
#define Shop_deal_add [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=deal_add",PREFIX]
///商品图像上传（编辑）
#define Shop_deal_img  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=deal_img",PREFIX]
///发布人员
#define Shop_staff_add  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=staff_add",PREFIX]
///发布人员_职称列表
#define Shop_post_list  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=post_list",PREFIX]
///发布场地
#define Shop_site_add  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=site_add",PREFIX]
///交易管理
#define Shop_location_order  [NSString stringWithFormat:@"%@shop.php?ctl=api_location&act=location_order",PREFIX]
///发货
#define Shop_carriage [NSString stringWithFormat:@"%@shop.php?ctl=api_location&act=carriage",PREFIX]
///商品管理列表
#define Shop_deal_list  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=deal_list",PREFIX]
///商品修改
#define Shop_deal_edit  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=deal_edit",PREFIX]
///商铺搜索
#define Shop_location_search  [NSString stringWithFormat:@"%@shop.php?ctl=api_location&act=location_search",PREFIX]
///商铺首页
#define Shop_location  [NSString stringWithFormat:@"%@shop.php?ctl=api_location&act=location",PREFIX]
///商铺周边交通
#define Shop_coordinate  [NSString stringWithFormat:@"%@shop.php?ctl=api_location&act=coordinate",PREFIX]
///店铺宝贝分类列表
#define Shop_location_type_list  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=location_type_list",PREFIX]
///商铺内产品列表
#define Shop_location_deallist  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=location_deallist",PREFIX]
///商品详情
#define Shop_deal  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=deal",PREFIX]
///商品评论列表
#define Shop_deal_message  [NSString stringWithFormat:@"%@shop.php?ctl=api_deal&act=deal_message",PREFIX]
///验证商品库存
#define Shop_presence  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=presence",PREFIX]
///添加地址
#define Shop_address_add  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=address_add",PREFIX]
///地址列表
#define Shop_address_list  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=address_list",PREFIX]
///修改地址
#define Shop_address_edit  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=address_edit",PREFIX]
///删除地址/设为默认
#define Shop_address_modify  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=address_modify",PREFIX]
///默认地址
#define Shop_address_moren  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=address_moren",PREFIX]
///设置默认地址
#define Shop_mo  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=mo",PREFIX]

///生成订单
#define Shop_order_add  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=order_add",PREFIX]
///支付前调用验证库存接口
#define Shop_order_pay_before  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=order_pay_before",PREFIX]
///订单列表
#define Shop_order_list  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=order_list",PREFIX]
///首页显示
#define Shop_home_deal  [NSString stringWithFormat:@"%@shop.php?ctl=api_dominate&act=home_deal",PREFIX]
///首页活动页
#define Shop_activity_img  [NSString stringWithFormat:@"%@shop.php?ctl=api_dominate&act=activity_img",PREFIX]
///专场商品
#define Shop_special_deal  [NSString stringWithFormat:@"%@shop.php?ctl=api_dominate&act=special_deal",PREFIX]
///抢购商品
#define Shop_panic_deal  [NSString stringWithFormat:@"%@shop.php?ctl=api_dominate&act=panic_deal",PREFIX]
///商品搜索
#define Shop_search_deal  [NSString stringWithFormat:@"%@shop.php?ctl=api_dominate&act=search_deal",PREFIX]
///取消订单
#define Shop_order_cancel  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=order_cancel",PREFIX]
///退款前调用接口
#define Shop_application_after  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=application_after",PREFIX]
///商品退款
#define Shop_application_refund  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=application_refund",PREFIX]
///确认收货
#define Shop_order_confirm  [NSString stringWithFormat:@"%@shop.php?ctl=api_order&act=order_confirm",PREFIX]
///订单商品评论
#define Shop_message_add  [NSString stringWithFormat:@"%@shop.php?ctl=api_message&act=message_add",PREFIX]

#pragma mark - 王金咔么APP接口开发
//发现>首页搜索
#define Find_searchList  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=searchList",PREFIX]
///发现>免费领取
#define Find_find  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=find",PREFIX]
///免费领取>详情
#define Find_courseEnroll  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=courseEnroll",PREFIX]
///免费领取>报名
#define Find_signUp  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=signUp",PREFIX]
///免费领取>课程评论
#define Find_enrollComment  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=enrollComment",PREFIX]
///免费领取>评论列表
#define Find_commentList  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=commentList",PREFIX]
///免费领取>评论点赞
#define Find_commentPraise  [NSString stringWithFormat:@"%@find.php?ctl=api_find&act=commentPraise",PREFIX]
///电影圈>发布
#define Find_publish  [NSString stringWithFormat:@"%@find.php?ctl=api_moviedom&act=publish",PREFIX]
///电影圈>新消息
#define Find_newMessage  [NSString stringWithFormat:@"%@find.php?ctl=api_moviedom&act=newMessage",PREFIX]
///电影圈>消息列表
#define Find_message_List  [NSString stringWithFormat:@"%@find.php?ctl=api_moviedom&act=message_List",PREFIX]
///电影圈>动态列表
#define Find_dynamicList  [NSString stringWithFormat:@"%@find.php?ctl=api_moviedom&act=dynamicList",PREFIX]
///电影圈>点赞
#define Find_praise  [NSString stringWithFormat:@"%@find.php?ctl=api_moviedom&act=praise",PREFIX]
///电影圈>评论
#define Find_comment  [NSString stringWithFormat:@"%@find.php?ctl=api_moviedom&act=comment",PREFIX]
///精品课程
#define Find_courseList  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=courseList",PREFIX]
///课程详情
#define Find_courseInfo  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=courseInfo",PREFIX]
///课程评论
#define Find_courseComment  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=courseComment",PREFIX]
///评论列表
#define Classroom_commentList  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=commentList",PREFIX]
///评论点赞
#define Classroom_commentPraise  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=commentPraise",PREFIX]
///名师在线
#define Find_masterList  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=masterList",PREFIX]
///名师介绍
#define Find_masterInfo  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=masterInfo",PREFIX]
///关注
#define Find_follow  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=follow",PREFIX]
///取消关注
#define Find_delFollow  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=delFollow",PREFIX]
///名师评论
#define Find_masterComment  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=masterComment",PREFIX]
///名师评论列表
#define Find_masterCommentList  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=masterCommentList",PREFIX]
///评论点赞
#define Find_masterCommentPraise  [NSString stringWithFormat:@"%@find.php?ctl=api_classroom&act=masterCommentPraise",PREFIX]
///论坛首页
#define Find_forumList  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=forumList",PREFIX]
///帖子分类
#define Find_postList  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=postList",PREFIX]
///分类帖子列表
#define Find_categoryPost  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=categoryPost",PREFIX]
///我的帖子
#define Find_myPost  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=myPost",PREFIX]
///我的评价
#define Find_myEvaluate  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=myEvaluate",PREFIX]
///帖子详情
#define Find_postDetails  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=postDetails",PREFIX]
///帖子评论
#define Find_postComment  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=postComment",PREFIX]
///帖子评论列表
#define Forum_commentList  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=commentList",PREFIX]
///帖子评论点赞
#define Forum_commentPraise  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=commentPraise",PREFIX]
///发帖
#define Find_newPost  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=newPost",PREFIX]
///我的消息
#define Find_myInfo  [NSString stringWithFormat:@"%@find.php?ctl=api_forum&act=myInfo",PREFIX]
///产品排行榜
#define Find_productRanking  [NSString stringWithFormat:@"%@find.php?ctl=api_ranking&act=productRanking",PREFIX]
///文章排行榜
#define Find_articleRanking  [NSString stringWithFormat:@"%@find.php?ctl=api_ranking&act=articleRanking",PREFIX]
///帖子排行榜
#define Find_postRanking  [NSString stringWithFormat:@"%@find.php?ctl=api_ranking&act=postRanking",PREFIX]
///课程排行榜
#define Find_courseRanking  [NSString stringWithFormat:@"%@find.php?ctl=api_ranking&act=courseRanking",PREFIX]


#pragma mark - 汤飞鹏
/** 交易记录 */
//#define Trade_Record [NSString stringWithFormat:@"%@index.php?ctl=api_money&act=jiaoyijl",PREFIX]
#define Trade_Record [NSString stringWithFormat:@"%@dian.php/Home/Apiding/jilu",PREFIX]

/** 提醒发货 */
#define Apigwc_tixing_URL [NSString stringWithFormat:@"%@dian.php/Home/Apigwc/tixing",PREFIX]

/** 周二抢历史抢购记录 */
#define TuesdayAc_HistoryList [NSString stringWithFormat:@"%@dian.php/Home/Apiding/qiang",PREFIX]

/** 文章详情H5 */
#define ArtileDetial_HTML [NSString stringWithFormat:@"%@index.php?ctl=api_wenzhang&act=index",PREFIX]

/** 主页展览文章详情接口 */
#define MainPageDisplay_Article [NSString stringWithFormat:@"%@dian.php/Home/Faxian/jingtou",PREFIX]

/** 查看物流详情 */
#define checkDelivey_Detail  [NSString stringWithFormat:@"%@dian.php/Home/Apiding/wuliu",PREFIX]

//文章详情相关文章
#define ArtileDetail_relateA [NSString stringWithFormat:@"%@dian.php/Home/Apiding/guan",PREFIX]


//周二抢评论接口
#define TuesdayActive_comment  [NSString stringWithFormat:@"%@dian.php/Home/Apiding/zuyong",PREFIX]

//周二抢评论列表接口
#define TuesdayCommentList [NSString stringWithFormat:@"%@index.php?ctl=api_article&act=zhouer_content_list",PREFIX]

//周二抢评论点赞接口
#define ActiveComment_Praise [NSString stringWithFormat:@"%@dian.php/Home/Apiding/zan",PREFIX]


//商品管理确认归还接口
#define GoodManager_Returen [NSString stringWithFormat:@"%@dian.php/Home/Apiding/huan",PREFIX]


//我的积分记录页面
#define MinePoint_Record [NSString stringWithFormat:@"%@dian.php/Home/Apiding/jifen",PREFIX]

/** 我的收入明细 */
#define MineIncome_Details [NSString stringWithFormat:@"%@dian.php/Home/Apiding/zhichu",PREFIX]

/** 开店须知 */
#define OpenStore_Rule  [NSString stringWithFormat:@"%@index.php?ctl=api_search&act=help_info&cate_id=7",PREFIX]


#pragma mark - 方贤斌

//文章评论点赞
#define ArticleComment_Praise [NSString stringWithFormat:@"%@shop.php?ctl=api_article&act=commentPraise",PREFIX]

//商品详情
#define Goods_xiangqing_url [NSString stringWithFormat:@"%@index.php?ctl=api_wenzhang&act=xiangqing",PREFIX]


#endif
