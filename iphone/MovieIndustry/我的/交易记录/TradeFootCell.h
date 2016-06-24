//
//  TradeFootCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/27/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeFootCell : UITableViewCell
//商品总数
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLabel;
//左边按钮
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
//右边按钮
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
//订单日期
@property (weak, nonatomic) IBOutlet UILabel *orderDatelbl;
//订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLbl;

@end
