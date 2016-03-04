//
//  CollectCourseCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "CollectCourseCell.h"

@implementation CollectCourseCell

- (void)awakeFromNib {
    ViewBorderRadius(self.statusLbl, 5, 0.8, [UIColor redColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
