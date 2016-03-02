//
//  IndexGoodsCollectionCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexHomeDealModel.h"

@interface IndexGoodsCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsCityLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

///数据模型
- (void)config:(IndexHomeDealModel *)model;

@end
