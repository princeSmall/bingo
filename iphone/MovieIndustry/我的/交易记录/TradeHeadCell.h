//
//  TradeHeadCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/27/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeHeadCell : UITableViewCell
//店铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
//进入店铺按钮
@property (weak, nonatomic) IBOutlet UIButton *enterShopBtn;
//箭头位置
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end
