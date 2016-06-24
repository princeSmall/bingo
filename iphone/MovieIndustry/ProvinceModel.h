//
//  ProvinceModel.h
//  选择城市按钮demo
//
//  Created by 童乐 on 16/1/21.
//  Copyright © 2016年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property (nonatomic,strong)NSString * state;
@property (nonatomic,strong)NSArray * cities;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provinceWithDict:(NSDictionary *)dict;

+ (NSString *)GetStrFormArray:(NSArray *)array;

@end
