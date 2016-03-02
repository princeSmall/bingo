//
//  CollectShopCell1.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "CollectShopCell1.h"
#import "ConllectShopModel.h"
@implementation CollectShopCell1

- (void)awakeFromNib {
    // Initialization code
}
/*
 //商家图片
 @property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
 //商家名称
 @property (weak, nonatomic) IBOutlet UILabel *shopNameLbL;
 //商家地址
 @property (weak, nonatomic) IBOutlet UILabel *shopAddressLbl;
 //收藏时间
 @property (weak, nonatomic) IBOutlet UILabel *conllectTimeLbl;*/
-(void)config:(ConllectShopModel *)model
{
    [self.shopImageView sd_setImageWithURL:[NSURL  URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.shop_logo]]];
    self.shopNameLbL.text = model.shop_name;
    self.shopAddressLbl.text = model.spare_address;
    self.conllectTimeLbl.text = model.create_time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
