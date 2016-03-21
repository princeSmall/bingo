//
//  FilmInterfaceNew.h
//  MovieIndustry
//
//  Created by aaa on 16/1/28.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>
//头部接口
//外网
//#define HttpUrlLeft @"http://test.3tichina.com:8017/front/index.php/api/"
//内网
#define HttpUrlLeft @"http://demo635.firdot.com/Code/front/index.php/api/"
/*
 *下面为接口
 */

//1商品详情
#define TIGoods_Details [NSString stringWithFormat:@"%@goods/goodsDetail",HttpUrlLeft]
//2首页商品列表
#define TIGoods_List [NSString stringWithFormat:@"%@goods/indexGoods",HttpUrlLeft]
//3商品添加到购物车
#define TIGoods_AddCart [NSString stringWithFormat:@"%@cart/addCart",HttpUrlLeft]
//4省市联动
#define TIShipping_Regions [NSString stringWithFormat:@"%@shipping/regions",HttpUrlLeft]
//5添加收货地址
#define TIShipping_AddSAddr [NSString stringWithFormat:@"%@shipping/addSAddr",HttpUrlLeft]
//6删除地址
#define TIShipping_DeleteAddr [NSString stringWithFormat:@"%@shipping/deleteAddr",HttpUrlLeft]
//7修改默认地址
#define TIShipping_addrDefault [NSString stringWithFormat:@"%@shipping/addrDefault",HttpUrlLeft]
//8收货地址列表
#define TIShipping_AddrList [NSString stringWithFormat:@"%@shipping/addrList",HttpUrlLeft]
//9申请开店
#define TIShop_ApplyShop [NSString stringWithFormat:@"%@shop/applyShop",HttpUrlLeft]
//10店铺详情
#define TIShop_ShopDetail [NSString stringWithFormat:@"%@shop/shopDetail",HttpUrlLeft]
//11商品的一级分类列表
#define TIShop_GoodsCategory [NSString stringWithFormat:@"%@shop/goodsCategory",HttpUrlLeft]
//12店铺设置
#define TIShop_SetShop [NSString stringWithFormat:@"%@shop/setShop",HttpUrlLeft]
//13修改用户资料
#define TIPerson_UpdateUser [NSString stringWithFormat:@"%@person/updateUser",HttpUrlLeft]
//14个人资料详情
#define TIPerson_UserDetail [NSString stringWithFormat:@"%@person/userDetail",HttpUrlLeft]
//15发布产品
#define TIPublish_Something [NSString stringWithFormat:@"%@publish/something",HttpUrlLeft]
//16修改产品信息
#define TIPublish_UpdateSomething [NSString stringWithFormat:@"%@publish/updateSomething",HttpUrlLeft]
//17商品下的所有规格型号
#define TIGoods_GoodsAttributes [NSString stringWithFormat:@"%@goods/goodsAttributes",HttpUrlLeft]
//18购物车列表
#define TICart_CartGoodsList [NSString stringWithFormat:@"%@cart/cartGoodsList",HttpUrlLeft]
//19、删除购物车商品
#define TICart_DeleteCartGoods [NSString stringWithFormat:@"%@cart/deleteCartGoods",HttpUrlLeft]
//20、更改购物车商品数量 根据购物车id
#define TICart_UpdateNumber [NSString stringWithFormat:@"%@cart/updateNumber",HttpUrlLeft]
//21、商品添加购物车
#define TICart_AddCart [NSString stringWithFormat:@"%@cart/addCart",HttpUrlLeft]
//22、订单详情
#define TIOrder_OrderDetail [NSString stringWithFormat:@"%@order/orderDetail",HttpUrlLeft]
//23、订单生成
#define TIOrder_AddOrder [NSString stringWithFormat:@"%@order/addOrder",HttpUrlLeft]
//24、确认收货、取消订单
#define TIOrder_ConfirmOrder [NSString stringWithFormat:@"%@order/confirmOrder",HttpUrlLeft]
//25、订单列表
#define TIOrder_OrderList [NSString stringWithFormat:@"%@order/orderList",HttpUrlLeft]
//26、商品管理列表
#define TIShopGoods_GoodsList [NSString stringWithFormat:@"%@shopGoods/GoodsList",HttpUrlLeft]
//27、已出租的商品
#define TIShopGoods_BorrowGoods [NSString stringWithFormat:@"%@shopGoods/borrowGoods",HttpUrlLeft]
//28、确认归还
#define TIShopGoods_ConfirmBack [NSString stringWithFormat:@"%@shopGoods/confirmBack",HttpUrlLeft]
//29、订单管理列表
#define TIShopOrder_OrderList [NSString stringWithFormat:@"%@shopOrder/orderList",HttpUrlLeft]
//30、订单备注
#define TIShopOrder_OrderRemark [NSString stringWithFormat:@"%@shopOrder/orderRemark",HttpUrlLeft]
//31、修改订单状态
#define TIShopOrder_OrderStatus [NSString stringWithFormat:@"%@shopOrder/orderStatus",HttpUrlLeft]
//32、发布人员
#define TIPublish_People [NSString stringWithFormat:@"%@publish/people",HttpUrlLeft]
//33、修改发布的人员
#define TIPublish_UpdatePeople [NSString stringWithFormat:@"%@publish/updatePeople",HttpUrlLeft]
//34、发布场地
#define TIPublish_Place [NSString stringWithFormat:@"%@publish/place",HttpUrlLeft]
//35、修改发布的场地
#define TIPublish_UpdatePlace [NSString stringWithFormat:@"%@publish/updatePlace",HttpUrlLeft]
//36、商品分类
#define TIPublish_Categories [NSString stringWithFormat:@"%@publish/Categories",HttpUrlLeft]

