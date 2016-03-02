//
//  RentGoodsChooseCell.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/29/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentGoodsChooseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *kamePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLbl;



@end
