//
//  ClassifyPostCell.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ClassifyPostCell.h"

@implementation ClassifyPostCell

- (void)awakeFromNib {
    ViewBorderRadius(self.iconImageV, 27, 0, [UIColor whiteColor]);
    ViewBorderRadius(self.levelBtn, 6, 0, [UIColor whiteColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
