//
//  BtnSelectView.m
//  ButtonSelectView
//
//  Created by aaa on 16/1/25.
//  Copyright © 2016年 pengPL. All rights reserved.
//

#import "BtnSelectView.h"
#define ViewWidth ([UIScreen mainScreen].bounds.size.width)

@interface BtnSelectView ()

@property (nonatomic,strong)UILabel * btnLine;
@property (nonatomic,strong)EndBlock block;
@property (nonatomic,strong)NSArray * array;
@property (nonatomic,assign)CGFloat lineWidth;

@end

@implementation BtnSelectView

- (instancetype)initWithFrame:(CGRect)frame AndArray:(NSArray *)array AndClickBlock:(EndBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.array = array;
        self.block = block;
         int num =(int)array.count;
        _btnLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 43, ViewWidth/num-10, 2)];
        self.lineWidth = ViewWidth/num;
        _btnLine.backgroundColor = [UIColor redColor];
        [self addSubview:_btnLine];
        for (int i = 0; i < array.count; i ++) {
        
            UIButton *btn = [BtnSelectView createButtonWithFrame:CGRectMake(i *ViewWidth/num, 0, ViewWidth/num, 45) ImageName:@"" Target:self Action:@selector(allOrderAction:) Title:array[i] fontSize:14];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self addSubview:btn];
          
        }
        self.block(0);
    }
    return self;
}

- (void)allOrderAction:(UIButton *)sender{
    
    int num;
    for (int i = 0; i <self.array.count; i ++) {
        if ([sender.titleLabel.text isEqualToString:self.array[i]]) {
            num = i;
            break;
        }
    }
    CGFloat lineX = self.lineWidth*num + 5;
    CGFloat lineY = 43;
    CGFloat lineW = self.lineWidth -10;
    CGFloat lineH = 2;
    [self setBtnType:nil selectBtn:nil btnLineFrame:CGRectMake(lineX, lineY, lineW, lineH)];
    self.block(num);
}

- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
{
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = btnLineFrame;
    }];
}
//创建按钮 设置image和title
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title fontSize:(int)fontSize{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}



@end
