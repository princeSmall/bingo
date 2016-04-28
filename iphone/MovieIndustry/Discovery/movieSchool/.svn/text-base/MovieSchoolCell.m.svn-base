//
//  MovieSchoolCell.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieSchoolCell.h"

@implementation MovieSchoolCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)movieNewsBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MovieNewsCell:movieNewsBtn:)]) {
        [self.delegate MovieNewsCell:self movieNewsBtn:sender];
    }
}
- (IBAction)movieClassesBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MovieNewsCell:movieClassBtn:)]) {
        [self.delegate MovieNewsCell:self movieClassBtn:sender];
    }

}

@end
