//
//  ClassifyHeadCell.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ClassifyHeadCell.h"

@implementation ClassifyHeadCell

- (void)awakeFromNib {
    ViewBorderRadius(self.postingBtn, 5, 0.3, [UIColor lightGrayColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
