//
//  DeliveryUtility.m
//  Delivery_iOS
//
//  Created by 猫爷MACIO on 15/10/19.
//  Copyright (c) 2015年 yuejue. All rights reserved.
//

#import "DeliveryUtility.h"

@implementation DeliveryUtility

#pragma mark -- 显示弹出信息
+ (void)showMessage:(NSString *)msg target:(id)target {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:target cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark -- 判断是否为空
+ (id)nullString:(id)content
{
    return [content isEqual:[NSNull null]] ? nil : content;
}


#pragma mark -- 判断字符中是否存在表情
+ (BOOL)stringContainsEmoji:(NSString *) string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


#pragma mark -- 判断是否为整形
+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


#pragma mark --  判断是否为float
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


#pragma mark -- 判断是否包含非法字符
+ (BOOL)isNotLegal:(NSString *)string
{
    NSString *nicknameRegex = @".*[`=\\\[\\];',.~!@#$%^&*()_+|{}:\"<>?]+.*";
    NSPredicate *nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    return [nicknamePredicate evaluateWithObject:string];
}


+ (UIButton *)createBtnFrame:(CGRect)frame image:(NSString *)imageName selectedImage:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    if (imageName) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (selectedImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}


+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title andFont:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    if (font) {
        btn.titleLabel.font = font;
    }
    
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}


+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (title) {
        label.text = title;
    }
    
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    
    return label;
}

//创建UIImageView的方法
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = [UIImage imageNamed:imageName];
    
    //开启用户交互
    imageview.userInteractionEnabled = YES;
    
    return imageview;
    
}

#pragma mark -- 判断是否是空
+ (NSString *)getString:(id)value {
    NSString *strResult;
    if (value == [NSNull null] || value == nil)
        strResult = @"";
    else
        strResult = value;
    
    return strResult;
}

/** 修改图片大小 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark -- 计算文字高度
+ (CGSize)caculateContentSize:(NSString *)content
{
    CGSize size = [content boundingRectWithSize:CGSizeMake(screenWidth-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DefaultFont} context:nil].size;
    return size;
}

+ (CGSize)caculateContentSizeWithContent:(NSString *)content andHight:(CGFloat)height andWidth:(CGFloat)width andFont:(UIFont *)font
{
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}

+ (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    
    
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



@end
