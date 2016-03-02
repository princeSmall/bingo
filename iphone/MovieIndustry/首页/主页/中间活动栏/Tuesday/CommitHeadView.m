//
//  CommitHeadView.m
//  MovieIndustry
//
//  Created by aaa on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CommitHeadView.h"

@implementation CommitHeadView

- (void)awakeFromNib {
    self.icon.layer.cornerRadius =
    25;
    self.lv.layer.cornerRadius = 6;
    self.icon.layer.masksToBounds = YES;
    self.lv.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
