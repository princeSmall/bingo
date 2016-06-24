//
//  MyOrderCellFooter.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyOrderCellFooter.h"

@implementation MyOrderCellFooter


- (void)drawRect:(CGRect)rect {
    self.leftBtn.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    self.leftBtn.layer.borderWidth =1;
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.masksToBounds = YES;
    
    self.rightBtn.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    self.rightBtn.layer.borderWidth = 1;
    self.rightBtn.layer.cornerRadius = 5;
    self.rightBtn.layer.masksToBounds = YES;

    self.lineView.backgroundColor = kViewBackColor;
}


@end
