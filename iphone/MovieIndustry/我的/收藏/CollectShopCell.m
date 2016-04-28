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

    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,storeModel.preview]]];
    self.shopNameLabel.text = storeModel.name;
    
    self.shopHotGoodsLabel.text = storeModel.shangpin;
    self.shopDescLabel.text = storeModel.brief;
     NSLog(@"没有数据 -->%@",storeModel.points);
    
//    if ([storeModel.points isEqualToString:@"0"] || [storeModel isEqual:[NSNull null]] || nil == storeModel)
//    {
//        NSLog(@"没有数据");
//    }
//    else
//    {
//        
//    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
