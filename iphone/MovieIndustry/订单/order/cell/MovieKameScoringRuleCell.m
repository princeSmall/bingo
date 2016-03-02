//
//  MovieKameScoringRuleCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieKameScoringRuleCell.h"

@interface MovieKameScoringRuleCell ()


@property (strong, nonatomic) IBOutlet UILabel *scroingLab;
@property (strong, nonatomic) IBOutlet UILabel *ruleLab;


@end

@implementation MovieKameScoringRuleCell

- (void)awakeFromNib {

    
    self.ruleLab.clipsToBounds = YES;
    self.ruleLab.layer.borderColor = RGBColor(213, 213, 213, 1).CGColor;
    self.ruleLab.layer.borderWidth = 1;
    
    self.ruleLab.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
