//
//  AreaButton.m
//  选择城市按钮demo
//
//  Created by 童乐 on 16/1/21.
//  Copyright © 2016年 童乐. All rights reserved.
//

#import "AreaButton.h"

@implementation AreaButton

- (instancetype)initWithFrame:(CGRect)frame AndString:(NSString *)String{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:String forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"bg_dianpujieshao"] forState:UIControlStateNormal];
         [self setBackgroundImage:[UIImage imageNamed:@"bg_dianpujieshao"] forState:UIControlStateHighlighted];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, frame.size.width - 25, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    }
    return self;
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    [self setTitle:buttonTitle forState:UIControlStateNormal];
}


@end
