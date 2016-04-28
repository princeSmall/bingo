//
//  SearchCollectionCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SearchCollectionCell.h"
#import "ShopGoodsModel.h"
#import "BabySearchModel.h"
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
    
    if (model.goods_deposit) {
        self.yajinLabel.text = [NSString stringWithFormat:@"押金￥%d",[model.goods_deposit intValue]];
    }else{
    self.yajinLabel.text = @"￥0.00";
    }
    
    
    //    self.postFeeLabel.text = model
    //self.goodsCityLabel.text = model.goodsCity;
    self.goodsCurrentPrice.text = [NSString stringWithFormat:@"￥%d",[model.goods_price intValue]];
    
    
    @try {
        ///设置价格和下划线
        NSString *oldPrice = [NSString stringWithFormat:@"￥%d",[model.market_price intValue]];
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
        [self.oldPriceLabel setAttributedText:attri];
        
        self.goodsCityLabel.text = model.people_location;

        switch ([model.goods_express intValue]) {
            case 0:
                self.sendType.text = @"送货上门";
                break;
            case 1:
                self.sendType.text = @"快递";
                break;
            case 2:
                self.sendType.text = @"自提";
                break;
            default:
                break;
        }
        if ([model.goods_express isEqualToString:@""]) {
             self.sendType.text = @"";
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)searchConfig:(BabySearchModel *)model
{
    self.goodsImageView.clipsToBounds = YES;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]]];
    self.goodsNameLabel.text = model.goods_name;
    
    if (model.goods_deposit) {
        self.yajinLabel.text = [NSString stringWithFormat:@"押金￥%d",[model.goods_deposit intValue]];
    }else{
        self.yajinLabel.text = @"￥100.00";
    }
    
    
    //    self.postFeeLabel.text = model
    //self.goodsCityLabel.text = model.goodsCity;
    self.goodsCurrentPrice.text = [NSString stringWithFormat:@"￥%d",[model.goods_price intValue]];
    
    
    @try {
        ///设置价格和下划线
//        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[model.market_price floatValue]];
//        NSUInteger length = [oldPrice length];
//        
//        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
//        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//        [self.oldPriceLabel setAttributedText:attri];
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
