//
//  ShopSendView.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/24.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//


#import "ShopSendView.h"



@interface ShopSendView()
//商家送货
@property (nonatomic,strong)UIButton * button1;
//顺风送货
@property (nonatomic,strong)UIButton * button2;
//申通送货
@property (nonatomic,strong)UIButton * button3;

@property (nonatomic,strong)NSString * sendStr;

@property (nonatomic,strong)ClickBlock block;

@property (nonatomic,strong)UIView * bgView;

@end


@implementation ShopSendView


//创建遮罩View
- (UIView *)CoverViewShow{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    //    bgView.alpha = 0.0;
    self.bgView = bgView;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTapGesAction)];
    [bgView addGestureRecognizer:tapGes];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    return bgView;
}

- (void)removeTapGesAction
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, kViewHeight, kViewWidth, 180);
        self.bgView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
    }];
    
}



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
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    return label;
}
//（0  h-180 w 180）
- (UILabel *)labelLineWithRect:(CGRect)frame{
    
    UILabel * labelLine1 = [[UILabel alloc]initWithFrame:frame];
    labelLine1.backgroundColor = [UIColor lightGrayColor];
    labelLine1.alpha = 0;
    return labelLine1;
}


- (instancetype)initWithFrame:(CGRect)frame AndClickBlock:(ClickBlock)block{
    if (self = [super initWithFrame:frame]) {
        
        self.block = block;
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        //完成按钮
        UIButton * buttonCommit = [[UIButton alloc]initWithFrame:CGRectMake(screenW - 80, 10, 80, 40)];
        [buttonCommit setTitle:@"完成" forState:UIControlStateNormal];
        [buttonCommit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttonCommit.titleLabel.textAlignment = NSTextAlignmentLeft;
        buttonCommit.titleLabel.font = [UIFont systemFontOfSize:16];
        [buttonCommit addTarget:self action:@selector(ClickDoSomething) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCommit];
        
        UILabel * label1 = [self createLabelWithTitle:@"送货上门" AndFrame: CGRectMake(13, 50, screenW - 50, 42)];
        
        UIButton * button1 = [self GetButtonWithFrame:CGRectMake(screenW - 35, 62, 15, 15)];
        self.button1 = button1;
        UIButton * buttonC1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, screenW , 42)];
        [buttonC1 addTarget:self action:@selector(BtnOneClick:) forControlEvents: UIControlEventTouchUpInside];
        
        UILabel * labelLine1 = [self labelLineWithRect:CGRectMake(25, 92, screenW - 50, 1)];
        [self addSubview:label1];
        [self addSubview:button1];
        [self addSubview:labelLine1];
        [self addSubview:buttonC1];
        UILabel * label2 = [self createLabelWithTitle:@"快递" AndFrame:CGRectMake(13, 94, screenW - 50, 42)];
        UIButton * button2 = [self GetButtonWithFrame:CGRectMake(screenW - 35, 106, 15, 15)];
        self.button2 = button2;
        UIButton * buttonC2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 95, screenW , 42)];
        [buttonC2 addTarget:self action:@selector(BtnTwoClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel * labelLine2 = [self labelLineWithRect:CGRectMake(25, 136, screenW - 50, 1)];
        [self addSubview:label2];
        [self addSubview:button2];
        [self addSubview:labelLine2];
        [self addSubview:buttonC2];
        UILabel * label3 = [self createLabelWithTitle:@"自提" AndFrame:CGRectMake(13, 138, screenW - 50, 42)];
        UIButton * button3 = [self GetButtonWithFrame:CGRectMake(screenW - 35, 150, 15, 15)];
        self.button3 = button3;
        UIButton * buttonC3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 140, screenW , 42)];
        [buttonC3 addTarget:self action:@selector(BtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel * labelLine3 = [self labelLineWithRect:CGRectMake(25, 180, screenW - 50, 1)];
        [self addSubview:label3];
        [self addSubview:button3];
        [self addSubview:labelLine3];
        [self addSubview:buttonC3];
//        self.button1.selected = YES;
        //        self.block(@"商家送货");
    }
    return self;
}

- (void)BtnOneClick:(UIButton *)sender{
    self.button1.selected = YES;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.sendStr = @"送货上门";
}

- (void)BtnTwoClick:(UIButton *)sender{
    self.button1.selected = NO;
    self.button2.selected = YES;
    self.button3.selected = NO;
    self.sendStr = @"快递";
}

- (void)BtnThreeClick:(UIButton *)sender{
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = YES;
    self.sendStr = @"自提";
    
}

- (void)ClickDoSomething{
    self.block(self.sendStr);
}

@end
