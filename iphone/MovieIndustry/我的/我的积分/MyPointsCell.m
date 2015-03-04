//
//  MyPointsCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyPointsCell.h"
#import "MovieMinePointRecordModel.h"


@interface MyPointsCell ()

@property (strong, nonatomic) IBOutlet UILabel *pointTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UILabel *pointNumLab;

@end

@implementation MyPointsCell


- (void)setPointModel:(MovieMinePointRecordModel *)pointModel
{
    _pointModel = pointModel;
    
    //积分类型
    self.pointTitleLab.text = pointModel.jfTitle;
    
    //积分时间
    self.timeLab.text = [self transformTime:pointModel.jfTime];
    
    //积分数量
    self.pointNumLab.text = [NSString stringWithFormat:@"+%@",pointModel.jfPoints];
}


- (NSString *)transformTime:(NSString *)interval
{
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
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
