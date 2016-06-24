//
//  TeacherDetialMsgHead.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/7.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherDetialMsgHead;
@protocol TeacherDetialMsgHeadDelegate <NSObject>

- (void) TeacherDetialMsgHead:(TeacherDetialMsgHead *) head privateBtnClicked:(UIButton *) btn;
- (void) TeacherDetialMsgHead:(TeacherDetialMsgHead *) head attentionBtnClicked:(UIButton *) btn;
@end
@interface TeacherDetialMsgHead : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *privaBtn;
@property (weak, nonatomic) IBOutlet UIView *msgContentV;
@property (nonatomic, weak) id<TeacherDetialMsgHeadDelegate> delegate;


+ (instancetype) teacherDetialMsgHead ;
@end
