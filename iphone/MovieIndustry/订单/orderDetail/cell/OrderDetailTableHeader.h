//
//  OrderDetailTableHeader.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableHeader : UIView

///订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
///收货人
@property (weak, nonatomic) IBOutlet UILabel *shouhuorenLabel;
///手机
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
