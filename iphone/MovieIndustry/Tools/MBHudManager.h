//
//  MBHudManager.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Callback) (id obj);//一个返回值的Block
#import "MBProgressHUD.h"

@interface MBHudManager : NSObject
//显示Hud
+ (MBProgressHUD *)showHudAddToView:(UIView *)view andAddSubView:(UIView *)subView;

+ (void)removeHud:(MBProgressHUD *)hud scallBack:(Callback)scallBack;

@end
