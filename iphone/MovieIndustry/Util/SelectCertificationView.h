//
//  SelectCertificationView.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCertificationView : UIView
///已认证
@property (nonatomic,strong) UIButton *isCertification;
///未认证
@property (nonatomic,strong) UIButton *noCertification;
///忽略
@property (nonatomic,strong) UIButton *ignore;

@end
