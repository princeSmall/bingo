//
//  MovieShopCarGoodInfoCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarGoodsModel.h"
#import "CartGood.h"

@interface MovieShopCarGoodInfoCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;//选择按钮
@property (strong, nonatomic) IBOutlet UIImageView *goodImage;//商品图片

@property (strong, nonatomic) IBOutlet UILabel *goodName;//商品名称

@property (strong, nonatomic) IBOutlet UILabel *goodColor;//商品颜色

@property (strong, nonatomic) IBOutlet UILabel *currentPrice;//商品现价
@property (strong, nonatomic) IBOutlet UILabel *originPrice;//原价

@property (strong, nonatomic) IBOutlet UILabel *goodCount;//商品数量


- (void)config:(CartGood *)model;

@end
