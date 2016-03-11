//
//  MovieClassesDetailHeadV.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/10.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesDetailHeadV.h"

@implementation MovieClassesDetailHeadV

- (instancetype) initMovieClassesDetailHeadV {
    if (self = [super init]) {
        [self setTitle];

    }
    return [[[NSBundle mainBundle] loadNibNamed:@"MovieClassesDetailHeadV" owner:nil options:nil] lastObject];
}
- (void) setTitle {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"课程标题";
    lbl.textColor = [UIColor whiteColor];
    lbl.font =[UIFont systemFontOfSize:20];
    [self.detailHead_ImageV addSubview:lbl];
    lbl.frame = CGRectMake(10, self.detailHead_ImageV.height - 40, 50, 30);
    UIButton *btn = [[UIButton alloc] init];
    [self.detailHead_ImageV addSubview:btn];
    [btn setTitle:@"30课时" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    btn.frame = CGRectMake(CGRectGetMaxX(lbl.frame), CGRectGetMinY(lbl.frame), 40, 20);
}
@end
