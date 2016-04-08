//
//  MovieShopCarGoodInfoCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieShopCarGoodInfoCell.h"

@implementation MovieShopCarGoodInfoCell
/*
 @property (strong, nonatomic) IBOutlet UIButton *chooseBtn;//选择按钮
 @property (strong, nonatomic) IBOutlet UIImageView *goodImage;//商品图片
 
 @property (strong, nonatomic) IBOutlet UILabel *goodName;//商品名称
 
 @property (strong, nonatomic) IBOutlet UILabel *goodColor;//商品颜色
 
 @property (strong, nonatomic) IBOutlet UILabel *currentPrice;//商品现价
 @property (strong, nonatomic) IBOutlet UILabel *originPrice;//原价
 
 @property (strong, nonatomic) IBOutlet UILabel *goodCount;//商品数量
 */

- (void)config:(CartGood *)model
{
    
    self.goodImage.layer.cornerRadius = 4;
    self.goodImage.layer.masksToBounds = YES;
    self.goodImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    self.goodName.text = model.goods_name;
    self.goodColor.text = [NSString stringWithFormat:@"%@",model.name_value_str];
    self.currentPrice.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_price floatValue]];
    self.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_deposit floatValue]];
    self.goodCount.text = [NSString stringWithFormat:@"x%@",model.goods_number];
    
    
    ///设置价格和下划线
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[model.market_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.originPrice setAttributedText:attri];
    
    
    if (model.selectState) {
        [self.chooseBtn setImage:[UIImage imageNamed:@"tick_on"] forState:UIControlStateNormal];
    }else
    {
        [self.chooseBtn setImage:[UIImage imageNamed:@"tick_off"] forState:UIControlStateNormal];
    }
    
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
