//
//  MyOrderCellHeader.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCellHeader : UIView
///商品订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

///店铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

///进入店铺按钮
@property (weak, nonatomic) IBOutlet UIButton *enterShopButton;
//小箭头长度
@property (weak, nonatomic) IBOutlet UIImageView *orderArrowImage;
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;

@end
