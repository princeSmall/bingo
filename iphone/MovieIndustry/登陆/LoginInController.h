//
//  LoginInController.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInController : UIViewController

//填写手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
//填写二维码
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
//发送验证码
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
//登陆按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//同意按钮
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UIButton *agreeXieyiButton;

@property (nonatomic,strong)NSString * isCc;
@property (nonatomic,assign) BOOL isExitLogin;
@end
