//
//  CollectGoodsCell1.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "CollectGoodsCell1.h"
#import "CollectGoodsModel.h"
@implementation CollectGoodsCell1

- (void)awakeFromNib {
    // Initialization code
}

-(void )config:(CollectGoodsModel *)model
{
    [self.goodsImageView sd_setImageWithURL:[NSURL  URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    self.shopNameLbl.text = model.shop_name;
    self.goodsInfoLbl.text = model.goods_name;
    self.goodsPriceLbl.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    NSArray *array = [NSArray arrayWithObjects:@"商家送货",@"快递",@"买家自提", nil];
    self.methodLbl.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:[model.goods_express intValue]]];
    self.addressLbL.text = model.spare_address;
    self.orderTimeLbL.text=model.create_time;
   
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
