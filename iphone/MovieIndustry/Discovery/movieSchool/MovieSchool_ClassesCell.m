//
//  MovieSchool_ClassesCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieSchool_ClassesCell.h"

@implementation MovieSchool_ClassesCell

- (void)awakeFromNib {
ViewBorderRadius(self.imagV, 3, 0, [UIColor whiteColor]);}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setRankingImgStr:(NSString *)rankingImgStr {
    _rankingImgStr = rankingImgStr;
    self.rankingImgV.image = [UIImage imageNamed:rankingImgStr];

}
@end
