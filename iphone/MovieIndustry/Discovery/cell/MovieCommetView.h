//
//  MovieCommetView.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/12/1.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCommetView : UIView

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *layoutTxt;

@property (strong, nonatomic) IBOutlet UIView *txtViewBg;//文本输入框背景
@property (strong, nonatomic) IBOutlet UITextView *textView;//评论内容输入
@property (strong, nonatomic) IBOutlet UIButton *takePhotoBtn;//拍照按钮
@property (strong, nonatomic) IBOutlet UIButton *albumBtn;//相册按钮
@property (strong, nonatomic) IBOutlet UIButton *publishBtn;//发表按钮

@end
