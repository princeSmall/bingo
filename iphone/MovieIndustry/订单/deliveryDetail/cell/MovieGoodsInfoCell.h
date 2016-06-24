//
//  MovieGoodsInfoCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieDeliveyRelatedGoodModel;

@interface MovieGoodsInfoCell : UITableViewCell

@property (nonatomic,strong) MovieDeliveyRelatedGoodModel *goodsModel;

@property (strong, nonatomic) IBOutlet UIButton *refundBtn;

@end
