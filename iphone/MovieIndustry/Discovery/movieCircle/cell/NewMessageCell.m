//
//  NewMessageCell.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "NewMessageCell.h"

@implementation NewMessageCell

- (void)awakeFromNib {
    ViewBorderRadius(self.msgContentV, 23, 0, [UIColor blackColor]);
    ViewBorderRadius(self.msgIconV, 23, 0.2, [UIColor whiteColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
