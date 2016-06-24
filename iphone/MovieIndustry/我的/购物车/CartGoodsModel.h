//
//  CartGoodsModel.h
//  MovieIndustry
//
//  Created by 童乐 on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartGoodsModel : NSObject

@property (nonatomic,strong)NSString * shop_id;
@property (nonatomic,strong)NSString * shop_name;
@property (nonatomic,strong)NSString * shop_logo;
@property (nonatomic,strong)NSArray * shop_goods;
@property (nonatomic,assign)BOOL selectState;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
