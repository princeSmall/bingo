//
//  JGScenic.h
//  MovieIndustry
//
//  Created by aaa on 16/3/23.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EndBlock)(CGFloat la,CGFloat lo);

@interface JGScenic : NSObject

@property (nonatomic,assign)CGFloat s_latitude;
@property (nonatomic,assign)CGFloat s_longitude;
@property (nonatomic,strong)NSString * s_name;
@property (nonatomic,strong)NSString * s_address;
@property (nonatomic,strong)NSString * s_icon;
@property (nonatomic,strong)EndBlock  block;

- (void)setS_address:(NSString *)s_address;


@end
