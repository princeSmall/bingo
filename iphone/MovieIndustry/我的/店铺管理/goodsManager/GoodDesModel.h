//
//  GoodDesModel.h
//  MovieIndustry
//
//  Created by 童乐 on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDesModel : NSObject

@property (nonatomic,strong)NSString * goods_id;
@property (nonatomic,strong)NSString * user_id;
@property (nonatomic,strong)NSString * shop_id;
@property (nonatomic,strong)NSString * goods_name;
@property (nonatomic,strong)NSString * goods_price;
@property (nonatomic,strong)NSString * goods_number;
@property (nonatomic,strong)NSString * goods_category_id;
@property (nonatomic,strong)NSString * is_deposit;
@property (nonatomic,strong)NSString * goods_deposit;
@property (nonatomic,strong)NSString * goods_desc;
@property (nonatomic,strong)NSString * market_price;
@property (nonatomic,strong)NSString * goods_city_id;
@property (nonatomic,strong)NSString * goods_express;
@property (nonatomic,strong)NSString * goods_mobile;
@property (nonatomic,strong)NSString * goods_alone;
@property (nonatomic,strong)NSString * goods_job;
@property (nonatomic,strong)NSString * goods_area;
@property (nonatomic,strong)NSString * confirm;
@property (nonatomic,strong)NSString * index_sort;
@property (nonatomic,strong)NSString * create_time;
@property (nonatomic,strong)NSArray * imgs;
@property (nonatomic,strong)NSString * goods_city_name;
@property (nonatomic,strong)NSString * spare_address;
@property (nonatomic,strong)NSString * type;
@property (nonatomic,strong)NSString * img_path;
@property (nonatomic,strong)NSString * category_name;
@property (nonatomic,strong)NSString * people_location;
@property (nonatomic,strong)NSString * is_deduction;

@property (nonatomic,strong)NSString * goods_info;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
