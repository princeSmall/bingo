//
//  FeedbackViewController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface FeedbackViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *SuggestionsTextView;
//反馈图片
@property (weak, nonatomic) IBOutlet UIImageView *feedbackImageView;
//反馈按钮点击变化图片
@property (weak, nonatomic) IBOutlet UIButton *feedbackImageButton;
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

//提交反馈按钮
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end
