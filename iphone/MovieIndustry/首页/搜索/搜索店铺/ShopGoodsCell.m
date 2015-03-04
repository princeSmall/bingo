//
//  ShopGoodsCell.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/17/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "ShopGoodsCell.h"
#import "ShopGoodsModel.h"

@implementation ShopGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)config:(ShopGoodsModel*)model
{

    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]]];

    self.goodsInfoLbl.text = model.goods_name;
    
    /*商家送货,快递,自提*/
    int type = [model.goods_express intValue];
    NSString * str ;
    switch (type) {
        case 0:
            str = @"商家送货";
            break;
            
        case 1:
            str =@"快递";
            break;
        case 2:
            str =@"自提";
            break;
            
        default:
            break;
    }
    self.sendLbl.text = str;
    self.kamePriceLbl.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[model.market_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.maketPriceLbl setAttributedText:attri];
    
}

@end
