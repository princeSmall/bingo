//
//  ConllectShopModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConllectShopModel : NSObject

@property (nonatomic,copy)NSString *city_name;
@property (nonatomic,copy)NSString *collect_id;
@property (nonatomic,copy)NSString *create_time;
@property (nonatomic,copy)NSString *district_name;
@property (nonatomic,copy)NSString *province_name;
@property (nonatomic,copy)NSString *shop_id;
@property (nonatomic,copy)NSString *shop_logo;
@property (nonatomic,copy)NSString *shop_name;
@property (nonatomic,copy)NSString *shop_tel;
@property (nonatomic,copy)NSString *spare_address;

-(instancetype)initWithDict:(NSDictionary *)dict;



@end
