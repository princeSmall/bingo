//
//  AllOrderCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^refounFn)();

@interface AllOrderCell : UITableViewCell


//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
///商品标题
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
///商品单价
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
///商品属性
@property (weak, nonatomic) IBOutlet UILabel *goodsAttrbuteLabel;
//商品数目
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;

//押金label
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;
//退款按钮
@property (weak, nonatomic) IBOutlet UIButton *refounBtn;

@property (nonatomic ,copy) refounFn refounFn;

- (void)config:(NSDictionary *)model;


@end
