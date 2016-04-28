//
//  SeeModel.h
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/20.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeeModel : NSObject

@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,strong)NSString *goods_id;
@property (nonatomic ,strong)NSString *goods_name;
@property (nonatomic ,strong)NSString *goods_price;
@property (nonatomic ,strong)NSString *img_path;
@property (nonatomic ,strong)NSString *pics;
@property (nonatomic ,strong)NSString *score;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
