//
//  ShopingCarSelectView.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShopingCarSelectView.h"

@implementation ShopingCarSelectView

- (void)drawRect:(CGRect)rect
{
    self.goodsImage.layer.borderWidth = 1;
    self.goodsImage.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
}

@end
