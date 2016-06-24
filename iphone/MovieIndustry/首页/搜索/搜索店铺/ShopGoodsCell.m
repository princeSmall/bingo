//
//  ShopGoodsCell.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/17/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "ShopGoodsCell.h"
#import "ShopGoodsModel.h"
#import "CollectGoodsModel.h"
#import "BabySearchModel.h"


@implementation ShopGoodsCell

- (void)awakeFromNib {
    self.goodsImageView.layer.cornerRadius = 4;
    self.goodsImageView.layer.masksToBounds = YES;
    
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)configDs:(BabySearchModel*)model
{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]]];
    
    self.goodsInfoLbl.text = model.goods_name;
    
    /*商家送货,快递,自提*/
    int type = [model.goods_express intValue];
    NSString * str ;
    switch (type) {
        case 0:
            str = @"送货上门";
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
    
    if (![model.type isEqualToString:@"0"]) {
        self.sendLbl.text = @"";
    }
    self.kamePriceLbl.text = [NSString stringWithFormat:@"¥%d",[model.goods_price intValue]];
    if (model.goods_deposit) {
        self.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_deposit  floatValue]];;
    }else{
        self.yajinLabel.text = @"￥0.00";
    }
    
    self.addres.text = model.people_location;
}






-(void)configD:(CollectGoodsModel*)model
{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,model.img_path]]];
    
    self.goodsInfoLbl.text = model.goods_name;
    
    /*商家送货,快递,自提*/
    int type = [model.goods_express intValue];
    NSString * str ;
    switch (type) {
        case 0:
            str = @"送货上门";
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
    
    if (![model.type isEqualToString:@"0"]) {
        self.sendLbl.text = @"";
    }
    self.kamePriceLbl.text = [NSString stringWithFormat:@"¥%.2f",[model.goods_price floatValue]];
    if (model.goods_deposit) {
        self.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_deposit  floatValue]];;
    }else{
        self.yajinLabel.text = @"￥0.00";
    }

    self.addres.text = model.perple_location;
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
            str = @"送货上门";
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
    
    if ([model.goods_express isEqualToString:@""]) {
        self.sendLbl.text = @"";
    }
    self.kamePriceLbl.text = [NSString stringWithFormat:@"¥%.2f",[model.goods_price floatValue]];
    if (model.goods_deposit) {
        self.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_deposit  floatValue]];;
    }else{
        self.yajinLabel.text = @"￥100.00";
    }
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[model.market_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.maketPriceLbl setAttributedText:attri];
    self.addres.text = model.people_location;
}

@end
