//
//  JGCoverView.h
//  图片View的封装（scrollerView）
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelBlock)(NSString * type,UIImage * image);

@interface JGCover1View : UIView

- (instancetype)initWithFrame:(CGRect)frame WithImage:(UIImage *)image AndController:(UIViewController*)viewController AndCancelBlock:(CancelBlock)block;


@end
