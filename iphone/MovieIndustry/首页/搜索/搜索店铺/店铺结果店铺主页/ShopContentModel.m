//
//  ShopContentModel.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ShopContentModel.h"

@implementation ShopContentModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
