//
//  ShippingAddressController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"

@protocol ShippingAddressControllerDelegate <NSObject>

- (void)backleftViewController;

@end

@interface ShippingAddressController : BaseViewController
//收货人
@property (weak, nonatomic) IBOutlet UITextField *consigneeTextField;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;

@property (weak, nonatomic) IBOutlet UITextField *telPhone;

///详细地址
@property (weak, nonatomic) IBOutlet UITextView *addressDetailTextView;


///邮政编码
@property (weak, nonatomic) IBOutlet UITextField *postCodeLabel;
///选择省市区
@property (weak, nonatomic) IBOutlet UIButton *proviceAreaButton;

@property (weak, nonatomic) id <ShippingAddressControllerDelegate>delegate;

@property (assign, nonatomic) BOOL isQuerenOrder;

@end
