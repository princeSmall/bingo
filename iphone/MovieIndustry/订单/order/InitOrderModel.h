//
//  InitOrderModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/25.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitOrderModel : NSObject
////现价
@property (nonatomic,copy) NSString *current_price;
///原价
@property (nonatomic,copy) NSString *origin_price;

@property (nonatomic,copy) NSString *free_delivery;

@property (nonatomic,copy) NSString *img;
///商品名称
@property (nonatomic,copy) NSString *name;

///商品颜色
@property (nonatomic,copy) NSString *colors;
////商品型号
@property (nonatomic,copy) NSString *xinghao;

//商品数量
@property (nonatomic,copy) NSString *number;

///商品ID
@property (nonatomic,copy) NSString *goodsId;

@end
