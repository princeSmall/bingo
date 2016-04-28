//
//  IndexGoodsCollectionCell1.h
//  MovieIndustry
//
//  Created by aaa on 16/4/8.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexHomeDealModel.h"

@interface IndexGoodsCollectionCell1 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *yajin;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *send;


- (void)config:(IndexHomeDealModel *)model;

@end
