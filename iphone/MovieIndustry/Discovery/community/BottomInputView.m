//
//  BottomInputView.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "BottomInputView.h"
@interface BottomInputView ()

@end
@implementation BottomInputView
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0,kViewHeight-50-44, kViewWidth,50);
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth,1)];
        line.backgroundColor=RGBColor(212,212,212,0.5);
        [self addSubview:line];
        
        //相机按钮
        UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraBtn.frame = CGRectMake(7,10,36,27);
        [cameraBtn setImage:[UIImage imageNamed:@"evaluation_camera"] forState:UIControlStateNormal];
        [cameraBtn addTarget:self action:@selector(takePhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cameraBtn];
        
        //输入框
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50,10, kViewWidth-130, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:textField];
        
        //发布按钮
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        publishBtn.frame = CGRectMake(kViewWidth-70, 10, 60, 30);
        [publishBtn setTitle:@"267" forState:UIControlStateNormal];
        publishBtn.clipsToBounds = YES;
        publishBtn.layer.cornerRadius = 5.0f;
        publishBtn.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
        publishBtn.layer.borderWidth = 1.0f;
        [publishBtn setTitleColor:RGBColor(249, 111, 11, 1) forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [publishBtn addTarget:self action:@selector(artcleAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        
    }
    return self;
}


#pragma mark - 拍照
- (void)takePhotoBtnClicked:(UIButton *)button
{
    NSLog(@"拍照按钮被点击");
}
- (void)artcleAction
{
}

@end
