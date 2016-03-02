//
//  BabySearchModel.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabySearchModel : NSObject
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *goodsImg;
@property (nonatomic,copy) NSString *goodsCurrentPrice;
@property (nonatomic,copy) NSString *goodsOriginPrice;
@property (nonatomic,copy) NSString *goodsCity;
///商品ID
@property (nonatomic,copy) NSString *goodsID;

@property (nonatomic,copy) NSString *location_id;
@property (nonatomic,copy) NSString *songhuo;
@end
