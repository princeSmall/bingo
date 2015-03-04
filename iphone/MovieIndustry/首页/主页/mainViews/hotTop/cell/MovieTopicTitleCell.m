//
//  MovieTopicTitleCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTopicTitleCell.h"

@implementation MovieTopicTitleCell

- (void)awakeFromNib {
    self.goodImage.clipsToBounds = YES;
    
    self.publishBtn.clipsToBounds = YES;
    self.publishBtn.layer.cornerRadius = 5;
    self.publishBtn.layer.borderWidth = 1.0f;
    self.publishBtn.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
