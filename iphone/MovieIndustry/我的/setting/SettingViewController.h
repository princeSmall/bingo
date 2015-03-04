//
//  SettingViewController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController

@property (nonatomic,copy) NSString *locationId;

//退出登录
@property (weak, nonatomic) IBOutlet UIButton *exitLoginButton;
//开店
@property (weak, nonatomic) IBOutlet UIButton *openShopButton;
///清除缓存
@property (weak, nonatomic) IBOutlet UILabel *clearCacheLabel;

@end
