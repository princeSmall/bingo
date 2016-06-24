//
//  JGPictureBtn.m
//  图片View的封装（scrollerView）
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "JGPictureBtn.h"

@interface  JGPictureBtn()

@property (nonatomic,strong)ButtonClickBlock block;
@property (nonatomic,strong)UIImage * sendImage;

@end

@implementation JGPictureBtn

- (instancetype)initWithFrame:(CGRect)frame AndImage:(UIImage *)image AndButtonClickBlock:(ButtonClickBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.block = block;
        self.sendImage = image;
        [self setImage:image forState:UIControlStateNormal];
        
        /**
         *  这边contentMode是设置图片显示的AspectFit 自适配，ScaleAspectFill自适配裁剪
         */
//      self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)BtnClick{
    self.block(self.sendImage);
}

@end
