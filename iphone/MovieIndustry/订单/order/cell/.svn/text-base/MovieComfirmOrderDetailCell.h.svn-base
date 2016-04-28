//
//  MovieComirmOrderDetailCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitOrderModel.h"
#import "GoodDesModel.h"
#import "CartGood.h"

@interface MovieComfirmOrderDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
///分类属性
@property (weak, nonatomic) IBOutlet UILabel *goodsAttributeLabel;
///现在的价格
@property (weak, nonatomic) IBOutlet UILabel *currenPriceLabel;
///老的价格
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;

///商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;
//押金label
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;

///配置参数
- (void)config:(GoodDesModel *)model Andtype:(NSString *)type;

- (void)initCGood:(CartGood *)model;

@end
