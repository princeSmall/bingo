//
//  IndexGoodsCollectionCell1.m
//  MovieIndustry
//
//  Created by aaa on 16/4/8.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "IndexGoodsCollectionCell1.h"

@implementation IndexGoodsCollectionCell1

- (void)awakeFromNib {
    // Initialization code
//    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
 
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    
}


- (void)config:(IndexHomeDealModel *)model{
    NSLog(@"%@",model);
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    self.name.text = model.goods_name;
//    self.price
    self.price.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    
    switch ([model.type intValue]) {
        case 0:
            self.send.hidden = NO;
            break;
            case 1:self.send.hidden = YES;break;
            case 2:self.send.hidden = YES;break;
        default:
            break;
    }
    NSString * send;
    switch ([model.goods_express intValue]) {
        case 0:
            send = @"送货上门";
            break;
        case 1:
            send = @"快递";
            break;
        case 2:
            send = @"自提";
            break;
        default:
            break;
    }
    self.send.text = send;
    
    self.place.text = model.people_location;
    self.yajin.text = [NSString stringWithFormat:@"押金￥%@",model.goods_deposit];
    
}


@end
