//
//  CartGood.m
//  MovieIndustry
//
//  Created by aaa on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CartGood.h"

@implementation CartGood

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}


@end
