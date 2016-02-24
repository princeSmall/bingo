//
//  LoginInController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "LoginInController.h"
#import "HelpViewController.h"
#import "MainTabBarController.h"
#import "CustomDatePickView.h"
#import "MovieHelperDetailViewController.h"

@interface LoginInController ()<UITextFieldDelegate>
@property (nonatomic,copy) NSString *codeString;
@property (nonatomic,strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,assign) int timeCount;
@end

@implementation LoginInController


- (void)viewDidLoad {
    [super viewDidLoad];
    //修改导航栏的颜色
    self.navigationController.navigationBar.barTintColor=kNavBarColor;
    self.navigationController.navigationBar.translucent=NO;
    
    self.timeLabel.layer.cornerRadius = 3;
    self.timeLabel.layer.masksToBounds = YES;
    
    if (kViewWidth<375) {
        self.sendCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    
    
    
    _codeString = @"";
    
    
    [self.agreeXieyiButton addTarget:self action:@selector(agreeXieyiButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //设置同意按钮的点击
    [self.agreeButton setImage:[UIImage imageNamed:@"login4"] forState:UIControlStateNormal];
    [self.agreeButton setImage:[UIImage imageNamed:@"login3"] forState:UIControlStateSelected];
    [self.agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeButton.selected = YES;
    
    [self setNavTabBar:@"登陆"];
    
    [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //发送验证码
    [self.sendCodeButton addTarget:self action:@selector(sendCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //限制手机号输入位数
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    

}

#pragma mark - 同意协议
- (void)agreeXieyiButtonAction
{
    MovieHelperDetailViewController *agreeXieyiVc = [[MovieHelperDetailViewController alloc] init];
    agreeXieyiVc.isRegister = YES;
    [self.navigationController pushViewController:agreeXieyiVc animated:YES];
}

#pragma mark - 发送验证码
- (void)sendCodeButtonAction
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [PromptLabel custemAlertPromAddView:self.view text:@"请输入手机号"];
    }else
    {
        if (self.phoneTextField.text.length < 11) {
            [PromptLabel custemAlertPromAddView:self.view text:@"手机号不正确"];
        }else
        {
            NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text,@"mobile", nil];
            
            [HttpRequestServers requestBaseUrl:Send_note_login withParams:userDict withRequestFinishBlock:^(id result) {
                
                NSDictionary *dict = result;
                HHNSLog(@"%@",dict);
                if ([dict[@"status"] isEqualToString:@"f99"]) {
                    PromptLabel *prom = [[PromptLabel alloc] initWithString:@"验证码已发送到您手机，请查收"];
                     prom.frame = CGRectMake(0, 0, 120, 50);
                    prom.center=CGPointMake(kViewWidth/2,kViewHeight*0.3);
                   
                    [self.view addSubview:prom];
                    [prom MyViewRemove];
                    
                    
                    _codeString = dict[@"code"];
                    
                    ///发送成功之后按钮不可点击 然后倒计时
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                    self.timeCount = 60;
                    ///
                    self.sendCodeButton.enabled = NO;
                }
                else
                {
                    [PromptLabel custemAlertPromAddView:self.view text:dict[@"msg"]];
                }
                
                
            } withFieldBlock:^{
                
                [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
            }];
        }
    }
}

#pragma mark - 倒计时
- (void)updateTimer
{
    if (self.timeCount>1) {
        self.timeCount--;
        self.timeLabel.text =[NSString stringWithFormat:@"%d秒后重发",self.timeCount];
//        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重发",self.timeCount] forState:UIControlStateNormal];
    }else
    {
        //关闭计时器
        [self.timer invalidate];
        self.timeLabel.text =@"重新发送";
        self.sendCodeButton.enabled = YES;
    }
}

#pragma mark 登陆接口
- (void)loginButtonAction
{
    [self.view endEditing:YES];
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [PromptLabel custemAlertPromAddView:self.view text:@"请输入手机号"];
    }else
    {
        if ([self.codeTextField.text isEqualToString:@""]) {
            [PromptLabel custemAlertPromAddView:self.view text:@"请输入验证码"];
        }else
        {
            if ([self.phoneTextField.text isEqualToString:@"15800390791"]&&[self.codeTextField.text isEqualToString:@"1099"]) {
                [self testAccountLogin];
            }else
            {
                if (![self.codeTextField.text isEqualToString:_codeString]) {
                    [PromptLabel custemAlertPromAddView:self.view text:@"验证码不正确"];
                }else
                {
                    
                    if (![self.agreeButton isSelected]) {
                        [PromptLabel custemAlertPromAddView:self.view text:@"未同意协议"];
                    }else
                    {
                        MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:[UIApplication sharedApplication].keyWindow];
                        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text,@"mobile", nil];
                        [HttpRequestServers requestBaseUrl:TIUser_Login withParams:userDict withRequestFinishBlock:^(id result) {
                            NSDictionary *dict = result;
                            if ([dict[@"code"] intValue] == 0) {
                         
                                NSDictionary * dic = dict[@"data"];
                                UserLoginModel * model = [[UserLoginModel alloc]init];
                                model.user_id = dic[@"user_id"];
                                model.phoneNumber = self.phoneTextField.text;
                                APP_DELEGATE.user_id = model.user_id;
                                [UserLoginModel ArchiveUser:model];
                                [self.view endEditing:YES];
                                        [PromptLabel custemAlertPromAddView:self.view text:@"登陆成功！"];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                });
                                [MBHudManager removeHud:hud scallBack:^(id obj) {
                                
                                    
                                    if (!self.isExitLogin) {
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }else
                                    {
                                        MainTabBarController *mainTabBar = [[MainTabBarController alloc] init];
                                        [UIApplication sharedApplication].keyWindow.rootViewController = mainTabBar;
                                    }
                                }];
                            }
                            else
                            {
                                [PromptLabel custemAlertPromAddView:self.view text:@"登陆失败"];
                                [MBHudManager removeHud:hud scallBack:^(id obj) {
                                    
                                }];
                            }
                            
                        } withFieldBlock:^{
                            [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
                            [MBHudManager removeHud:hud scallBack:^(id obj) {
                                
                            }];
                        }];
                    }
                }
            }
            
            
            
        }
    }
}


- (void)testAccountLogin
{
    
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:[UIApplication sharedApplication].keyWindow];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text,@"mobile", nil];
    [HttpRequestServers requestBaseUrl:Register_login withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        if ([dict[@"status"] isEqualToString:@"f99"]) {
            NSDictionary *userInfo = dict[@"user_info"];
            
            [[NSUserDefaults standardUserDefaults] setValue:userInfo[@"mobile"] forKey:@"userAccount"];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo[@"id"] forKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo[@"user_pwd"] forKey:@"userPassword"];
            
            [MBHudManager removeHud:hud scallBack:^(id obj) {
                
                [self.view endEditing:YES];
                
                if (!self.isExitLogin) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else
                {
                    MainTabBarController *mainTabBar = [[MainTabBarController alloc] init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabBar;
                }
            }];
        }
        else
        {
            [PromptLabel custemAlertPromAddView:self.view text:dict[@"msg"]];
            [MBHudManager removeHud:hud scallBack:^(id obj) {
                
            }];
        }
        
    } withFieldBlock:^{
        [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
        }];
    }];

}


#pragma mark - 点击同意协议
- (void)agreeButtonAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    
 
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
        [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //添加点击事件
        [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
         [self.navigationController.navigationBar addSubview:leftBtn];
        //设置TabBar左边的按钮
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
       [self.navigationItem setLeftBarButtonItem:backItem];
//    leftBtn.hidden =YES;
    
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 45, 25)];
    [rightBtn setTitle:@"帮助" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //添加点击事件
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -12)];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)backAction
{
     [self.view endEditing:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//跳转到帮助页面
- (void)rightAction
{
    HelpViewController *helpVc = [[HelpViewController alloc] init];
     [self.view endEditing:YES];
    [self.navigationController pushViewController:helpVc animated:YES];
}

#pragma mark - 限制输入位数
//限制手机号和验证码输入个数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.codeTextField) {
        if (textField.text.length > 4) {
            textField.text = [textField.text substringToIndex:4];
        }
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
