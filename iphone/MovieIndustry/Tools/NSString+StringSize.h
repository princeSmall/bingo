//
//  NSString+StringSize.h
//  UILabelDemo2
//
//  Created by ZSQ on 15-1-13.
//  Copyright (c) 2015年 ZSQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

/**
 *  计算显示文字所需的大小，该方法会自动根据不同版本用不同的方法来进行计算
 *
 *  @param font          显示文字的字体
 *  @param size          文字约束的大小
 *  @param lineBreakMode 换行模式
 *  @param options       描绘选项
 *  @param context       描绘上下文
 *
 *  @return 显示文字所需的最合适的大小
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode options:(NSStringDrawingOptions)options  context:(NSStringDrawingContext *)context;
/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */

- (CGSize) sizeWithFont:(UIFont *) font maxW:(CGFloat) maxW;
- (CGSize) sizeWithFont:(UIFont *) font;
@end
