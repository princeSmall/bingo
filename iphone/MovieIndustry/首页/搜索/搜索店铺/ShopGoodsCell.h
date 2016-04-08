//
//  ShopGoodsCell.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/17/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopGoodsModel;

@interface ShopGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendLbl;
@property (weak, nonatomic) IBOutlet UILabel *kamePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *maketPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;

-(void)config:(ShopGoodsModel*)model;

@end
