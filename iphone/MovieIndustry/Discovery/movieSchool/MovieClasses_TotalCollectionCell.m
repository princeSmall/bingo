//
//  MovieClasses_TotalCollectionCell.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClasses_TotalCollectionCell.h"

@implementation MovieClasses_TotalCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MovieClasses_TotalCollectionCell" owner:self options:nil];
        self = [arrayOfViews objectAtIndex:0];
        
        UIButton *btn = [[UIButton alloc] init];
        [self.movieCoverImage addSubview:btn];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"30课时" forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:10];
        [btn setBackgroundImage:[UIImage imageNamed:@"Highqualitycourses_classTime"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(-4, 10, 35, 15);
    }
    return self;
}


@end
