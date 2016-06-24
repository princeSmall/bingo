//
//  MovieSepcialGoodsInfoCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieSepcialGoodsInfoCell.h"
#import "MovieSpecialShowGoodIndoModel.h"

@implementation MovieSepcialGoodsInfoCell


- (void)setGoodModel:(MovieSpecialShowGoodIndoModel *)goodModel
{
    _goodModel = goodModel;
    
    self.goodsImg.clipsToBounds = YES;
    //图片
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,goodModel.img]]];
    
    //商品名称
    self.goodName.text = goodModel.name;
    
    //商品运送方式
    self.deliveryStatue.text = self.goodModel.deliveryName;
    
    //商品现价
    self.currentPrice.text = [NSString stringWithFormat:@"￥%.2f",[goodModel.currentPrice floatValue]];
    
    //商品原价
    NSString *curPrice = [NSString stringWithFormat:@"￥%.2f",[goodModel.originPrice floatValue]];
    NSUInteger length = [curPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:curPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.originPrice setAttributedText:attri];
    
    //地址
    self.address.text = goodModel.city;
}




- (void)awakeFromNib {

    self.rentBtn.clipsToBounds = YES;
    self.rentBtn.layer.cornerRadius = 3;
    self.rentBtn.layer.borderWidth = 1.0f;
    self.rentBtn.layer.borderColor = RGBColor(212, 212, 212, 0.47f).CGColor;    
    
    self.goodsImg.layer.borderWidth = 1.0f;
    self.goodsImg.layer.borderColor = RGBColor(212, 212, 212, 0.47f).CGColor;
    
    NSString *oldPrice = @"¥15320";
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.originPrice setAttributedText:attri];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
