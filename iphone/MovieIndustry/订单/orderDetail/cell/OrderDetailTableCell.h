//
//  OrderDetailTableCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderGoodsModel.h"
#import "OrderGoodsModel.h"

@interface OrderDetailTableCell : UITableViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
///商品标题
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
///商品单价
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
///商品属性
@property (weak, nonatomic) IBOutlet UILabel *goodsAttrbuteLabel;
//商品数目
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;
///根据状态变化的按钮
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;

- (void)config:(OrderGoodsModel *)model;

@end
