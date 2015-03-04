//
//  OrderDataModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/2/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDataModel : NSObject
@property (nonatomic,copy)NSString *order_id;
@property (nonatomic,copy)NSString *order_amount;
@property (nonatomic,copy)NSString *order_status;
@property (nonatomic,copy)NSString *pay_status;
@property (nonatomic,copy)NSString *shop_status;
@property (nonatomic,copy)NSArray *order_shops;
@property (nonatomic,strong)NSString * status;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
