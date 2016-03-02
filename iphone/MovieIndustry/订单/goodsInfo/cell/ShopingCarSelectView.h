//
//  ShopingCarSelectView.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopingCarSelectView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

//商品库存
@property (weak, nonatomic) IBOutlet UILabel *InventoryLabel;

///已选择什么
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

///颜色的滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *colorScrollView;

///减去按钮
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

///添加商品按钮
@property (weak, nonatomic) IBOutlet UIButton *addButton;
///商品数量
@property (weak, nonatomic) IBOutlet UIButton *goodsCountLabel;
///确认按钮
@property (weak, nonatomic) IBOutlet UIButton *comfirmButton;


///型号的滚动视图
@property (weak, nonatomic) IBOutlet UIScrollView *xinhaoScrollView;

@end
