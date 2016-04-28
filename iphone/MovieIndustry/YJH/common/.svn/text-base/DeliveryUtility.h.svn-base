//
//  DeliveryUtility.h
//  Delivery_iOS
//
//  Created by 猫爷MACIO on 15/10/19.
//  Copyright (c) 2015年 yuejue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeliveryUtility : NSObject


+ (void)showMessage:(NSString *)msg target:(id)target;
+ (BOOL)isPureInt:(NSString *)string;
+ (BOOL)isPureFloat:(NSString *)string;
+ (BOOL)isNotLegal:(NSString *)string;
+ (NSString *)getString:(id)value;
+ (id)nullString:(id)content;
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize;

/** 修改图片的大小 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


/** 时间戳转时间 */
+ (NSString *)turnTimeIntervalToString:(NSString *)timeInterval;

/** 时间转时间戳 */
+ (NSTimeInterval)turnTimeStringToTimeInterval:(NSString *)timeStr;

//创建按钮的方法
+ (UIButton *)createBtnFrame:(CGRect)frame image:(NSString *)imageName selectedImage:(NSString *)selectedImageName target:(id)target action:(SEL)action;

+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title andFont:(UIFont *)font target:(id)target action:(SEL)action;

//创建label的方法
+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment;

//创建UIImageView的方法
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (CGSize)caculateContentSize:(NSString *)content;


+ (CGSize)caculateContentSizeWithContent:(NSString *)content andHight:(CGFloat)height andWidth:(CGFloat)width andFont:(UIFont *)font;

@end
