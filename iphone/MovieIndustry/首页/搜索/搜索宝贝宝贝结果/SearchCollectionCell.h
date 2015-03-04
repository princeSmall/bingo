//
//  SearchCollectionCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ShopGoodsModel;
@interface SearchCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCurrentPrice;

- (void)config:(ShopGoodsModel *)model;

@end
