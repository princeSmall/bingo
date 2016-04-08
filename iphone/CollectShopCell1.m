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
    self.shopImageView.layer.cornerRadius = 4;
    self.shopImageView.layer.masksToBounds = YES;
    self.shopImageView.contentMode = UIViewContentModeScaleAspectFill;
    
}
-(void)config:(ConllectShopModel *)model
{
    [self.shopImageView sd_setImageWithURL:[NSURL  URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.shop_logo]]];
    self.shopNameLbL.text = model.shop_name;
    
//    [NSString stringWithFormat:@"%@%@%@",]
    
    self.shopAddressLbl.text = model.city_name;
    self.conllectTimeLbl.text = model.create_time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse
{
    [super prepareForReuse];
}
@end
