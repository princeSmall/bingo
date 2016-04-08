//
//  CollectGoodsModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
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
@property (nonatomic,copy)NSString *type;
@property (nonatomic,strong)NSString * people_location;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
