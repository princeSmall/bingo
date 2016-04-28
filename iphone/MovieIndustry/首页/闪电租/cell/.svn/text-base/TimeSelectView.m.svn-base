//
//  TimeSelectView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/26.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "TimeSelectView.h"

@implementation TimeSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, kViewWidth/4, 50);
        
        
        _qiLabel  = [WNController createLabelWithFrame:CGRectMake(0, 10, kViewWidth/4, 12) Font:10 Text:@"起" textAligment:NSTextAlignmentLeft];
        
        _zhiLabel = [WNController createLabelWithFrame:CGRectMake(0, 22, kViewWidth/4, 12) Font:10 Text:@"止" textAligment:NSTextAlignmentLeft];
        [self addSubview:_qiLabel];
        [self addSubview:_zhiLabel];
        _qiLabel.textColor = [UIColor redColor];
        _zhiLabel.textColor = [UIColor redColor];
        
        _selectedButton = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/4-20, 50) ImageName:@"" Target:nil Action:nil Title:@"" fontSize:15];
        _selectedButton.frame = self.bounds;
        [_selectedButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:_selectedButton];
        
        
    }
    return self;
}

@end
