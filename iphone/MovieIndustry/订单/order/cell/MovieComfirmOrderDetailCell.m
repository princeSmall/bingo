//
//  MovieComirmOrderDetailCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieComfirmOrderDetailCell.h"
#import "GoodDesModel.h"


@implementation MovieComfirmOrderDetailCell

/*@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
 
 @property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
 ///分类属性
 @property (weak, nonatomic) IBOutlet UILabel *goodsAttributeLabel;
 ///现在的价格
 @property (weak, nonatomic) IBOutlet UILabel *currenPriceLabel;
 ///老的价格
 @property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
 
 ///商品数量
 @property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;*/

- (void)initCGood:(CartGood *)model{

    self.goodsNameLabel.text = model.goods_name;
    
    
    
      [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    
    self.goodsAttributeLabel.text =[NSString stringWithFormat:@"颜色：%@,型号：%@",@"默认",@"默认"];
   self.currenPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_price floatValue]];
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[model.market_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.oldPriceLabel setAttributedText:attri];
}



- (void)config:(GoodDesModel *)model Andtype:(NSString *)type
{

    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.imgs[0]]]];
    
    self.goodsNameLabel.text = model.goods_name;
    self.goodsAttributeLabel.text = [NSString stringWithFormat:@"颜色：%@,型号：%@",@"默认",@"默认"];
    self.currenPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goods_price floatValue]];

    
    
    ///设置价格和下划线
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[model.market_price floatValue]];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.oldPriceLabel setAttributedText:attri];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
