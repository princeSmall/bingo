//
//  ShopCarShopHeaderView.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarShopModel.h"
#import "CartGoodsModel.h"


@interface ShopCarShopHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;

@property (strong, nonatomic) IBOutlet UILabel *shopName;


@property (strong, nonatomic) IBOutlet UIButton *editBtn;
///前往店铺
@property (weak, nonatomic) IBOutlet UIButton *enterShopButton;

- (void)config:(CartGoodsModel *)model;

@end
