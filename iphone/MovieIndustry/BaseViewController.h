//
//  BaseViewController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BaseViewController : UIViewController
@property (nonatomic,strong)UIPanGestureRecognizer *panGes;
/**
 *  设置标题
 *
 *  @param title 标题
 */
- (void)setNavTabBar:(NSString *)title;
///设置导航栏右边的按钮
- (void)setNavRightItem:(NSString *)rightTitle rightAction:(SEL)rightAction;
///设置导航栏右边的图标
- (void)setNavRightImage:(NSString *)rightImage rightAction:(SEL)rightAction;
@end
