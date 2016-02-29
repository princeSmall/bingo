//
//  ShopGoodsModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/17/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopGoodsModel : NSObject

@property (nonatomic,copy)NSString *goods_express;
@property (nonatomic,copy)NSString *goods_id;
@property (nonatomic,copy)NSString *goods_name;
@property (nonatomic,copy)NSString *goods_price;
@property (nonatomic,copy)NSString *img_path;
@property (nonatomic,copy)NSString *market_price;
@property (nonatomic,copy)NSString *goods_deposit;

-(instancetype)initWithDict:(NSDictionary *)dict;


@end
