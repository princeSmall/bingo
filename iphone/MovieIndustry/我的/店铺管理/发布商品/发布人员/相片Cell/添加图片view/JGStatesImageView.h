//
//  JGStatesImageView.h
//  图片View的封装（scrollerView）
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGStatesImageView : UIImageView

//应用内图片，或者说是直接相册拿到图片,关于网络图片，建议拿到url转成图片后再传来。
- (void)createWithLocalImage:(UIImage *)image;
@end
