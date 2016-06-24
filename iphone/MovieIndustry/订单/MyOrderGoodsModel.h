//
//  MyOrderGoodsModel.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/27.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderGoodsModel : NSObject
///商品名称
@property (nonatomic,copy) NSString *name;
///商品属性
@property (nonatomic,copy) NSString *attr_str;

///单价
@property (nonatomic,copy) NSString *unit_price;

///总价
@property (nonatomic,copy) NSString *total_price;

///数量
@property (nonatomic,copy) NSString *number;

///型号
@property (nonatomic,copy) NSString *xinghao;

////颜色
@property (nonatomic,copy) NSString *yanse;
///图片
@property (nonatomic,copy) NSString *img;
///订单ID
@property (nonatomic,copy) NSString *order_id;
//商品ID
@property (nonatomic,copy) NSString *goods_id;

//评价的id
@property (nonatomic,copy) NSString *commentID;

@end
