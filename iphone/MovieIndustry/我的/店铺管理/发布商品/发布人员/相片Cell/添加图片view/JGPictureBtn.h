//
//  JGPictureBtn.h
//  图片View的封装（scrollerView）
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock)(UIImage * img);

@interface JGPictureBtn : UIButton

- (instancetype)initWithFrame:(CGRect)frame AndImage:(UIImage *)image AndButtonClickBlock:(ButtonClickBlock)block;

@end
