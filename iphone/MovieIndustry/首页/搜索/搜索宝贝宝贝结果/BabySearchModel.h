//
//  BabySearchModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabySearchModel : NSObject
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *img_path;
@property (nonatomic,copy) NSString *goods_deposit;
@property (nonatomic,copy) NSString *is_deduction;
@property (nonatomic,copy) NSString *is_deposit;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *local_name;
@property (nonatomic,copy) NSString *goods_express;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *goods_price;
@property (nonatomic,copy) NSString *people_location;
@property (nonatomic,copy) NSString *spare_address;
@property (nonatomic,copy) NSString *shop_id;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
