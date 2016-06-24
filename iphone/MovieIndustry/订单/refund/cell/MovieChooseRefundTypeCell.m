//
//  MovieChooseRefundTypeCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieChooseRefundTypeCell.h"

@implementation MovieChooseRefundTypeCell

- (void)awakeFromNib {

    self.chooseBtn.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
