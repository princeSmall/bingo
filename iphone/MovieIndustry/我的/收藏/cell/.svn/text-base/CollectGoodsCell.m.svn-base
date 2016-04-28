//
//  CollectGoodsCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "CollectGoodsCell.h"
#import "MovieMineCollectGoodsModel.h"
#import "GoodCollectionInfo.h"

@implementation CollectGoodsCell

- (void)config:(BabySearchModel *)model
{
    self.goodImage.clipsToBounds = YES;
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX2,model.goodsImg]]];
    self.goodsTitleLabel.text = model.goodsName;
//    self.postFeeLabel.text = model
    self.addressLabel.text = model.goodsCity;
    self.currentPriceLabel.text = model.goodsCurrentPrice;
    self.postFeeLabel.text = model.songhuo;
    
    
    @try {
        ///设置价格和下划线
        NSString *oldPrice = [NSString stringWithFormat:@"￥%@",model.goodsOriginPrice];
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





#pragma mark - 我的收藏界面数据
- (void)setGoodModel:(MovieMineCollectGoodsModel *)goodModel
{
    _goodModel = goodModel;
    
    self.bottomLine.hidden = YES;
    
    GoodCollectionInfo *infoModel = goodModel.info;
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,infoModel.img]]];
    self.goodsTitleLabel.text = infoModel.name;
    
    self.postFeeLabel.text = infoModel.deliveryId;
    self.addressLabel.text = infoModel.cityname;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"%.2f",[infoModel.currentPrice floatValue]];
    
    ///设置价格和下划线
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[infoModel.originPrice floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.oldPriceLabel setAttributedText:attri];
}



- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
