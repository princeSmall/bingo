//
//  MyOrderCellFooter.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCellFooter : UIView
///商品总数
@property (weak, nonatomic) IBOutlet UILabel *goodsTotalLabel;
///商品总费用
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceTotalLabel;


///申请退款按钮
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;

///评价按钮
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
