//
//  MovieUserTopicDetailCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieUserTopicDetailCell.h"

@implementation MovieUserTopicDetailCell

- (void)awakeFromNib {

    self.headerImg.clipsToBounds = YES;
    self.headerImg.layer.cornerRadius = 25.0f;
    
    CGFloat imageW = (kViewWidth-35)/4;
    CGFloat imageY = CGRectGetMaxY(self.content.frame)+10;
    
    for (NSInteger i = 0; i < 4; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageW+5)*i+10, imageY, imageW, imageW)];
        imageView.image = [UIImage imageNamed:@"came.png"];
        imageView.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
        imageView.layer.borderWidth = 1.0f;
        
        [self addSubview:imageView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
