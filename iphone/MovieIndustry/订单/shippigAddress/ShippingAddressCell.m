//
//  ShippingAddressCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/5.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShippingAddressCell.h"

@implementation ShippingAddressCell

- (void)config:(ShippingAddressModel *)model
{
    self.consigneeLabel.text = model.consignee;
    //这边收货地址的拼接  富文本的[默认] 和随后的收货地址
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@",model.regionArea,model.address];
    self.statsuButton.alpha = 0;
    if (model.moren) {
        NSString * addressStr = [NSString stringWithFormat:@"[默认] 收货地址：%@%@",model.regionArea,model.address];
        NSMutableAttributedString * addressAttr = [[NSMutableAttributedString alloc]initWithString:addressStr];
        [addressAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
        [addressAttr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(4, addressStr.length - 4)];
        self.addressLabel.attributedText = addressAttr;
        self.statsuButton.alpha = 1;
    }
    self.telPhoneLabel.text = model.tel;
    if ([model.status isEqualToString:@"1"]) {
        
//        self.consigneeLabel.textColor = [UIColor whiteColor];
//        self.addressLabel.textColor = [UIColor whiteColor];
//        self.telPhoneLabel.textColor = [UIColor whiteColor];
//        self.statsuButton.alpha = 1;
//        self.bgView.backgroundColor = [UIColor colorWithRed:0.46 green:0.47 blue:0.51 alpha:1];
//        self.bgView.backgroundColor = [UIColor greenColor];
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   UIColor * color = [[UIColor alloc]initWithRed:190.0/255 green:0.0/255 blue:0.0/255 alpha:1];

    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass([subView class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            ((UIView *)[subView.subviews firstObject]).backgroundColor = color;
        }
    }
}



@end
