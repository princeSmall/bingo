//
//  BusinessOrderModel.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/10.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "BusinessOrderModel.h"

@implementation BusinessOrderModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self= [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
