//
//  RushOrdersCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RushOrdersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *saleNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsCityLbl;
@property (weak, nonatomic) IBOutlet UILabel *kamePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLbl;

@end
