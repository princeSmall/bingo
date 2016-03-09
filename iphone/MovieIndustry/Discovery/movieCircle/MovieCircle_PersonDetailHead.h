//
//  MovieCircle_PersonDetailHead.h
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/8.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCircle_PersonDetailHead : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImagV;
@property (weak, nonatomic) IBOutlet UIImageView *backImagV;
// 帖子
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
// 粉丝
@property (weak, nonatomic) IBOutlet UIButton *fansBtn;
// 关注
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIView *btnLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnLineCenterXCT;
@property (weak, nonatomic) IBOutlet UIView *effectV;
+ (instancetype) movieCircle_PersonDetailHead;
@end
