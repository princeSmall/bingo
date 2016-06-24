//
//  ShopGoodsModel.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/17/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "ShopGoodsModel.h"

@implementation ShopGoodsModel


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.goods_express = dict[@"goods_express"];
        self.goods_id = dict[@"goods_id"];
        self.goods_name = dict[@"goods_name"];
        self.goods_price = dict[@"goods_price"];
        self.img_path = dict[@"img_path"];
        self.market_price = dict[@"market_price"];
        self.goods_deposit = dict[@"goods_deposit"];
        self.people_location = dict[@"people_location"];
        
    }
    return  self;
}
@end
