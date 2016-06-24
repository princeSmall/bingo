//
//  HistoryBuyingCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/28/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryBuyingCell : UITableViewCell
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
//等级按钮
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
//抢购时间
@property (weak, nonatomic) IBOutlet UILabel *buyingDateLbl;
//商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodNumberLbl;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLbl;

@end
