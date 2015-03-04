//
//  WNController.h
//
//  Created by wytzl on 14-11-14.
//  Copyright (c) 2014年 wytzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WNController : NSObject

///创建label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text textAligment:(NSTextAlignment )textAligment;
///创建图片View
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;

///创建有文字和图片的按钮
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title fontSize:(int)fontSize;

///创建只有图片的按钮
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;

///创建文本输入框
+(UITextField *)createTextFieldWithFrame:(CGRect)rect boreStyle:(UITextBorderStyle)boreStyle font:(int)font;
///创建View
+ (UIView *)createViewFrame:(CGRect)frame;

///将颜色信息转换为图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

///-- 判断是否为空
+ (id)nullString:(id)content;

@end
