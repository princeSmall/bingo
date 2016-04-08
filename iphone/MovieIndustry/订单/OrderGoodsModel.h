//
//  OrderGoodsModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGoodsModel : NSObject
@property (nonatomic,strong)NSString *order_id;
@property (nonatomic,strong)NSString *shop_id;
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *goods_number;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,strong)NSString *name_value_str;
@property (nonatomic,strong)NSString *img_path;
@property (nonatomic,strong)NSString *goods_deposit;
@property (nonatomic,strong)NSString *is_refund;//是否退款
@property (nonatomic,strong)NSString *is_deposit;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
