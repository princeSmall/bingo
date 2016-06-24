//
//  ShopGoodsCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 2/17/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopGoodsModel;
#import "CollectGoodsModel.h"
#import "BabySearchModel.h"
@interface ShopGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendLbl;
@property (weak, nonatomic) IBOutlet UILabel *kamePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *maketPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;
@property (weak, nonatomic) IBOutlet UILabel *addres;

-(void)config:(ShopGoodsModel*)model;
-(void)configD:(CollectGoodsModel*)model;
-(void)configDs:(BabySearchModel *)model;
@end
