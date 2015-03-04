//
//  SearchCollectionCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SearchCollectionCell.h"
#import "ShopGoodsModel.h"
@implementation SearchCollectionCell

/*
 @property (nonatomic,copy)NSString *goods_express;
 @property (nonatomic,copy)NSString *goods_id;
 @property (nonatomic,copy)NSString *goods_name;
 @property (nonatomic,copy)NSString *goods_price;
 @property (nonatomic,copy)NSString *img_path;
 @property (nonatomic,copy)NSString *market_price;
 
 */

- (void)config:(ShopGoodsModel *)model
{
    self.goodsImageView.clipsToBounds = YES;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]]];
    self.goodsNameLabel.text = model.goods_name;
    //    self.postFeeLabel.text = model
    //self.goodsCityLabel.text = model.goodsCity;
    self.goodsCurrentPrice.text = model.goods_price;
    
    @try {
        ///设置价格和下划线
        NSString *oldPrice = [NSString stringWithFormat:@"￥%@",model.market_price];
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
        [self.oldPriceLabel setAttributedText:attri];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

- (void)awakeFromNib {
    NSString *oldPrice = @"¥15320";
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.oldPriceLabel setAttributedText:attri];
}

@end
