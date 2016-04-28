//
//  CollectShopCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopSearchModel.h"

@class MovieCollectStoreModel;

@interface CollectShopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
///店铺评分view
@property (weak, nonatomic) IBOutlet UIView *shopLikesView;

@property (weak, nonatomic) IBOutlet UILabel *shopHotGoodsLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopDescLabel;

@property (nonatomic,retain) MovieCollectStoreModel *storeModel;


- (void)config:(ShopSearchModel *)model;

@end
