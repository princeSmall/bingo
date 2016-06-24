//
//  OrderShopModel.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "OrderShopModel.h"
#import "OrderGoodsModel.h"

@implementation OrderShopModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        self.shop_id = dict[@"shop_id"];
        self.shop_name = dict[@"shop_name"];
        self.shop_logo = dict[@"shop_logo"];
        self.shop_tel = dict[@"shop_tel"];
        
        NSMutableArray * mutArray = [NSMutableArray array];
        for (NSDictionary * dic in dict[@"shop_goods"]) {
            OrderGoodsModel * order = [[OrderGoodsModel alloc]initWithDict:dic];
            [mutArray addObject:order];
        }
        self.shop_goods = mutArray;
    }
    return self;
}

@end
