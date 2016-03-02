//
//  MyOrderShopModel.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/27.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderShopModel : NSObject
//订单状态
@property (nonatomic,copy) NSString *order_status;
///订单ID
@property (nonatomic,copy) NSString *order_id;
///店铺电话
@property (nonatomic,copy) NSString *contact_phone;
///订单总价
@property (nonatomic,copy) NSString *total_price;
///订单商品ID总数
@property (nonatomic,copy) NSString *deal_ids;
//收货人姓名
@property (nonatomic,copy) NSString *consignee_name;
//省名
@property (nonatomic,copy) NSString *province_name;
//城市名
@property (nonatomic,copy) NSString *city_name;
//区名
@property (nonatomic,copy) NSString *district_name;
//地址
@property (nonatomic,copy) NSString *address;
//备注
@property (nonatomic,copy) NSString *remark;
//
@property (nonatomic,copy) NSString *order_amount;
//支付状态
@property (nonatomic,copy) NSString *pay_status;
//送货方式
@property (nonatomic,copy) NSString *method;
//商品信息
@property (nonatomic,copy) NSArray *order_goods;

@property (nonatomic,strong)NSString * spare_address;
@property (nonatomic,strong)NSString * status;





- (instancetype)initWithDict:(NSDictionary *)dict;

//- (instancetype)initWithDict:(NSDictionary *)dict;


@end
