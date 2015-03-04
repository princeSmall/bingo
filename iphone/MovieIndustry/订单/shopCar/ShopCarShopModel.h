//
//  ShopCarShopModel.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarShopModel : NSObject
///店铺名字
@property (nonatomic,copy) NSString *name;
///店铺ID
@property (nonatomic,copy) NSString *supplier_id;
///店铺订单价格
@property (nonatomic,copy) NSString *orderPrice;
///店铺商品数目
@property (nonatomic,copy) NSString *order_goods_num;
///店铺是否选中
@property (nonatomic,assign) BOOL selectState;

@end
