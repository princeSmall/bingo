//
//  OrderDetailTableFooter.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableFooter : UIView
@property (strong, nonatomic) IBOutlet UILabel *postCompanyName;//公司名称
@property (strong, nonatomic) IBOutlet UILabel *price;//价格

@property (strong, nonatomic) IBOutlet UIButton *contactBtn;//联系商家按钮

@property (strong, nonatomic) IBOutlet UIButton *callNumBtn;//拨打电话按钮
@end
