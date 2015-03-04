//
//  ChooseExpressTypeView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/25.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ChooseExpressTypeView.h"

@interface ChooseExpressTypeView ()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *myBtnView;
@end

@implementation ChooseExpressTypeView

- (void)show
{
    UIView *bgView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, kViewHeight+20)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.0;
    self.bgView = bgView;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTapGesAction)];
    [bgView addGestureRecognizer:tapGes];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, kViewHeight+20, kViewWidth, 148)];
    btnView.backgroundColor = kViewBackColor;
    self.myBtnView.userInteractionEnabled = YES;
    self.myBtnView = btnView;
    
    [[UIApplication sharedApplication].keyWindow addSubview:btnView];
    self.topBtn = [self createButtonWithFrame:CGRectMake(0, 0, kViewWidth, 148/3-1) ImageName:@"" Title:@"商家送货" fontSize:16];
    self.topBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.topBtn.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:self.topBtn];

    self.midleBtn = [self createButtonWithFrame:CGRectMake(0, 148/3, kViewWidth, 148/3-1) ImageName:@"" Title:@"快递" fontSize:16];
    self.midleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.midleBtn.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:self.midleBtn];
    
//    self.bottomBtn = [WNController createButtonWithFrame:CGRectMake(0, 148/3*2, kViewWidth, 148/3-1) ImageName:@"" Target:nil Action:nil Title:@"自提" fontSize:16];
    self.bottomBtn = [self createButtonWithFrame:CGRectMake(0, 148/3*2, kViewWidth, 148/3-1) ImageName:@"" Title:@"自提" fontSize:16];
    self.bottomBtn.backgroundColor = [UIColor whiteColor];
    self.bottomBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btnView addSubview:self.bottomBtn];
    
    self.topBtn.tag = 100;
    self.midleBtn.tag = 101;
    self.bottomBtn.tag = 102;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.alpha = 0.5;
        self.myBtnView.frame = CGRectMake(0, kViewHeight+20-148, kViewWidth, 148);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark 移除手势
- (void)removeTapGesAction
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgView.alpha = 0.0f;
        self.myBtnView.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 148);
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.myBtnView removeFromSuperview];
    }];
    
}

- (UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Title:(NSString*)title fontSize:(int)fontSize
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    
//    [button setBackgroundImage:[WNController createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}

@end
