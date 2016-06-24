//
//  MovieGoodsInfoCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieGoodsInfoCell.h"
#import "MovieDeliveyRelatedGoodModel.h"

@interface MovieGoodsInfoCell ()


@property (strong, nonatomic) IBOutlet UIImageView *goodImage;//商品图片
@property (strong, nonatomic) IBOutlet UILabel *goodName;//商品名称
@property (strong, nonatomic) IBOutlet UILabel *goodPrice;//价格

@property (strong, nonatomic) IBOutlet UILabel *goodColor;//颜色

@property (strong, nonatomic) IBOutlet UILabel *goodCount;//数量

@end

@implementation MovieGoodsInfoCell


- (void)setGoodsModel:(MovieDeliveyRelatedGoodModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,goodsModel.img]]];
    
    self.goodName.text = goodsModel.name;
    
    //商品颜色
    if (goodsModel.yanse.length) {
        self.goodColor.text = [NSString stringWithFormat:@"颜色分类 :%@",goodsModel.yanse];
    }
    
    //价格
    self.goodPrice.text = [NSString stringWithFormat:@"￥%.2f",[goodsModel.totalPrice floatValue]];
    
    //数量
    self.goodsModel.number = goodsModel.number;
}

- (void)awakeFromNib {

    self.goodImage.layer.borderWidth = 1.0f;
    self.goodImage.layer.borderColor = RGBColor(212, 212, 212, 1).CGColor;
    
    self.refundBtn.clipsToBounds = YES;
    self.refundBtn.layer.cornerRadius = 5;
    self.refundBtn.layer.borderWidth = 1.0f;
    self.refundBtn.layer.borderColor = RGBColor(212, 212, 212, 1).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
