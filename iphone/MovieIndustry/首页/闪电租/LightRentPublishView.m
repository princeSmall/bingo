//
//  LightRentPublishView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/25.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "LightRentPublishView.h"

@interface LightRentPublishView ()

@property (nonatomic,strong) UIView *blackAlertView;

@end

@implementation LightRentPublishView

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
    
    [self.motifyButton addTarget:self action:@selector(myRemove) forControlEvents:UIControlEventTouchUpInside];
    
    [keyWindow addSubview:self.blackAlertView];
    [keyWindow addSubview:self];
    
    self.frame = CGRectMake(kViewWidth/2-138.5, -273, 277, 273);
    
    [UIView animateWithDuration:0.3 animations:^(){
        
        self.blackAlertView.alpha = 0.6f;
        self.frame = CGRectMake(kViewWidth/2-138.5, (kViewHeight+20)/2-136.5, 277, 273);
        
    }];
    
}

- (void)myRemove
{
    [UIView animateWithDuration:0.3 animations:
     ^{
         self.frame = CGRectMake(kViewWidth/2-138.5, -273, 277, 273);
         self.blackAlertView.alpha = 0.0f;
     }completion:^(BOOL finished){
         [self.blackAlertView removeFromSuperview];
         [self removeFromSuperview];
         
     }];
    
}


@end
