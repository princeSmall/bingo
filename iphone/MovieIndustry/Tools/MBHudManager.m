//
//  MBHudManager.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MBHudManager.h"


@implementation MBHudManager

+ (MBProgressHUD *)showHudAddToView:(UIView *)view andAddSubView:(UIView *)subView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelFont = [UIFont systemFontOfSize:12];
//    hud.margin = 10.f;
//    hud.dimBackground = YES;
//    [subView addSubview:hud];
    
    return hud;
}

//延迟1秒移除视图
+ (void)removeHud:(MBProgressHUD *)hud scallBack:(Callback)scallBack
{
    double delayInSecond = 0.3;
    dispatch_time_t deleteTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
    dispatch_after(deleteTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
        scallBack(@"YES");
    });
}



@end
