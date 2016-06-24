//
//  ShopGroupFooter.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/1.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopGroupFooter : UIView

///配送方式
@property (weak, nonatomic) IBOutlet UILabel *postTypeLabel;

///选择配送方式
@property (weak, nonatomic) IBOutlet UIButton *choosePostTypeButton;


///一共有多少商品
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsLabel;

///价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
///留言框
@property (strong, nonatomic) IBOutlet UITextField *textField;

///积分数目
@property (strong, nonatomic) IBOutlet UILabel *scroingLab;

///输入积分
@property (weak, nonatomic) IBOutlet UITextField *CoinsTextField;


@end
