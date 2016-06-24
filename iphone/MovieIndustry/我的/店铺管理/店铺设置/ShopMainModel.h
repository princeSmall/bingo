//
//  ShopMainModel.h
//  MovieIndustry
//
//  Created by 童乐 on 16/2/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopMainModel : NSObject

@property (nonatomic,strong)NSString * shop_id;
@property (nonatomic,strong)NSString * user_id;
@property (nonatomic,strong)NSString * shop_name;
@property (nonatomic,strong)NSString * shop_logo;
@property (nonatomic,strong)NSString * shop_desc;
@property (nonatomic,strong)NSString * province_id;
@property (nonatomic,strong)NSString * city_id;
@property (nonatomic,strong)NSString * district_id;
@property (nonatomic,strong)NSString * shop_addr_detail;
@property (nonatomic,strong)NSString * shop_tel;
@property (nonatomic,strong)NSString * shop_contact_person;
@property (nonatomic,strong)NSString * category_id;
@property (nonatomic,strong)NSString * status;
@property (nonatomic,strong)NSString * spare_address;
@property (nonatomic,strong)NSString * score;
@property (nonatomic,strong)NSString * sale_count;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
