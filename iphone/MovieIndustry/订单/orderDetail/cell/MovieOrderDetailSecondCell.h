//
//  MovieOrderDetailSecondCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieOrderDetailSecondCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *companyName;//公司名称
@property (strong, nonatomic) IBOutlet UILabel *price;//价格

@property (strong, nonatomic) IBOutlet UIButton *contactBtn;//联系商家按钮

@property (strong, nonatomic) IBOutlet UIButton *callNumBtn;//拨打电话按钮

@end
