//
//  CustomDatePickView.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/26.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDatePickView : UIView
///开始时间
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
///结束时间
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//开始时间按钮
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
///结束时间按钮
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
///保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
///时间选择View
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickView;
///起字label
@property (weak, nonatomic) IBOutlet UILabel *qilabel;
///止字label
@property (weak, nonatomic) IBOutlet UILabel *zhiLabel;
@end
