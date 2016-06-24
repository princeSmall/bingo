//
//  JGStatesImageView.m
//  图片View的封装（scrollerView）
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGStatesImageView.h"

@implementation JGStatesImageView

- (instancetype)initWithFrame:(CGRect)frame{
    /*
     UIViewContentModeScaleToFill,
     // 拉伸图片填充  图片会失真 一般不使用
     UIViewContentModeScaleAspectFit,
     // 等比例拉伸  填重到整个屏幕
     UIViewContentModeScaleAspectFill,
     等比例拉伸  适配整个屏幕  以宽或高为拉伸结束
     */
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)createWithLocalImage:(UIImage *)image{
    self.image = image;
}


@end