//37、上传图片接口
#define TICommon_Uploadify [NSString stringWithFormat:@"%@common/uploadify",@"http://test.3tichina.com:8017/front/index.php/api/"]

//38、用户登陆接口
#define TIUser_Login [NSString stringWithFormat:@"%@user/login",HttpUrlLeft]

//39.收藏商品或店铺
#define TIAdd_Collection [NSString stringWithFormat:@"%@collect/addCollection",HttpUrlLeft]
//40.收藏商品列表
#define TIAdd_CollectionGoodsList [NSString stringWithFormat:@"%@collect/collectGoods",HttpUrlLeft]
//41.收藏店铺列表
#define TIAdd_CollectionShopList [NSString stringWithFormat:@"%@collect/collectShops",HttpUrlLeft]
//42.删除收藏
#define TIAdd_DeleteCollection [NSString stringWithFormat:@"%@collect/deleteCollection",HttpUrlLeft]

//43.订单支付状态回调
#define TIPay_CallBack [NSString stringWithFormat:@"%@order/CallBackOrder",HttpUrlLeft]
//44.店铺首页商品列表
#define TIShop_goodsList [NSString stringWithFormat:@"%@shop/shopGoods",HttpUrlLeft]
//45.店铺宝贝分类列表
#define TIShop_cateGoodsList [NSString stringWithFormat:@"%@shop/cateGoods",HttpUrlLeft]

//46.店铺最新上架商品列表
#define TIShop_newGoodsList [NSString stringWithFormat:@"%@shop/newGoods",HttpUrlLeft]



//APPDELEGATE单类
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])


/*
 图片访问的路径
 *192.168.2.110/index.php/api/
 */
//大图
#define TIBIGImage @"http://test.3tichina.com:8017/front/media/images/imgs/big/"
//中图
#define TIMIDDLEImage @"http://test.3tichina.com:8017/front/media/images/imgs/middle/"
//小图
#define TISMALLImage @"http://test.3tichina.com:8017/front/media/images/imgs/small/"

//内网测试

//大图
//#define TIBIGImage @"http://demo635.firdot.com/Code/front/media/images/imgs/big/"
////中图
//#define TIMIDDLEImage @"http://demo635.firdot.com/Code/front/media/images/imgs/middle/"
////小图
//#define TISMALLImage @"http://demo635.firdot.com/Code/front/media/images/imgs/small/"


@interface FilmInterfaceNew : NSObject

@end
