//
//  MovieSepcialGoodsInfoCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieSpecialShowGoodIndoModel;

@interface MovieSepcialGoodsInfoCell : UITableViewCell

@property (nonatomic,strong) MovieSpecialShowGoodIndoModel *goodModel;

@property (strong, nonatomic) IBOutlet UIImageView *goodsImg;
@property (strong, nonatomic) IBOutlet UILabel *goodName;
@property (strong, nonatomic) IBOutlet UILabel *deliveryStatue;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *currentPrice;

@property (strong, nonatomic) IBOutlet UILabel *originPrice;


@property (strong, nonatomic) IBOutlet UIButton *rentBtn;



@end
