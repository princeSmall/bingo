//
//  MovieTalkPersonFirstCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTalkPersonFirstCell.h"
#import "MovieArticleDetailModel.h"

@interface MovieTalkPersonFirstCell ()

@property (strong, nonatomic) IBOutlet UILabel *articleTitle;//标题
@property (strong, nonatomic) IBOutlet UILabel *comeFrom;//腾影数码
@property (strong, nonatomic) IBOutlet UILabel *createTime;//时间
@property (strong, nonatomic) IBOutlet UILabel *commentNum;//评论数量


@end

@implementation MovieTalkPersonFirstCell


- (void)setArticleModel:(MovieArticleDetailModel *)articleModel
{
    _articleModel = articleModel;
    
    self.articleTitle.text = articleModel.title;
    self.comeFrom.text = @"";
    self.createTime.text = [self transformTime:articleModel.updateTime];
    self.commentNum.text = [NSString stringWithFormat:@"%@评",articleModel.commentNumber];
    
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
