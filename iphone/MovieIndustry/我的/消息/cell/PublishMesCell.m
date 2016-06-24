//
//  PublishMesCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PublishMesCell.h"
#import "MovieMineIssueNeedsModel.h"

@interface PublishMesCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *personLab;
@property (strong, nonatomic) IBOutlet UILabel *keywordLab;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;


@end

@implementation PublishMesCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setNeedModel:(MovieMineIssueNeedsModel *)needModel
{
    _needModel = needModel;
    
    self.titleLab.text = [NSString stringWithFormat:@"%@  %@  %@",needModel.cityName,needModel.priceName,needModel.cateName];
    self.personLab.text = [NSString stringWithFormat:@"%@人抢单",needModel.numerate];
    self.keywordLab.text = [NSString stringWithFormat:@"关键词 : %@",needModel.keyword];
    self.remarkLab.text = [NSString stringWithFormat:@"备注 : %@",needModel.remark];
    self.timeLab.text = [NSString stringWithFormat:@"发布时间 : %@",[self timeIntervalTurnTime:needModel.addTime]];
}

- (NSString *)timeIntervalTurnTime:(NSString *)interval
{
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *timeStr = [formatter stringFromDate:timeDate];
    return timeStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
