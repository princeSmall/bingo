//
//  WNController.m
//
//  Created by wytzl on 14-11-14.
//  Copyright (c) 2014年 wytzl. All rights reserved.
//

#import "WNController.h"


@implementation WNController

#pragma mark -- 判断是否为空
+ (id)nullString:(id)content
{
    return [content isEqual:[NSNull null]] ? @"" : content;
}


+(UITextField *)createTextFieldWithFrame:(CGRect)rect boreStyle:(UITextBorderStyle)boreStyle font:(int)font{
    UITextField *textField=[[UITextField alloc]init];
    textField.font=[UIFont systemFontOfSize:font];
    textField.borderStyle=boreStyle;
    textField.frame=rect;
    return textField;
    
    
}

//创建左对齐
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text textAligment:(NSTextAlignment )textAligment
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment= textAligment;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label ;
}


+(UITextView*)TextViewcreateLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text textAligment:(NSTextAlignment )textAligment
{
    UITextView*label=[[UITextView alloc]initWithFrame:frame];
    //限制行数
    //对齐方式
    label.textAlignment= textAligment;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
//    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
//    label.userInteractionEnabled = NO;
    label.editable = NO;
    label.text=text;
    return label ;
}




//创建按钮 设置image和title
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title fontSize:(int)fontSize
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}

+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，
     [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    return button;
}

+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}

//创建View
+ (UIView *)createViewFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


//// 设置选中状态颜色的变化的按钮
+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action
{
    UIButton *commentbtn = [[UIButton alloc] initWithFrame:frame];
    [commentbtn setTitle:title forState:UIControlStateNormal];
    
    //设置选中状态的标题颜色
    [commentbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [commentbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    //设置选中状态的背景颜色
    [commentbtn setBackgroundImage:[WNController createImageWithColor:[UIColor colorWithRed:0.97 green:0.4 blue:0 alpha:1]] forState:UIControlStateSelected];
    [commentbtn setBackgroundImage:[WNController createImageWithColor:[UIColor orangeColor]] forState:UIControlStateHighlighted];
//    [commentbtn setBackgroundImage:[WNController createImageWithColor:[UIColor whiteColor]] forState:UIControlStateApplication];
    [commentbtn setBackgroundImage:[WNController createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    commentbtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [commentbtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return commentbtn;
}




@end
