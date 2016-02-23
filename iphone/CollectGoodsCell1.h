//
//  CollectGoodsCell1.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 2/5/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectGoodsModel;

@interface CollectGoodsCell1 : UITableViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
//商铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLbl;
//商品信息
@property (weak, nonatomic) IBOutlet UILabel *goodsInfoLbl;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLbl;
//送货方式
@property (weak, nonatomic) IBOutlet UILabel *methodLbl;
//商品地址
@property (weak, nonatomic) IBOutlet UILabel *addressLbL;
//收藏时间
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLbL;
//联系商家
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;

@property (nonatomic,strong)CollectGoodsModel *model;
-(void )config:(CollectGoodsModel *)model;
@end
