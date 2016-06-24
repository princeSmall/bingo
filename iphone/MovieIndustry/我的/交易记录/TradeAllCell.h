//
//  TradeAllCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/27/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeAllCell : UITableViewCell
//商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodNumber;
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
//商品名称
@property (weak, nonatomic) IBOutlet UILabel *goodTitle;
//商品描述
@property (weak, nonatomic) IBOutlet UILabel *goodAttribute;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;

@end
