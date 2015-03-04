//
//  PromptLabel.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PromptLabel.h"

@implementation PromptLabel

-(id)initWithString:(NSString *)str{
    if (self=[super init]) {
        self.frame=CGRectMake(0, 0, 100, 30);
        self.backgroundColor=[UIColor blackColor];
        
        self.text=str;
        self.center=CGPointMake(kViewWidth/2,kViewHeight*0.3);
        self.alpha=0.8;
        self.textColor=[UIColor whiteColor];
        self.font=[UIFont systemFontOfSize:SmallFont];
        self.textAlignment=NSTextAlignmentCenter;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.numberOfLines=0;
        
    }
    return self;
}

-(void)MyViewRemove{
    
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        [UIView animateWithDuration:1 animations:^{
            self.alpha=0;
            
        }];
        
        
        
    });
    
    double delayInSecond = 2.0;
    dispatch_time_t deleteTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
    dispatch_after(deleteTime, dispatch_get_main_queue(), ^(void){
        
        
        [self removeFromSuperview];
        
    });
    
    
}

-(void)MyViewRemove:(NSInteger)timeInter{
    
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        [UIView animateWithDuration:timeInter animations:^{
            self.alpha=0;
            
        }];
        
        
        
    });
    
    double delayInSecond = 1.0;
    dispatch_time_t deleteTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
    dispatch_after(deleteTime, dispatch_get_main_queue(), ^(void){
        
        
        [self removeFromSuperview];
        
    });
}

#pragma mark - 一句代码执行提醒框
+ (void)custemAlertPromAddView:(UIView *)view text:(NSString *)text
{
    PromptLabel *prom = [[PromptLabel alloc] initWithString:text];
    [view addSubview:prom];
    [prom MyViewRemove];
}


@end
