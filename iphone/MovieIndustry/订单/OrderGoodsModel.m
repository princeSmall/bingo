//
//  OrderGoodsModel.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "OrderGoodsModel.h"

@implementation OrderGoodsModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
