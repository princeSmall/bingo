//
//  ProvinceModel.m
//  选择城市按钮demo
//
//  Created by aaa on 16/1/21.
//  Copyright © 2016年 aaa. All rights reserved.
//

#import "ProvinceModel.h"
#import "CitysModel.h"

@implementation ProvinceModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        self.state = dict[@"state"];
        NSArray * array = dict[@"cities"];
        NSMutableArray * array1 = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CitysModel * city = [CitysModel CitysWithDict:obj];
            [array1 addObject:city];
        }];
        self.cities = array1;
    }
    return self;
}
+ (instancetype)provinceWithDict:(NSDictionary *)dict{
    return [[ProvinceModel alloc]initWithDict:dict];
}

+ (NSString *)GetStrFormArray:(NSArray *)array{
     NSMutableString * mutStr = [NSMutableString string];
    if (array.count<2) {
        return @"";
    }else{
    if ([array[0] isEqualToString:@"北京"]||[array[0] isEqualToString:@"上海"]||[array[0] isEqualToString:@"天津"]||[array[0] isEqualToString:@"重庆"]) {
        [mutStr appendString:array[0]];
        [mutStr appendString:@"市"];
        [mutStr appendString:array[1]];
        [mutStr appendString:@"区"];
    }else{
        [mutStr appendString:array[0]];
        [mutStr appendString:@"省"];
        [mutStr appendString:array[1]];
        [mutStr appendString:@"市"];
    }
         return mutStr;
    }
}



@end
