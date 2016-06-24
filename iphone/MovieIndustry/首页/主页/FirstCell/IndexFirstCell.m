//
//  IndexFirstCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "IndexFirstCell.h"

@implementation IndexFirstCell

- (void)awakeFromNib {
    self.goodsView1.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.goodsView1.layer.borderWidth = 1;
    
    self.goodsView2.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.goodsView2.layer.borderWidth = 1;
    
    self.goodsView3.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.goodsView3.layer.borderWidth = 1;
    
    self.goodsView4.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.goodsView4.layer.borderWidth = 1;
    
    self.goodsView5.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.goodsView5.layer.borderWidth = 1;
    
    self.goodsView6.layer.borderColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1].CGColor;
    self.goodsView6.layer.borderWidth = 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
