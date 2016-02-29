//
//  AllOrderCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "AllOrderCell.h"

@implementation AllOrderCell

/*
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
 */

- (void)config:(NSDictionary *)model
{
    ///设置图片
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model[@"img_path"]]]];
    
    self.goodsTitleLabel.text = [NSString stringWithFormat:@"%@",model[@"goods_name"]];
    self.goodsNumLabel.text = [NSString stringWithFormat:@"x%@",model[@"goods_number" ]];
    self.unitPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model[@"goods_price"] floatValue]];
    self.goodsAttrbuteLabel.text = [NSString stringWithFormat:@"%@",model[@"name_value_str"]];
    self.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[model[@"goods_deposit"] floatValue]];
    
    
    
}

- (void)awakeFromNib {
    self.goodsImage.layer.borderColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1].CGColor;
    self.goodsImage.layer.borderWidth = 1.0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
