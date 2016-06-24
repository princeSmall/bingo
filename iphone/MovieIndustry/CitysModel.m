//
//  CitysModel.m
//  选择城市按钮demo
//
//  Created by 童乐 on 16/1/21.
//  Copyright © 2016年 童乐. All rights reserved.
//

#import "CitysModel.h"

@implementation CitysModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        self.city = dict[@"city"];
        self.areas = dict[@"areas"];
    }
    return self;
}
+ (instancetype)CitysWithDict:(NSDictionary *)dict{
    return [[CitysModel alloc]initWithDict:dict];
}


@end
