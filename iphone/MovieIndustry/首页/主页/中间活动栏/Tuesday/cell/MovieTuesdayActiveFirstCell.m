//
//  MovieTuesdayActiveFirstCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTuesdayActiveFirstCell.h"
#import "MovieTuesdayGoodModel.h"
#import "MovieTuesdayGoodImageModel.h"

@interface MovieTuesdayActiveFirstCell ()

@property (strong, nonatomic) IBOutlet UIImageView *goodsImage; //商品图片

@property (strong, nonatomic) IBOutlet UILabel *goodsNumLab;//商品数量

@property (strong, nonatomic) IBOutlet UILabel *goodName;//商品名称

@property (strong, nonatomic) IBOutlet UILabel *currentPrice;//咔么价

@property (strong, nonatomic) IBOutlet UILabel *originPrice;//原价

@end

@implementation MovieTuesdayActiveFirstCell


- (void)setGoodsModel:(MovieTuesdayGoodModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    //图片
    NSArray *imageArray = goodsModel.imgs;
    MovieTuesdayGoodImageModel *imageModel = [imageArray lastObject];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_PREFIX,imageModel.img]]];
    
    //商品数量
    NSInteger leveaNum = [goodsModel.number integerValue];
    if (leveaNum >= 0) {
        self.goodsNumLab.text = [NSString stringWithFormat:@"共%zd件",leveaNum];
    }
    else
        self.goodsNumLab.text = [NSString stringWithFormat:@"共%zd件",0];
    
    //商品名称
    self.goodName.text = goodsModel.dealName;
    
    //咔么价
    NSString *cPrice = [NSString stringWithFormat:@"%@元",self.goodsModel.currentPrice];
    NSMutableAttributedString *priceNow = [[NSMutableAttributedString alloc] initWithString:cPrice];
    [priceNow addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(0, cPrice.length-1)];
    self.currentPrice.attributedText = priceNow;
    
    //设置价格和下划线
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",goodsModel.originPrice];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0,oldPrice.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,oldPrice.length)];
    [self.originPrice setAttributedText:attri];
    
    [self setSubviewNewFrame:goodsModel];
}

- (void)setSubviewNewFrame:(MovieTuesdayGoodModel *)model
{
     NSString *cPrice = [NSString stringWithFormat:@"%@元",self.goodsModel.currentPrice];
    CGFloat priceW = [DeliveryUtility caculateContentSizeWithContent:cPrice andHight:21.0f andWidth:(screenWidth-180)/2 andFont:[UIFont systemFontOfSize:15.0f]].width;
    CGRect nowFrame = self.currentPrice.frame;
    nowFrame.size.width = priceW;
    self.currentPrice.frame = nowFrame;
    
    CGRect oldFrame = self.originPrice.frame;
    oldFrame.origin.x = CGRectGetMaxX(nowFrame);
    oldFrame.size.width = screenWidth-(CGRectGetMaxX(nowFrame));
    self.originPrice.frame = oldFrame;
}


- (void)awakeFromNib {

    self.startBtn.clipsToBounds = YES;
    self.startBtn.layer.cornerRadius = 5;
    
    self.goodsImage.layer.borderColor = RGBColor(212,212,212,0.5).CGColor;
    self.goodsImage.layer.borderWidth = 1.0f;
    
//    [self createScrollViewDatas];
}

#pragma mark - 加载滚动视图数据
- (void)createScrollViewDatas
{
//    CGFloat imgW = self.imageScrollView.bounds.size.width;
//    
//    //创建滚动视图
//    for (NSInteger i = 0; i < 4; i++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgW*i,0,imgW,imgW)];
//        imageView.image = [UIImage imageNamed:@"came.png"];
//        
//        [self.imageScrollView addSubview:imageView];
//    }
//    self.imageScrollView.pagingEnabled = YES;
//    self.imageScrollView.contentSize = CGSizeMake(imgW*4,imgW);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
