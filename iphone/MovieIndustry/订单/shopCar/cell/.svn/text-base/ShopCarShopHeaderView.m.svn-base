//
//  ShopCarShopHeaderView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShopCarShopHeaderView.h"
#import "CartGoodsModel.h"

@implementation ShopCarShopHeaderView

- (void)config:(CartGoodsModel *)model
{
    ///设置店铺名称
    self.shopName.text = model.shop_name;
    //设置状态显示
    if (model.selectState) {
        [self.chooseBtn setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateNormal];
    }else
    {
        [self.chooseBtn setImage:[UIImage imageNamed:@"tick_off"] forState:UIControlStateNormal];
    }
}

- (void)drawRect:(CGRect)rect {
     
}

@end
