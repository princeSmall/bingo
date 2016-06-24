//
//  TeacherCourseDetailHead.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "TeacherCourseDetailHead.h"
@interface TeacherCourseDetailHead ()
/**视屏播放按钮*/
@property (nonatomic, strong) UIButton *playBtn;
/**视屏时间长度*/
@property (nonatomic, strong) UILabel *timeLbl;
@end
@implementation TeacherCourseDetailHead
+ (instancetype) teacherCourseDetailHead {
    return [[[NSBundle mainBundle] loadNibNamed:@"TeacherCourseDetailHead" owner:nil options:nil] lastObject];
}
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

@end
