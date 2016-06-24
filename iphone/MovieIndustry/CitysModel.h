//
//  CitysModel.h
//  选择城市按钮demo
//
//  Created by 童乐 on 16/1/21.
//  Copyright © 2016年 童乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitysModel : NSObject

@property (nonatomic,strong)NSString * city;
@property (nonatomic,strong)NSArray * areas;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)CitysWithDict:(NSDictionary *)dict;

@end
