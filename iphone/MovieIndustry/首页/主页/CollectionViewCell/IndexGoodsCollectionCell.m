//
//  IndexGoodsCollectionCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "IndexGoodsCollectionCell.h"

@implementation IndexGoodsCollectionCell

- (void)config:(IndexHomeDealModel *)model
{
    self.goodsImageView.clipsToBounds = YES;
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]);
//    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]]];
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.goodsCityLabel.text  = model.goods_city_name;
    self.goodsNameLabel.text = model.goods_name;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%d",[model.goods_price intValue]];
    
    //配送
//    self.sendType?
    //押金
//    self.yajinLabel
}

- (void)awakeFromNib {
    
    self.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.layer.borderWidth = 1;
    
}

@end
