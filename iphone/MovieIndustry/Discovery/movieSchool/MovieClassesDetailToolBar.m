//
//  MovieClassesDetailToolBar.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/11.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesDetailToolBar.h"

@implementation MovieClassesDetailToolBar
+ (instancetype) initMovieClassesDetailToolBar {
    return [[[NSBundle mainBundle] loadNibNamed:@"MovieClassesDetailToolBar" owner:nil options:nil] lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
