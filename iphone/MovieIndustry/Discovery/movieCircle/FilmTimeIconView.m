//
//  FilmTimeIconView.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "FilmTimeIconView.h"
@interface FilmTimeIconView ()
@property (strong,nonatomic) UIButton *levelBtn;
@end
@implementation FilmTimeIconView
- (UIButton *)levelView {
    if (!_levelBtn) {
        UIButton *levelBtn = [[UIButton alloc] init];
        self.levelBtn = levelBtn;
        [self addSubview:levelBtn];
    }
    return _levelBtn;
}
// 设置头像 和 级别
- (void)setUser:(FilmTimeLineUser *)user {
    _user = user;
}
// 设置级别frame
- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
