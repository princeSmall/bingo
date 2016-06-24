//
//  JGBtnView.m
//  MovieIndustry
//
//  Created by 童乐 on 16/1/25.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "JGBtnView.h"

@interface JGBtnView ()

@property (nonatomic,strong)EndBtnClickBlock endBlock;

@end


@implementation JGBtnView

- (instancetype)initWithFrame:(CGRect)frame AndArray:(NSArray *)array AndEndBlock:(EndBtnClickBlock)endBlock{
    if (self = [super initWithFrame:frame]) {
        self.endBlock = endBlock;
        if (array.count == 1) {
            CGFloat buttonX = self.frame.size.width/5*4 - 10;
            CGFloat buttonY = 0;
            CGFloat buttonW = self.frame.size.width/5;
            CGFloat buttonH = 25;
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
            button.tag = 678;
            [button addTarget:self action:@selector(DoSomeThing:) forControlEvents:UIControlEventTouchUpInside];
            [button.layer setBorderColor:[UIColor grayColor].CGColor];
            [button.layer setBorderWidth:1];
            [button.layer setMasksToBounds:YES];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:array[0] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self addSubview:button];
        }else{
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width/array.count - 1;
        CGFloat buttonH = 25;
        for (int i = 0; i < array.count; i ++) {
            CGFloat buttonX = i * buttonW + 1;
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
            button.tag = 678+i;
            [button addTarget:self action:@selector(DoSomeThing:) forControlEvents:UIControlEventTouchUpInside];
            [button.layer setBorderColor:[UIColor grayColor].CGColor];
            [button.layer setBorderWidth:1];
            [button.layer setMasksToBounds:YES];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self addSubview:button];
        }
        }
    }
    return self;
}

- (void)DoSomeThing:(UIButton *)btn{
    NSString * string = [NSString stringWithFormat:@"%ld",btn.tag];
    
    self.endBlock(string);
}


@end
