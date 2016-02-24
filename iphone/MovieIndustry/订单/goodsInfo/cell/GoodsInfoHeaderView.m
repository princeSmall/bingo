//
//  GoodsInfoHeaderView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "GoodsInfoHeaderView.h"

@implementation GoodsInfoHeaderView

- (void)drawRect:(CGRect)rect {
    
    self.goodsScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 366)];
    //
    //    //设置自动滚动和滚动的时间
   
    //    //设置pageControl的属性
    [self addSubview:self.goodsScrollView];
    
    
    self.btnLine.frame = CGRectMake(20, 40, (kViewWidth/2)-40, 2);
    self.btnLine.backgroundColor = [UIColor redColor];
}

@end
