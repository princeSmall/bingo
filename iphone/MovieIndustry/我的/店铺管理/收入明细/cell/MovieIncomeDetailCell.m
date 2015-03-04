//
//  MovieIncomeDetailCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/12/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieIncomeDetailCell.h"
#import "MovieIncomeDetailModel.h"

@interface MovieIncomeDetailCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UILabel *statueLab;

@end

@implementation MovieIncomeDetailCell

- (void)setIncomeModel:(MovieIncomeDetailModel *)incomeModel
{
    _incomeModel = incomeModel;
    
    [self setSubviewsNewFrame:incomeModel];
    
    self.titleLab.text = incomeModel.name;
    self.moneyLab.text = [NSString stringWithFormat:@"￥%.2f",[incomeModel.totalPrice floatValue]];
    self.timeLab.text= incomeModel.time;
    self.statueLab.text = incomeModel.names;
}

- (void)setSubviewsNewFrame:(MovieIncomeDetailModel *)model
{
    CGRect titleFrame = self.titleLab.frame;
    titleFrame.size.width = [DeliveryUtility caculateContentSizeWithContent:model.name andHight:21.0f andWidth:(screenWidth/2) andFont:DefaultFont].width;
    self.titleLab.frame = titleFrame;
    
    CGRect moneyFrame = self.moneyLab.frame;
    moneyFrame.origin.x = CGRectGetMaxX(titleFrame)+5;
    moneyFrame.size.width = 10;
    self.moneyLab.frame = moneyFrame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
