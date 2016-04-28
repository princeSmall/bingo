//
//  CollectShopCell1.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "CollectShopCell1.h"
#import "ConllectShopModel.h"
#import "IconStorlView.h"
#import "StarView.h"
@interface CollectShopCell1()

@property (nonatomic,strong)StarView * storV;

@end


@implementation CollectShopCell1

- (void)awakeFromNib {
    // Initialization code
    self.shopImageView.layer.cornerRadius = 4;
    self.shopImageView.layer.masksToBounds = YES;
    self.shopImageView.contentMode = UIViewContentModeScaleAspectFill;
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
    [self.storV removeFromSuperview];
    IconStorlView *iconView = [[IconStorlView alloc]initWithFrame:CGRectMake(self.shopNameLbL.frame.origin.x-2, 32, 88, 16) AndScore:[model.sale_count intValue]];
    [self addSubview:iconView];
    self.storV = [[StarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+10, 32, 88, 16) score:[model.score intValue] canscore:@"0"];

    [self addSubview:self.storV];
    [self.shopImageView sd_setImageWithURL:[NSURL  URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.shop_logo]]];
    self.shopNameLbL.text = model.shop_name;
    self.shopAddressLbl.text = model.spare_address;

        //简介
    self.content.text = model.shop_desc;
    //主营
   // self.shopAddressLbl.text = model.shop_addr_detail;
    
    
    self.conllectTimeLbl.text = @"";
    @try {
        NSArray * arr = [model.category_id componentsSeparatedByString:@"3"];
    
        NSMutableString  * str = [NSMutableString string];
        if ([arr[0] isEqualToString:@"1"]) {
            [str appendFormat:@"器材 "];
        }if ([arr[1] isEqualToString:@"1"]) {
            [str appendFormat:@"人员 "];
        }
        if ([arr[2] isEqualToString:@"1"]) {
            [str appendFormat:@"场地"];
        }
        self.conllectTimeLbl.text = str;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
    
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
