//
//  MyPhotosHeader.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPhotosHeader : UIView
//头像
@property (weak, nonatomic) IBOutlet UIButton *headerImageView;
//Vip
@property (weak, nonatomic) IBOutlet UIButton *vipButton;
//职业
@property (weak, nonatomic) IBOutlet UILabel *professionLabel;
//姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
