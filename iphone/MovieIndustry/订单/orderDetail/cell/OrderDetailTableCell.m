//
//  OrderDetailTableCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "OrderDetailTableCell.h"

@implementation OrderDetailTableCell

- (void)config:(OrderGoodsModel *)model
{
    ///设置图片
    self.goodsImage.clipsToBounds = YES;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    
    self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.goodsNumLabel.text = [NSString stringWithFormat:@"x%@",model.goods_number];
    self.unitPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_price floatValue]];
    self.goodsAttrbuteLabel.text = [NSString stringWithFormat:@"%@",model.name_value_str];
    self.yajinLabel.text = @"￥100.00";
    
}

- (void)awakeFromNib {
    self.statusButton.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
