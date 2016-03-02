//
//  MovieDeliveryTableViewCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieDeliveryTableViewCell.h"
#import "MovieOrderDeliveyMainModel.h"

@interface MovieDeliveryTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;//用户头像

@property (strong, nonatomic) IBOutlet UILabel *companyName;//快递公司名称
@property (strong, nonatomic) IBOutlet UILabel *deliveryNum;//编号
@property (strong, nonatomic) IBOutlet UILabel *deliveryStatue;//订单状态

@end

@implementation MovieDeliveryTableViewCell


- (void)setDeliveryModel:(MovieOrderDeliveyMainModel *)deliveryModel
{
    _deliveryModel = deliveryModel;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,deliveryModel.deliveryImg]] placeholderImage:[UIImage imageNamed:@"defualt_headerImg"]];
    
    self.companyName.text = deliveryModel.delivery;
    if ([deliveryModel.orderStatus isEqualToString:@"4"]) {
        self.deliveryStatue.text = [NSString stringWithFormat:@"订单状态:已评价"];
    }
    
    if ([deliveryModel.orderStatus isEqualToString:@"3"]) {
        self.deliveryStatue.text = [NSString stringWithFormat:@"订单状态:待评价"];
    }
    
    if ([deliveryModel.orderStatus isEqualToString:@"2"]) {
        self.deliveryStatue.text = [NSString stringWithFormat:@"订单状态:待收货"];
    }
    
    
}

- (void)awakeFromNib {

    self.headerImage.clipsToBounds = YES;
    self.headerImage.layer.cornerRadius = 30.0f;
    
    self.headerImage.layer.borderColor = RGBColor(212, 212, 212, 1).CGColor;
    self.headerImage.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
