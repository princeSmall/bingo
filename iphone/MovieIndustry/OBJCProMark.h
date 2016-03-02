//
//  OBJCProMark.h
//  MovieIndustry
//
//  Created by aaa on 16/1/28.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBJCProMark : NSObject

+ (NSMutableDictionary *)DictWithCommand:(NSString *)command
                           Entity:(NSString *)entity
                     ParameterDic:(NSDictionary *)parameters;


@end
