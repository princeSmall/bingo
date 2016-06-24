//
//  JGAreaModel.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/16.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "JGAreaModel.h"

@implementation JGAreaModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.local_name = dict[@"local_name"];
    }
    return self;
}

@end
