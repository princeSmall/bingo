//
//  UserDesModel.m
//  MovieIndustry
//
//  Created by aaa on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "UserDesModel.h"

@implementation UserDesModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (void) GetUploadImageDictWithData:(NSData *)imageData WithType:(NSString *)type With:(successBlock)block{

    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"device"] = @"0";
    dict[@"stream"] = imageData;
    dict[@"flag"] = type;
    
    [HttpRequestServers requestBaseUrl:TICommon_Uploadify withParams:dict withRequestFinishBlock:^(id result) {
        NSDictionary * dict = result[@"data"];
       NSString *imageName = dict[@"img"];
        block(imageName);
    } withFieldBlock:^{
        block(@"F");
    }];
}


@end
