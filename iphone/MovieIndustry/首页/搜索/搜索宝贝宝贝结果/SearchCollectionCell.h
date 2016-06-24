//
//  SearchCollectionCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ShopGoodsModel;
@class BabySearchModel;
@interface SearchCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;

@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *sendType;

- (void)config:(ShopGoodsModel *)model;

@end
