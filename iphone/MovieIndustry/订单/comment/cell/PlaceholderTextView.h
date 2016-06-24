//
//  PlaceholderTextView.h
//  textView封装
//
//  Created by 童乐 on 16/1/28.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
//设置placeHold的内容
@property(nonatomic,strong)NSString *Placeholder;
//设置placeHold的字体
@property(nonatomic,strong)UIFont *PlaceholderFont;
//设置placeHold的字体颜色
@property(nonatomic,strong)UIColor *PlaceholderColor;
//隐藏placeHold
-(void)setPlaceholderHidden;

@end
