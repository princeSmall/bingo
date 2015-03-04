//
//  MovieCommentSecondCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCommentSecondCell.h"

@implementation MovieCommentSecondCell

- (void)awakeFromNib {

    self.textView.clipsToBounds = YES;
    self.textView.layer.cornerRadius = 10;
    self.textView.layer.borderColor = [UIColor colorWithRed:193.0f/255.0f green:193.0f/255.0f blue:193.0f/255.0f alpha:1].CGColor;
    self.textView.layer.borderWidth = 1;
    
    self.cameraBtn.clipsToBounds = YES;
    self.cameraBtn.layer.cornerRadius = 10;
    
    self.imageBg1.hidden = YES;
    self.imageBg2.hidden = YES;
    self.imageBg3.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
