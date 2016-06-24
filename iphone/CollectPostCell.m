//
//  CollectPostCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "CollectPostCell.h"

@implementation CollectPostCell

- (void)awakeFromNib {
    ViewBorderRadius(self.tagLbl, 5, 0.5, [UIColor redColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
