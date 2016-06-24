//
//  ViewController.m
//  五星View配合点击事件
//
//  Created by 童乐 on 16/2/17.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "StarView.h"

@interface StarView()


@property(nonatomic,strong)NSString *canscore;

@end

@implementation StarView


/*!
 *  初始化函数
 *
 *  @param  frame   当前对象的布局
 *  @param  score   点赞星星数
 *  @param  canscore    是否可以点评
 *
 *  @return   返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame score:(CGFloat)score canscore:(NSString *)canscore{
    self = [super initWithFrame:frame];
    if (self) {
        if (score >= 5) {
            score = 5;
        }
        self.score = roundf(score);
        self.canscore = canscore;
        
        self.backgroundColor = [UIColor clearColor];
        if([canscore isEqualToString:@"0"])
        {
            for (int i=0; i<5; i++) {
                UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(14*i, 2, 14, 13)];
                imageBack.image = [UIImage imageNamed:@"gallerymal_noselect"];
                imageBack.hidden = YES;
                [self addSubview:imageBack];
                if (score > i) {
                
                    UIImageView *imageHead = [[UIImageView alloc] initWithFrame:    CGRectMake(14*i, 2, 14, 13)];
                    imageHead.image = [UIImage imageNamed:@"icon_shoucang_s"];
                    [self addSubview:imageHead];
                
                }
        
            
            }
        }
        else
        {
            for (int i=0; i<5; i++) {
                UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(14*i, 2, 14, 13)];
                imageBack.image = [UIImage imageNamed:@"gallerymal_noselect"];
                [self addSubview:imageBack];
                if (score > i) {
                    
                    UIImageView *imageHead = [[UIImageView alloc] initWithFrame:    CGRectMake(14*i, 2, 14, 13)];
                    imageHead.image = [UIImage imageNamed:@"icon_shoucang_s"];
                    [self addSubview:imageHead];
                    
                }
                
                
            }

        }
        
    }
    return self;
}

/*!
 *  设置星星数
 *
 *  @param  score       点赞星星数
 *  @param  canscore    是否可以点评
 */
-(void)setViewWithScore:(CGFloat)score
               canscore:(NSString *)canscore {
    self.score = roundf(score);
    self.canscore = canscore;
    
    NSArray *arrayViews = [NSArray arrayWithArray:self.subviews];
    for (UIImageView *view in arrayViews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i<5; i++) {
        UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(14*i, 2, 14, 13)];
        imageBack.image = [UIImage imageNamed:@"gallerymal_noselect"];
        [self addSubview:imageBack];
        if (score > i) {
            UIImageView *imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(14*i, 2, 14, 13)];
            imageHead.image = [UIImage imageNamed:@"icon_shoucang_s"];
            [self addSubview:imageHead];
        }
        
    }
}

/*!
 *   返回星星数
 *
 *  @param  selectFn     选择block
 */
-(void)setViewWithSelectFn:(StarSelectFn)selectFn {
    self.selectFn = selectFn;
}

#pragma mark - Touch method
/*!
 *  开始接触
 *
 *  @param  touches     触点集合
 *  @param  event       可以获得所有触点集合
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];
    CGPoint locInSelf = [touch locationInView:self];
    if ([self.canscore isEqualToString:@"1"]) {
        [self setViewWithScore:ceilf(locInSelf.x/14) canscore:self.canscore];
        if (self.selectFn) {
            self.selectFn(ceilf(locInSelf.x/14));
        }
    }
}

/*!
 *  触点移动
 *
 *  @param  touches     触点集合
 *  @param  event       可以获得所有触点集合
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

/*!
 *  结束接触
 *
 *  @param  touches     触点集合
 *  @param  event       可以获得所有触点集合
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

/*!
 *  触点离开view
 *
 *  @param  touches     触点集合
 *  @param  event       可以获得所有触点集合
 */
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


@end
