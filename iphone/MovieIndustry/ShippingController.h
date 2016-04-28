//
//  ShippingController.h
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/5.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessOrderModel.h"

@interface ShippingController : BaseViewController
@property (nonatomic, strong)BusinessOrderModel *orderModel;

@property (nonatomic ,strong)NSString *isDetail;

@end
