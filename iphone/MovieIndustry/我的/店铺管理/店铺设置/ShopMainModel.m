//
//  ShopMainModel.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ShopMainModel.h"

@implementation ShopMainModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
