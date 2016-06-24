//
//  ShopCarGoodsModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarGoodsModel : NSObject
///当前价格
@property (nonatomic,copy) NSString *current_price;
///商品ID
@property (nonatomic,copy) NSString *deal_id;
///商品名
@property (nonatomic,copy) NSString *deal_name;
///img
@property (nonatomic,copy) NSString *img;
///数量
@property (nonatomic,copy) NSString *number;
///原价
@property (nonatomic,copy) NSString *origin_price;
///店铺ID
@property (nonatomic,copy) NSString *supplier_id;
///颜色 yanse
@property (nonatomic,copy) NSString *goodsColors;
///型号
@property (nonatomic,copy) NSString *goodsXinhao;

///购物车单个商品ID
@property (nonatomic,copy) NSString *gwc_id;

///设置每条订单的状态 是否选中
@property (nonatomic,assign) BOOL selectState;

@end
