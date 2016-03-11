//
//  NSString+StringSize.m
//  UILabelDemo2
//
//  Created by ZSQ on 15-1-13.
//  Copyright (c) 2015年 ZSQ. All rights reserved.
//

#import "NSString+StringSize.h"
//#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)

@implementation NSString (StringSize)

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode options:(NSStringDrawingOptions)options  context:(NSStringDrawingContext *)context
{
    //2. 根据显示文字计算所需的大小, 7.0以前的版本
    //[UIDevice currentDevice] 取到当前系统  systemVersion 取到系统的版本号
   
        NSDictionary *dict = @{ NSFontAttributeName : font };
        
        //计算显示文字所需的大小( IOS7 以及7以后的版本)
        //参数1 : 显示文字的约束区域
        //参数2 : 描绘选项 填 NSStringDrawingUsesLineFragmentOrigin
        //参数3 : 包含字体键值对的字典
        //参数4 : 描绘上下文  填 nil
        return  [self boundingRectWithSize:size options:options attributes:dict context:context].size;
    
}
//返回字符串所占用的尺寸.

- (CGSize) sizeWithFont:(UIFont *) font maxW:(CGFloat) maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize) sizeWithFont:(UIFont *) font {
    return  [self sizeWithFont:font maxW:MAXFLOAT];
}
//获得字符串的高度
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
@end
