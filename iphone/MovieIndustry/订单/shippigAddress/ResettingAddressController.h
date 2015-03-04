//
//  ResettingAddressController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import "ShippingAddressModel.h"

@protocol ResettingAddressControllerDelegate <NSObject>

- (void)setConsignee:(NSString *)consignee andPhoneNumber:(NSString *)phoneNumber andAddress:(NSString *)address andPostCode:(NSString *)postCode andProviceArea:(NSString *)proviceArea;

- (void)sendModel:(ShippingAddressModel*)model;


@end

@interface ResettingAddressController : BaseViewController
//收货人
@property (weak, nonatomic) IBOutlet UITextField *consigneeTextField;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;


///详细地址
@property (weak, nonatomic) IBOutlet UITextView *addressDetailTextView;

///邮政编码
@property (weak, nonatomic) IBOutlet UITextField *postCodeLabel;
///选择省市区
@property (weak, nonatomic) IBOutlet UIButton *proviceAreaButton;

@property (nonatomic,weak) id<ResettingAddressControllerDelegate>delegate;

///收货地址模型
@property (nonatomic,strong) ShippingAddressModel *model;

@end
