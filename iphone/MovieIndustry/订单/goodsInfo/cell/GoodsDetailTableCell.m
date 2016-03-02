//
//  GoodsDetailTableCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "GoodsDetailTableCell.h"

@implementation GoodsDetailTableCell

- (void)config:(GoodsCommentModel *)model
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.icon_img]] placeholderImage:[UIImage imageNamed:@"defualt_headerImg"]];
    self.userNickNameLabel.text = model.user_name;
    self.commentLabel.text = model.content;
    self.createTimeLabel.text = [self transformTime:model.create_time];
    
}

- (NSString *)transformTime:(NSString *)interval
{
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *timeStr = [formatter stringFromDate:timeDate];
    return timeStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
