//
//  ShopSendClickView.m
//  商家送货按钮事件处理view
//
//  Created by aaa on 16/1/26.
//  Copyright © 2016年 pengPL. All rights reserved.
//

#import "ShopSendClickView.h"

@interface ShopSendClickView()
//商家送货
@property (nonatomic,strong)UIButton * button1;
//顺风送货
@property (nonatomic,strong)UIButton * button2;
//申通送货
@property (nonatomic,strong)UIButton * button3;

@property (nonatomic,strong)ClickBlock block;

@end


@implementation ShopSendClickView

//得到打对号的button
- (UIButton *)GetButtonWithFrame:(CGRect)frame{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 按钮未选中的图片
    [button setBackgroundImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    //按钮选中后的图片
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:@"icon_xuanzhong"] forState: UIControlStateSelected];
    return button;
}
- (UILabel *)createLabelWithTitle:(NSString *)string AndFrame:(CGRect)frame{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = string;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (UILabel *)labelLineWithRect:(CGRect)frame{

    UILabel * labelLine1 = [[UILabel alloc]initWithFrame:frame];
    labelLine1.backgroundColor = [UIColor lightGrayColor];
    labelLine1.alpha = 0.3;
    return labelLine1;
}


- (instancetype)initWithFrame:(CGRect)frame AndClickBlock:(ClickBlock)block{
    if (self = [super initWithFrame:frame]) {
        
        self.block = block;
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        UILabel * label1 = [self createLabelWithTitle:@"送货上门" AndFrame: CGRectMake(13, 0, screenW - 50, 42)];
        
        UIButton * button1 = [self GetButtonWithFrame:CGRectMake(screenW - 35, 12, 15, 15)];
        self.button1 = button1;
        UIButton * buttonC1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screenW , 42)];
        [buttonC1 addTarget:self action:@selector(BtnOneClick:) forControlEvents: UIControlEventTouchUpInside];
        
        UILabel * labelLine1 = [self labelLineWithRect:CGRectMake(25, 42, screenW - 50, 1)];
        [self addSubview:label1];
        [self addSubview:button1];
        [self addSubview:labelLine1];
        [self addSubview:buttonC1];
        UILabel * label2 = [self createLabelWithTitle:@"快递" AndFrame:CGRectMake(13, 44, screenW - 50, 42)];
        UIButton * button2 = [self GetButtonWithFrame:CGRectMake(screenW - 35, 56, 15, 15)];
        self.button2 = button2;
       UIButton * buttonC2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 45, screenW , 42)];
        [buttonC2 addTarget:self action:@selector(BtnTwoClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel * labelLine2 = [self labelLineWithRect:CGRectMake(25, 86, screenW - 50, 1)];
        [self addSubview:label2];
        [self addSubview:button2];
        [self addSubview:labelLine2];
        [self addSubview:buttonC2];
        UILabel * label3 = [self createLabelWithTitle:@"自提" AndFrame:CGRectMake(13, 88, screenW - 50, 42)];
        UIButton * button3 = [self GetButtonWithFrame:CGRectMake(screenW - 35, 100, 15, 15)];
        self.button3 = button3;
        UIButton * buttonC3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 90, screenW , 42)];
        [buttonC3 addTarget:self action:@selector(BtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel * labelLine3 = [self labelLineWithRect:CGRectMake(25, 130, screenW - 50, 1)];
        [self addSubview:label3];
        [self addSubview:button3];
        [self addSubview:labelLine3];
        [self addSubview:buttonC3];
//        self.button1.selected = YES;
//        self.block(@"送货上门");
    }
    return self;
}

- (void)BtnOneClick:(UIButton *)sender{
    self.button1.selected = YES;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.block(@"送货上门");
}

- (void)BtnTwoClick:(UIButton *)sender{
    self.button1.selected = NO;
    self.button2.selected = YES;
    self.button3.selected = NO;
    self.block(@"快递");
}

- (void)BtnThreeClick:(UIButton *)sender{
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = YES;
    self.block(@"自提");
    
}

@end
