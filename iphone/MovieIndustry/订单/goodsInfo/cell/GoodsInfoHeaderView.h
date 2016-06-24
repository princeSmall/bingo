//
//  GoodsInfoHeaderView.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface GoodsInfoHeaderView : UIView

///商品展示图片
@property (strong, nonatomic) SDCycleScrollView *goodsScrollView;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
///当前价格
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
///商家送货方式
@property (weak, nonatomic) IBOutlet UILabel *businessPostTypeLabel;
///商家位置
@property (weak, nonatomic) IBOutlet UILabel *goodsLocationLabel;

///详情按钮
@property (weak, nonatomic) IBOutlet UIButton *xiangqingButton;
///评论按钮
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//押金
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;

///红色线
@property (weak, nonatomic) IBOutlet UIView *btnLine;
//商品简介
@property (weak, nonatomic) IBOutlet UILabel *goodDescLbl;

@end
