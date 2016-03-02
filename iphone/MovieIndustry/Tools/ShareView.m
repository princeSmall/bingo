//
//  ShareView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#define MYHEIGHT [UIScreen mainScreen].applicationFrame.size.height
#import "ShareView.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//
        
    }
    return self;
}

///移除视图
- (void)cancelButtonAction
{
    [self myRemove];
}

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if(windows.count > 0)
        keyWindow = [windows lastObject];
    self.blackAlertView = [[UIView alloc] init];
    self.blackAlertView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.blackAlertView.backgroundColor = [UIColor blackColor];
    self.blackAlertView.alpha = 0;

    self.blackAlertView.userInteractionEnabled = YES;
    ///添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myRemove)];
    [self.blackAlertView addGestureRecognizer:tapGes];
    
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [keyWindow addSubview:self.blackAlertView];
    [keyWindow addSubview:self];
    
    self.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 317);
    
    [UIView animateWithDuration:0.5 animations:^(){
        
        self.blackAlertView.alpha = 0.6f;
       self.frame = CGRectMake(0, kViewHeight+20-317, kViewWidth, 317);
        
    }];
    
    /*@property (weak, nonatomic) IBOutlet UIButton *messButton;
     
     @property (weak, nonatomic) IBOutlet UIButton *collectButton;
     
     @property (weak, nonatomic) IBOutlet UIButton *qqButton;
     
     
     @property (weak, nonatomic) IBOutlet UIButton *qzoneButton;
     
     @property (weak, nonatomic) IBOutlet UIButton *wechatButton;
     
     @property (weak, nonatomic) IBOutlet UIButton *timelineButton;
     
     @property (weak, nonatomic) IBOutlet UIButton *xinaButton;
     @property (weak, nonatomic) IBOutlet UIButton *tencentButton;*/
    
    if (![WXApi isWXAppInstalled]) {
        self.wechatButton.enabled = NO;
        self.timelineButton.enabled = NO;
        
    }else
    {
        self.wechatButton.enabled = YES;
        self.timelineButton.enabled = YES;
    }
    
    if (![QQApiInterface isQQInstalled]) {
        self.qqButton.enabled = NO;
    }else
    {
        self.qqButton.enabled = YES;
    }
    
    
    
    [self.indexButton addTarget:self action:@selector(backIndex) forControlEvents:UIControlEventTouchUpInside];
    [self.qqButton addTarget:self action:@selector(qqButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.collectButton addTarget:self action:@selector(collectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.wechatButton addTarget:self action:@selector(wechatButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.timelineButton addTarget:self action:@selector(timelineButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.xinaButton addTarget:self action:@selector(xinaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)myRemove
{
    [UIView animateWithDuration:0.3 animations:
     ^{
         self.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 317);
         self.blackAlertView.alpha = 0.0f;
     }completion:^(BOOL finished){
         [self.blackAlertView removeFromSuperview];
         [self removeFromSuperview];
         
     }];
}

- (void)backIndex
{
    [self.delegate backIndex];
}

- (void)qqButtonAction
{
    [self.delegate qqButtonAction];
}


- (void)collectButtonAction
{
    [self.delegate collectButtonAction];
}

- (void)wechatButtonAction
{
    [self.delegate wechatButtonAction];
}

- (void)timelineButtonAction
{
    [self.delegate timelineButtonAction];
}

- (void)xinaButtonAction
{
    [self.delegate xinaButtonAction];
}

@end
