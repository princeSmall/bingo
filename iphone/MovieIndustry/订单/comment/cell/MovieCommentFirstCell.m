//
//  MovieCommentFirstCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCommentFirstCell.h"

@interface MovieCommentFirstCell ()



@end

@implementation MovieCommentFirstCell

- (void)awakeFromNib {
    self.goodImg.layer.cornerRadius = 2;
    self.goodImg.layer.masksToBounds = YES;
    self.goodImg.layer.borderColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1].CGColor;
    self.goodImg.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
