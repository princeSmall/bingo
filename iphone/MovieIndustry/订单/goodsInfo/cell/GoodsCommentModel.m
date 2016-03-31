//
//  GoodsCommentModel.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "GoodsCommentModel.h"

@implementation GoodsCommentModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
