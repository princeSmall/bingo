//
//  ShopContentModel.h
//  MovieIndustry
//
//  Created by aaa on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopContentModel : NSObject

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


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
