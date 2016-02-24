//
//  IndexHomeDealModel.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "IndexHomeDealModel.h"

@implementation IndexHomeDealModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    /*@property (nonatomic,copy) NSString *goods_id;
     @property (nonatomic,copy) NSString *goods_name;
     @property (nonatomic,copy) NSString *goods_price;
     @property (nonatomic,copy) NSString *goods_number;
     @property (nonatomic,copy) NSString *goods_city_id;
     @property (nonatomic,copy) NSString *shop_id;
     @property (nonatomic,copy) NSString *img_path;
     @property (nonatomic,copy) NSString *type;
     @property (nonatomic,copy) NSString *goods_city_name;*/
    if(self = [super init])
    {
        self.goods_id = dic[@"goods_id"];
        self.goods_name = dic[@"goods_name"];
        self.goods_price = dic[@"goods_price"];
        self.goods_number = dic[@"goods_number"];
        self.goods_city_id = dic[@"goods_city_id"];
        self.shop_id = dic[@"shop_id"];
        self.img_path = dic[@"img_path"];
        self.type = dic[@"type"];
        self.goods_city_name = dic[@"goods_city_name"];
        
    }
    return self;
}
@end
