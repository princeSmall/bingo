//
//  JGBtnView.h
//  MovieIndustry
//
//  Created by 童乐 on 16/1/25.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
//这个View点击按钮后，传出的block事件
typedef void (^EndBtnClickBlock)(NSString * btnType);

@interface JGBtnView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndArray:(NSArray *)array AndEndBlock:(EndBtnClickBlock)endBlock;



@end
