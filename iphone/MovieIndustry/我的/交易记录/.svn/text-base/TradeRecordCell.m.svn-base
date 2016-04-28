//
//  TradeRecordCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/8.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "TradeRecordCell.h"
#import "MovieTradeRecordModel.h"

@interface TradeRecordCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;


@end

@implementation TradeRecordCell


- (void)setRecordModel:(MovieTradeRecordModel *)recordModel
{
    _recordModel = recordModel;
    
    self.titleLab.text = recordModel.name;
    
    self.timeLab.text = recordModel.time;
    
    self.moneyLab.text = recordModel.totalPrice;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
