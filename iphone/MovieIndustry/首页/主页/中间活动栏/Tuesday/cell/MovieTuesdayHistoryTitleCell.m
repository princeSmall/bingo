//
//  MovieTuesdayHistoryFirstCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/7.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTuesdayHistoryTitleCell.h"
#import "MovieTuesdayRushHistoryModel.h"

@interface MovieTuesdayHistoryTitleCell ()

@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UILabel *goodNameLab;
@property (strong, nonatomic) IBOutlet UILabel *statueLab;
@property (strong, nonatomic) IBOutlet UILabel *goodCountLab;

@end

@implementation MovieTuesdayHistoryTitleCell


- (void)setTitleModel:(MovieTuesdayRushHistoryModel *)titleModel
{
    _titleModel = titleModel;
    
    //活动时间
    NSString *activetyTime = [[NSString stringWithFormat:@"%@",titleModel.shijain] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    self.timeLab.text = activetyTime ;
    
    //商品名称
    self.goodNameLab.text = titleModel.name;
    
    //活动状态
    if ([titleModel.status isEqualToString:@"0"]) {
        self.statueLab.text = @"活动进行中";
    }
    else if ([titleModel.status isEqualToString:@"1"]){
        self.statueLab.text = @"活动已结束";
    }
    else{
        self.statueLab.hidden = YES;
    }
    
    //活动商品件数
    self.goodCountLab.text = [NSString stringWithFormat:@"共%@件",titleModel.shu];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
