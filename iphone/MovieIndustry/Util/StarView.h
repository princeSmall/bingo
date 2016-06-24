//
//  ViewController.m
//  五星View配合点击事件
//
//  Created by 童乐 on 16/2/17.
//  Copyright © 2016年 彭金光. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^StarSelectFn)(int score);

@interface StarView : UIView

@property(nonatomic)CGFloat score;

@property(nonatomic,copy)StarSelectFn selectFn;

/*!
 *  初始化函数
 *
 *  @param  frame   当前对象的布局
 *  @param  score   点赞星星数
 *  @param  canscore    是否可以点评
 *
 *  @return   返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame score:(CGFloat)score canscore:(NSString *)canscore;

/*!
 *  设置星星数
 *
 *  @param  score       点赞星星数
 *  @param  canscore    是否可以点评
 */
-(void)setViewWithScore:(CGFloat)score
               canscore:(NSString *)canscore;

/*!
 *   返回星星数
 *
 *  @param  selectFn     选择block
 */
-(void)setViewWithSelectFn:(StarSelectFn)selectFn;

@end
