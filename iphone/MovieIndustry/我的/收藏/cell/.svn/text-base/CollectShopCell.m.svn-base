//
//  CollectShopCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "CollectShopCell.h"
#import "MovieCollectStoreModel.h"

@implementation CollectShopCell

/*
 @property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
 
 @property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
 ///店铺评分view
 @property (weak, nonatomic) IBOutlet UIView *shopLikesView;
 
 @property (weak, nonatomic) IBOutlet UILabel *shopHotGoodsLabel;
 
 @property (weak, nonatomic) IBOutlet UILabel *shopDescLabel;
 */

- (void)config:(ShopSearchModel *)model
{
    self.shopImageView.clipsToBounds = YES;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,model.shopImg]]];
    self.shopNameLabel.text = model.shopName;
    
    NSString *contentStr = [NSString stringWithFormat:@"%@%.2f折",model.shangpin,[model.goodszhekou floatValue]*10];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    
    @try {
        //设置：在0-3个单位长度内的内容显示成红色
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(model.shangpin.length, contentStr.length-model.shangpin.length-1)];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    NSInteger startCount = [model.shopPoints integerValue];
    StartView *startView = [[StartView alloc] initWithFrame:CGRectMake(kViewWidth-80, 17, 70, 20)];
    [startView createStartView:startCount];
    [self.contentView addSubview:startView];
    
    self.shopHotGoodsLabel.attributedText = str;
    
    ////循环创建星星View
    ///热卖商品
//    self.shopHotGoodsLabel.text = model.shopGoods;
    ///描述
    self.shopDescLabel.text = model.shopBrief;
    
}


- (void)setStoreModel:(MovieCollectStoreModel *)storeModel
{
    _storeModel = storeModel;
    self.shopImageView.clipsToBounds = YES;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,storeModel.preview]]];
    
    //店铺名称
    self.shopNameLabel.text = storeModel.name;
    
    //热门商品
    self.shopHotGoodsLabel.text = storeModel.shangpin;
    
    //店铺简介
    self.shopDescLabel.text = storeModel.brief;
    
    CGFloat width = [DeliveryUtility caculateContentSizeWithContent:storeModel.name andHight:21.0f andWidth:(screenWidth-230) andFont:DefaultFont].width;
    CGRect nameFrame = self.shopNameLabel.frame;
    nameFrame.size.width = width;
    self.shopNameLabel.frame = nameFrame;
    
    //店铺星级
    if (!storeModel.points ||[[WNController nullString:storeModel.points] isEqualToString:@""]) {
        NSInteger startCount = 0;
        StartView *startView = [[StartView alloc] initWithFrame:CGRectMake(kViewWidth-80, 17, 70, 20)];
        [startView createStartView:startCount];
        [self.contentView addSubview:startView];
    }else
    {
        NSInteger startCount = [storeModel.points integerValue];
        StartView *startView = [[StartView alloc] initWithFrame:CGRectMake(kViewWidth-80, 17, 70, 20)];
        [startView createStartView:startCount];
        [self.contentView addSubview:startView];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
