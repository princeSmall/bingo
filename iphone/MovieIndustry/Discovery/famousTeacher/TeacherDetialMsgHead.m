//
//  TeacherDetialMsgHead.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/7.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "TeacherDetialMsgHead.h"

@implementation TeacherDetialMsgHead

+ (instancetype) teacherDetialMsgHead {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@", [self class]] owner:nil options:nil];
    return [views firstObject];
}
- (IBAction)attentionBtnClicked:(UIButton *)sender {
    [self.delegate TeacherDetialMsgHead:self attentionBtnClicked:sender];
}

- (IBAction)privateBtnClicked:(UIButton *)sender {
    [self.delegate TeacherDetialMsgHead:self privateBtnClicked:sender];
}

@end
