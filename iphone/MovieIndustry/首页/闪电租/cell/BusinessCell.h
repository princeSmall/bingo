//
//  BusinessCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 1/28/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCell : UITableViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
//商品信息
@property (weak, nonatomic) IBOutlet UILabel *goodInfoLbl;
//商品类型和颜色
@property (weak, nonatomic) IBOutlet UILabel *goodTypeLbl;
//商品咔么价
@property (weak, nonatomic) IBOutlet UILabel *goodKamePriceLbl;
//商品原价
@property (weak, nonatomic) IBOutlet UILabel *goodOrdlePriceLbl;
//商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodNumberLbl;

@end
