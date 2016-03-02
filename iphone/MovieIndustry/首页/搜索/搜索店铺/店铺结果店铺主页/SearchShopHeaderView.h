//
//  SearchShopHeaderView.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchShopHeaderView : UIView

///店铺图片
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;


@property (weak, nonatomic) IBOutlet UIButton *shopDetailButton;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
///星星的View

@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopPhoneLabel;
///联系店家按钮
@property (weak, nonatomic) IBOutlet UIButton *shopChatButton;


@property (weak, nonatomic) IBOutlet UIButton *callPhoneButton;

@end
