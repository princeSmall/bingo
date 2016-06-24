//
//  ShippingAddressDescController.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import "ShippingAddressModel.h"
@interface ShippingAddressDescController : BaseViewController
///收货人
@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;
///手机号
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
///邮编
@property (weak, nonatomic) IBOutlet UILabel *postCodeLabel;

///地区显示
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

///详细地址label
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
///删除地址
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

///收货地址模型
@property (nonatomic,strong) ShippingAddressModel *model;

@end
