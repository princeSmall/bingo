//
//  OrderGoodsModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGoodsModel : NSObject
@property (nonatomic,copy)NSString *order_id;
@property (nonatomic,copy)NSString *shop_id;
@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,copy)NSString *goods_name;
@property (nonatomic,copy)NSString *goods_number;
@property (nonatomic,copy)NSString *goods_price;
@property (nonatomic,copy)NSString *name_value_str;
@property (nonatomic,copy)NSString *img_path;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
