//
//  MovieCommetView.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/12/1.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCommetView.h"



@implementation MovieCommetView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
- (void)drawRect:(CGRect)rect {

//    self.txtViewBg.layer.borderWidth = 1.0f;
//    self.txtViewBg.layer.borderColor = [UIColor redColor].CGColor;
    
    self.publishBtn.clipsToBounds = YES;
    self.publishBtn.layer.cornerRadius = 3.0f;
    
}


@end
