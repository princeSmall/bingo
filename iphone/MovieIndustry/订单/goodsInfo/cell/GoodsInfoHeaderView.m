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
    self.goodsScrollView = [PictureCarouselView pictureCarouselViewWithFrame:CGRectMake(0, 0, kViewWidth, 366)];
    //
    //    //设置自动滚动和滚动的时间
    [self.goodsScrollView isAutomaticDragging:YES withAnimation:YES withTimeInterval:3];
    //    //设置pageControl的属性
    [self.goodsScrollView setPageControlWithFrame:CGRectMake(kViewWidth/4, 320, kViewWidth/2, 20) AlignmentMethod:AlignmentMethodCenter withCurrentColor:[UIColor redColor] withIndicatorColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    [self addSubview:self.goodsScrollView];
    
    
    self.btnLine.frame = CGRectMake(20, 40, (kViewWidth/2)-40, 2);
    self.btnLine.backgroundColor = [UIColor redColor];
}

@end
