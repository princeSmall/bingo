//
//  NewMessageCell.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "NewMessageCell.h"

@implementation NewMessageCell

- (void)awakeFromNib {
    ViewBorderRadius(self.FilmTimeNewMsgContentV, 23, 0, [UIColor blackColor]);
    ViewBorderRadius(self.iconImage, 23, 0.2, [UIColor whiteColor]);
}
- (IBAction)newMsgBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(NewMessageCell:btn:)]) {
        [self.delegate NewMessageCell:self btn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
