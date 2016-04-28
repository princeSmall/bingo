//
//  MovieClassesDetailHeadV.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/10.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesDetailHeadV.h"
@interface MovieClassesDetailHeadV()
@property (weak,nonatomic) UILabel *lbl;
@property (nonatomic, weak) UIButton *btn;


@end
@implementation MovieClassesDetailHeadV

- (instancetype) initMovieClassesDetailHeadV {
    if (self = [super init]) {
      
        UILabel *lbl = [[UILabel alloc] init];
        self.lbl = lbl;
        [self.detailHead_ImageV addSubview:lbl];
        lbl.textColor = [UIColor whiteColor];
        lbl.font =[UIFont systemFontOfSize:20];
        
        UIButton *btn = [[UIButton alloc] init];
        [self.detailHead_ImageV addSubview:btn];
        self.btn = btn;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MovieClassesDetailHeadV" owner:nil options:nil] lastObject];
    }
    return self;;
}
- (void) setTitle {
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _lbl.text = @"课程标题";
    
    _lbl.frame = CGRectMake(10, self.detailHead_ImageV.height - 40, 50, 30);
    [_btn setTitle:@"30课时" forState:UIControlStateNormal];
    
    _btn.frame = CGRectMake(CGRectGetMaxX(_lbl.frame), CGRectGetMinY(_lbl.frame), 40, 20);
}
@end
