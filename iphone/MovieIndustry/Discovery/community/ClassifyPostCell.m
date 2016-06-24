//
//  ClassifyPostCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ClassifyPostCell.h"

@implementation ClassifyPostCell

- (void)awakeFromNib {
    ViewBorderRadius(self.iconImageV, 20, 0, [UIColor whiteColor]);
    ViewBorderRadius(self.levelBtn, 5, 0, [UIColor whiteColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    CGFloat margin = 10;
    CGFloat imageW = (kViewWidth - 5 * margin) /4;
    CGFloat imageH = self.imageContentV.frame.size.height - 2 * margin;
    for (int i = 0; i < imageArray.count; i ++ ) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.imageContentV addSubview:imageV];
        imageV.image = [UIImage imageNamed:imageArray[i]];
        CGFloat imageX = margin * ( i+1 ) + imageW * i;
        imageV.frame = CGRectMake(imageX, margin, imageW, imageH);
    }
}
@end
