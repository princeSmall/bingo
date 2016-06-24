//
//  MyOrderShopModel.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/27.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyOrderShopModel.h"

@implementation MyOrderShopModel


- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
