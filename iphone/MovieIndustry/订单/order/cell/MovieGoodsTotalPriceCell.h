//
//  MovieGoodsTotalPriceCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieGoodsTotalPriceCell : UITableViewCell
///一共有多少价格
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsLabel;

///价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
