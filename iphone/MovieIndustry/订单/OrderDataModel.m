//
//  OrderDataModel.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/2/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "OrderDataModel.h"
#import "OrderShopModel.h"

@implementation OrderDataModel

//- (instancetype)initWithDict:(NSDictionary *)dict{
//
//    if (self = [super init]) {
//        self.order_id = dict[@"order_id"];
//        self.order_amount = dict[@"order_amount"];
//        self.order_status = dict[@"pay_status"];
//        self.shop_status = dict[@"shop_status"];
//        
//        
//        NSMutableArray * mutArray = [NSMutableArray array];
//        
//        for (NSDictionary * dic in dict[@"order_shops"]) {
//            OrderShopModel * shop = [[OrderShopModel alloc]initWithDict:dic];
//            [mutArray addObject:shop];
//        }
//        self.order_shops = mutArray;
//    }
//    return self;
//}



@end
