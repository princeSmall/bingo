//
//  SecondCategoryCell.m
//  MovieIndustry
//
//  Created by 童乐 Patrick on 3/10/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "SecondCategoryCell.h"

@implementation SecondCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, kViewWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.969 alpha:1.000];
    [self.contentView addSubview:lineView];
    // Configure the view for the selected state
}

@end
