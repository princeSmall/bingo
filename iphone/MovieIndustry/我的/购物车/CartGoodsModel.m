//
//  CartGoodsModel.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CartGoodsModel.h"
#import "CartGood.h"

@implementation CartGoodsModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        self.shop_id = dict[@"shop_id"];
        self.shop_name = dict[@"shop_name"];
        self.shop_logo = dict[@"shop_logo"];
        NSArray * array = [NSArray arrayWithArray: dict[@"shop_goods"]];
       
        NSMutableArray * array1 = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            CartGood * good = [[CartGood alloc]initWithDict:array[i]];
            [array1 addObject:good];
        }
        self.shop_goods = array1;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
