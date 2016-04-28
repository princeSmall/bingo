//
//  ShopOrderGoodModel.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ShopOrderGoodModel.h"

@implementation ShopOrderGoodModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

@end
