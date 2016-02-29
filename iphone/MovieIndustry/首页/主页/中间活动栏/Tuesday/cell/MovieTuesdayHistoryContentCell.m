//
//  MovieTuesdayHistoryContentCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/12/7.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTuesdayHistoryContentCell.h"
#import "MovieTuesdayRushedPersonModel.h"

@interface MovieTuesdayHistoryContentCell ()
//等级label

@property (weak, nonatomic) IBOutlet UILabel *LVLabel;

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;//时间
@property (strong, nonatomic) IBOutlet UILabel *statueLab;//成功抢购
@property (strong, nonatomic) IBOutlet UILabel *goodNumLab;//商品件数



@end

@implementation MovieTuesdayHistoryContentCell


- (void)setInfoModel:(MovieTuesdayRushedPersonModel *)infoModel
{
    _infoModel = infoModel;
    
    //头像
   [self.headerImage sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=1655a14ec15c10383b7ec8c28211931c/2cf5e0fe9925bc31a365a0cc59df8db1cb1370ae.jpg"]];

    
    //姓名
    self.nameLab.text = infoModel.userName;
    
    //时间
    NSString *timeAll = [[infoModel.time componentsSeparatedByString:@" "] lastObject];
    self.timeLab.text = [timeAll substringToIndex:5];
    
    //价格及数量
    self.goodNumLab.text = [NSString stringWithFormat:@"共%@件商品 合计:￥%.2f",infoModel.number,[infoModel.totalPrice floatValue]];
}




- (void)awakeFromNib {

    self.headerImage.clipsToBounds = YES;
    self.headerImage.layer.cornerRadius = 25.0f;
    self.headerImage.layer.borderWidth = 2.0f;
    self.headerImage.layer.borderColor = RGBColor(214, 213, 210, 1).CGColor;
    self.LVLabel.layer.cornerRadius = 7.5;
    self.LVLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
