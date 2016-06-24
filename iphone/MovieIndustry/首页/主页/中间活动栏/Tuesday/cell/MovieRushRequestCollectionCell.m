//
//  MovieRushRequestCollectionCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/8.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieRushRequestCollectionCell.h"
#import "MovieNeedsRushedGoodsInfoModel.h"

@interface MovieRushRequestCollectionCell ()

@property (strong, nonatomic) IBOutlet UIImageView *goodsImg;

@property (strong, nonatomic) IBOutlet UILabel *goodNameLab;

@property (strong, nonatomic) IBOutlet UILabel *currentPriceLab;

@property (strong, nonatomic) IBOutlet UILabel *originPriceLab;
@end

@implementation MovieRushRequestCollectionCell


- (void)setGoodModel:(MovieNeedsRushedGoodsInfoModel *)goodModel
{
    _goodModel = goodModel;
    
    //商品图片
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,goodModel.img]]];
    
    //商品名称
    self.goodNameLab.text = goodModel.name;
    
    //商品现价
    self.currentPriceLab.text = [NSString stringWithFormat:@"￥%.0f",[goodModel.currentPrice floatValue]];
    
    //设置原价和下划线
    NSString *originPriceStr = [NSString stringWithFormat:@"￥%.0f",[goodModel.originPrice floatValue]];
    NSUInteger length = [originPriceStr length];
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:originPriceStr];
    [oldPriceAtt addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [oldPriceAtt addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    self.originPriceLab.attributedText = oldPriceAtt;
    
    
    [self setTwoPrcieNewFrame:goodModel];
}

- (void)setTwoPrcieNewFrame:(MovieNeedsRushedGoodsInfoModel *)model
{
    NSString *currentPrice = [NSString stringWithFormat:@"￥%.0f",[model.currentPrice floatValue]];
     
    CGFloat cellW = (screenWidth-30)/3;
    
    CGFloat currentPriceW = [DeliveryUtility caculateContentSizeWithContent:currentPrice andHight:21 andWidth:cellW andFont:[UIFont systemFontOfSize:13.0f]].width;
    
    CGRect currentPriceFrame = self.currentPriceLab.frame;
    currentPriceFrame.size.width = currentPriceW;
    self.currentPriceLab.frame = currentPriceFrame;
    
    CGFloat originPriceW = (cellW-currentPriceW);
    CGRect originPriceFrame = self.originPriceLab.frame;
    originPriceFrame.origin.x = CGRectGetMaxX(currentPriceFrame)+3;
    originPriceFrame.size.width = originPriceW;
    self.originPriceLab.frame = originPriceFrame;
}


- (void)awakeFromNib {

    self.layer.borderColor = RGBColor(220,220, 220, 1).CGColor;
    self.layer.borderWidth = 1.0f;
}

@end
