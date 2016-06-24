//
//  OrderShopModel.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OrderShopModel : NSObject
@property (nonatomic,copy)NSString *shop_id;
@property (nonatomic,copy)NSString *shop_name;
@property (nonatomic,copy)NSString *shop_logo;
@property (nonatomic,copy)NSString *shop_tel;
@property (nonatomic,copy)NSArray *shop_goods;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
