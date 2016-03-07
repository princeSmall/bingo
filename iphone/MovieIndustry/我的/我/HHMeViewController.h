//
//  HHMeViewController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHMeViewController : BaseViewController

//消息
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

//收藏
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;

//课程
@property (weak, nonatomic) IBOutlet UIButton *courseButton;

//粉丝及好友
@property (weak, nonatomic) IBOutlet UIButton *fansAndFriendsButton;



//交易记录
@property (weak, nonatomic) IBOutlet UIButton *tradeButton;
//设置
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

//购物车
@property (weak, nonatomic) IBOutlet UIButton *carButton;
//我的相册
@property (weak, nonatomic) IBOutlet UIButton *myPhotosButton;
//店铺
@property (weak, nonatomic) IBOutlet UIButton *storeButton;

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


@property (strong, nonatomic) IBOutlet UILabel *name;//姓名

@property (strong, nonatomic) IBOutlet UIView *separeLine;

@property (strong, nonatomic) IBOutlet UILabel *career;//职业
@property (strong, nonatomic) IBOutlet UILabel *fansNum;//粉丝数量
@property (strong, nonatomic) IBOutlet UIButton *rankBtn;

@property (strong, nonatomic) IBOutlet UILabel *attentionNum;//关注数量
@property (strong, nonatomic) IBOutlet UILabel *scoring;//积分

@property (strong, nonatomic) IBOutlet UIView *storeManagerView;

@end
