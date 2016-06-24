//
//  ReciveMesCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ReciveMesCell.h"
#import "MovieMineReceiveNeedsModel.h"
#import "MovieReceiveNeedsOtherInfo.h"

@interface ReciveMesCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *profressionLab;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *keywordLab;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;
@property (strong, nonatomic) IBOutlet UILabel *timeStr;

@property (strong, nonatomic) IBOutlet UILabel *distanceLab;
@property (strong, nonatomic) IBOutlet UIView *line;


@end

@implementation ReciveMesCell

- (void)awakeFromNib {
    // Initialization code
    
    self.knockBtn.clipsToBounds = YES;
    self.knockBtn.layer.cornerRadius = 5.0f;
    self.knockBtn.layer.borderColor = RGBColor(212, 212, 212, 1).CGColor;
    self.knockBtn.layer.borderWidth = 1.0f;
}

- (void)setReceiveModel:(MovieMineReceiveNeedsModel *)receiveModel
{
    _receiveModel = receiveModel;
    
    MovieReceiveNeedsOtherInfo *infoModel = receiveModel.otherInfo;
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,infoModel.iconImg]] placeholderImage:[UIImage imageNamed:@"defualt_headerImg"]];
    self.nameLab.text = infoModel.nikename;
    
    //距离
    CGFloat distance = [infoModel.juli floatValue]/1000.0;
    self.distanceLab.text = [NSString stringWithFormat:@"距离%.1fKm",distance];
    
    self.profressionLab.text = infoModel.profession;
    self.titleLab.text = [NSString stringWithFormat:@"%@  %@  %@",infoModel.cityName,infoModel.priceName,infoModel.cateName];
    self.keywordLab.text = [NSString stringWithFormat:@"关键词 : %@",infoModel.keyword];
    self.remarkLab.text = [NSString stringWithFormat:@"备注 : %@",infoModel.remark];
    self.timeStr.text = [NSString stringWithFormat:@"发布时间 : %@",[self timeIntervalTurnTime:infoModel.addTime]];
    
    [self setNewFrameBaseModel:infoModel];
}

- (void)setNewFrameBaseModel:(MovieReceiveNeedsOtherInfo *)model
{
    CGRect nameFrame = self.nameLab.frame;
    nameFrame.size.width = [DeliveryUtility caculateContentSizeWithContent:model.nikename andHight:21.0f andWidth:(kViewWidth-250) andFont:[UIFont systemFontOfSize:16.0f]].width;
    self.nameLab.frame = nameFrame;
    
    CGRect lineFrame = self.line.frame;
    lineFrame.origin.x = CGRectGetMaxX(nameFrame)+5;
    self.line.frame = lineFrame;
    
    CGRect careerFrame = self.profressionLab.frame;
    careerFrame.origin.x = CGRectGetMaxX(lineFrame)+5;
    careerFrame.size.width = (kViewWidth-nameFrame.size.width - 150);
    self.profressionLab.frame = careerFrame;
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
