//
//  TTIDesTableViewCell.m
//  发布页面
//
//  Created by 童乐 on 16/3/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "TTIDesTableViewCell.h"




@interface TTIDesTableViewCell ()

@property (nonatomic,strong)UILabel * ladelNotice;

@end


@implementation TTIDesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(0,1,[UIScreen mainScreen].bounds.size.width,100)];
        self.textView.Placeholder = @"输入简介";
        [self addSubview:self.textView];
        
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(20, 120, [UIScreen mainScreen].bounds.size.width - 40, 40)];
        self.button.layer.cornerRadius = 5;
        self.button.layer.masksToBounds = YES;
        [self.button setTitleColor:[UIColor colorWithRed:0.200 green:0.204 blue:0.208 alpha:1.000] forState:UIControlStateNormal];
        [self.button setTitle:@"发布" forState:UIControlStateNormal];
        self.button.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:0.886 green:0.898 blue:0.902 alpha:1.000];
        self.button.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.button];
        
        self.ladelNotice = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(self.button.frame)+ 5, kViewWidth - 16, 30)];
        self.ladelNotice.textColor = [UIColor colorWithRed:0.227 green:0.231 blue:0.235 alpha:1.000];
        self.ladelNotice.text = @"设置商品详情，请联系平台在后台设置";
        self.ladelNotice.font = [UIFont systemFontOfSize:16];
        self.ladelNotice.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.ladelNotice];
        
    }
    return self;
}




@end
