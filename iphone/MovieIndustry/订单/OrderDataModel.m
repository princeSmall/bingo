//
//  OrderDataModel.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/2/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "OrderDataModel.h"
#import "OrderShopModel.h"

@implementation OrderDataModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    /*@interface OrderDataModel : NSObject
     @property (nonatomic,copy)NSString *order_id;
     @property (nonatomic,copy)NSString *order_amount;
     @property (nonatomic,copy)NSString *order_status;
     @property (nonatomic,copy)NSString *pay_status;
     @property (nonatomic,copy)NSString *shop_status;
     @property (nonatomic,copy)NSArray *order_shops;
     @property (nonatomic,strong)NSString * status;
     @property (nonatomic,strong)NSString * status_name;
     @property (nonatomic,strong)NSString * action;
     @property (nonatomic,strong)NSString * action_name;*/
    if (self = [super init]) {
        self.order_id = dict[@"order_id"];
        self.order_amount = dict[@"order_amount"];
        self.order_status = dict[@"order_status"];
        self.pay_status = dict[@"pay_status"];
        self.shop_status = dict[@"shop_status"];
        self.status = [NSString stringWithFormat:@"%d", [dict[@"status"] intValue]];
        self.status_name = dict[@"status_name"];
        self.action = dict[@"action"];
        self.action_name = dict[@"action_name"];
        
        NSMutableArray * mutArray = [NSMutableArray array];
        
        for (NSDictionary * dic in dict[@"order_shops"]) {
            OrderShopModel * shop = [[OrderShopModel alloc]initWithDict:dic];
            [mutArray addObject:shop];
        }
        self.order_shops = mutArray;
    }
    return self;
}



@end
