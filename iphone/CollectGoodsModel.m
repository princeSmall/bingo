//
//  CollectGoodsModel.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "CollectGoodsModel.h"

@implementation CollectGoodsModel

-(instancetype)initWithDict:(NSDictionary *)dict
{

    if(self = [super init])
    {
        self.collect_id = dict[@"collect_id"];
        self.create_time = dict[@"create_time"];
        self.goods_city_id = dict[@"goods_city_id"];
        self.goods_express = dict[@"goods_express"];
        self.goods_id = dict[@"goods_id"];
        self.goods_name = dict[@"goods_name"];
        self.goods_price = dict[@"goods_price"];
        self.img_path = dict[@"img_path"];
        self.shop_id = dict[@"shop_id"];
        self.shop_name = dict[@"shop_name"];
        self.shop_tel = dict[@"shop_tel"];
        self.spare_address =dict[@"spare_address"];
        self.type = dict[@"type"];
    }
    return self;
}

@end
