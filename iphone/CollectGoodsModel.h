//
//  CollectGoodsModel.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectGoodsModel : NSObject
@property (nonatomic,copy)NSString *collect_id;
@property (nonatomic,copy)NSString *create_time;
@property (nonatomic,copy)NSString *goods_city_id;
@property (nonatomic,copy)NSString *goods_express;
@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,copy)NSString *goods_name;
@property (nonatomic,copy)NSString *goods_price;
@property (nonatomic,copy)NSString *img_path;
@property (nonatomic,copy)NSString *shop_id;
@property (nonatomic,copy)NSString *shop_name;
@property (nonatomic,copy)NSString *shop_tel;
@property (nonatomic,copy)NSString *spare_address;
@property (nonatomic,strong)NSString * perple_location;

@property (nonatomic,strong)NSString * goods_deposit;


@property (nonatomic,copy)NSString *type;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
