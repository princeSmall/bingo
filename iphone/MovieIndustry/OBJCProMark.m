//
//  OBJCProMark.m
//  MovieIndustry
//
//  Created by aaa on 16/1/28.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "OBJCProMark.h"

@implementation OBJCProMark

+ (NSMutableDictionary *)DictWithCommand:(NSString *)command
                           Entity:(NSString *)entity
                     ParameterDic:(NSDictionary *)parameters{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"command"] = command;
    dic[@"entity"] = entity;
    NSArray * keyArray = [parameters allKeys];
    NSArray * valueArray = [parameters allValues];
    NSMutableString * mutStr = [NSMutableString string];
    [mutStr appendString:@"{"];
    for (int i = 0; i < keyArray.count-1; i ++) {
        NSString * strAppend = [NSString stringWithFormat:@"\"%@\":\"%@\",",keyArray[i],valueArray[i]];
        [mutStr appendString:strAppend];
    }
    NSString * strAppendLast = [NSString stringWithFormat:@"\"%@\":\"%@\"",[keyArray lastObject],[valueArray lastObject]];
    [mutStr appendString:strAppendLast];
    [mutStr appendString:@"}"];
    dic[@"parameters"] = mutStr;
    return dic;
}




@end
