//
//  GoodsSearchModel.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopSearchModel : NSObject
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *shopImg;
@property (nonatomic,copy) NSString *shopPoints;
@property (nonatomic,copy) NSString *shopGoods;
@property (nonatomic,copy) NSString *shopBrief;

@property (nonatomic,copy) NSString *shangpin;
@property (nonatomic,copy) NSString *goodszhekou;
///商品ID
@property (nonatomic,copy) NSString *shopID;
@end
