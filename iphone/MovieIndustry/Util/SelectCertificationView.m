//
//  SelectCertificationView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SelectCertificationView.h"

@implementation SelectCertificationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kViewBackColor;
        self.isCertification = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth, 49) ImageName:@"" Target:nil Action:nil Title:@"已认证" fontSize:16];
        self.isCertification.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.isCertification];
        
        self.noCertification = [WNController createButtonWithFrame:CGRectMake(0, 50, kViewWidth, 49) ImageName:@"" Target:nil Action:nil Title:@"未认证" fontSize:16];
        self.noCertification.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.noCertification];
        
        self.ignore = [WNController createButtonWithFrame:CGRectMake(0, 100, kViewWidth, 49) ImageName:@"" Target:nil Action:nil Title:@"不限" fontSize:16];
        self.ignore.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.ignore];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
