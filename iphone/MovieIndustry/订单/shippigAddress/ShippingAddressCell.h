//
//  ShippingAddressCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/5.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShippingAddressModel.h"
@interface ShippingAddressCell : UITableViewCell
///

@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *telPhoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *statsuButton;

@property (weak, nonatomic) IBOutlet UIView *bgView;

- (void)config:(ShippingAddressModel *)model;

@end
