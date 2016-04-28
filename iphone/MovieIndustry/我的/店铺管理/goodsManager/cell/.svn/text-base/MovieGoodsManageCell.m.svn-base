//
//  MovieGoodsManageCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieGoodsManageCell.h"
#import "MovieManagerGoodsModel.h"

@implementation MovieGoodsManageCell

- (void)awakeFromNib {

    self.goodsImg.layer.borderColor = RGBColor(212, 212, 212, 1).CGColor;
    self.rightBtn.layer.borderColor = RGBColor(212, 212, 212, 1).CGColor;
    self.goodsImg.layer.cornerRadius = 4;
    self.goodsImg.layer.masksToBounds = YES;
    self.goodsImg.contentMode = UIViewContentModeScaleAspectFill;
    
}


- (void)setGoodModel:(MovieManagerGoodsModel *)goodModel
{
    _goodModel = goodModel;
    
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,goodModel.img]] placeholderImage:[UIImage imageNamed:@""]];
    self.goodsName.text = goodModel.name;
    self.address.text = goodModel.cityId;
    self.price.text = [NSString stringWithFormat:@"￥%d",[goodModel.currentPrice intValue]];
    self.deliveryWay.text = goodModel.deliveryId;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
