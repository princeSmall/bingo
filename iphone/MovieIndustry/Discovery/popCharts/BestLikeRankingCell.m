//
//  BestLikeRankingCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/29.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "BestLikeRankingCell.h"

@implementation BestLikeRankingCell

- (void)awakeFromNib {
    self.rankingImagV.layer.cornerRadius = 37;
    self.rankingImagV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
