//
//  HelpViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCommitSuccessController.h"

@interface HelpViewController ()
{
    NSString *_codeString;
}
@property (nonatomic,strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) int timeCount;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.textLabel.text = @"发送验证码";
    UserLoginModel * model = [UserLoginModel UnarchiverUser];
    self.currentPhoneLabel.text = model.phoneNumber;
    
    if (kViewWidth<375) {
        self.sendCodeButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    if (self.type) {
        [self setNavTabBar:@"修改账号"];
    }else
    {
        [self setNavTabBar:@"帮助"];
    }
    
    
    if (kViewWidth>=375) {
        self.changePhoneLabel.font = [UIFont systemFontOfSize:15];
        self.cuNumberLabel.font = [UIFont systemFontOfSize:15];
    }
    
    
    
    [self.sendCodeButton addTarget:self action:@selector(sendCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //限制手机号输入位数
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 发送验证码
#pragma mark - 发送验证码
- (void)sendCodeButtonAction
{
    if ([self.phoneTextField.text isEqualToString:@""]) {
//        [PromptLabel custemAlertPromAddView:self.view text:@"请输入手机号"];
        [DeliveryUtility showMessage:@"请输入手机号码" target:nil];
    }else
    {
        if (self.phoneTextField.text.length < 11) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"手机号不正确"];
             [DeliveryUtility showMessage:@"手机号码不正确" target:nil];
        }else
        {
            NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text,@"mobile", nil];
            
            [HttpRequestServers requestBaseUrl:Send_note_login withParams:userDict withRequestFinishBlock:^(id result) {
                
                NSDictionary *dict = result;
                HHNSLog(@"%@",dict);
                if ([dict[@"status"] isEqualToString:@"f99"]) {
//                    PromptLabel *prom = [[PromptLabel alloc] initWithString:@"验证码已发送到您手机，请查收"];
                    
//                    prom.frame = CGRectMake(0, 0, 120, 50);
//                    prom.center=CGPointMake(kViewWidth/2,kViewHeight*0.3);
//                    [self.view addSubview:prom];
//                    [prom MyViewRemove];
                     [DeliveryUtility showMessage:@"验证码已发送到您的手机，请查收" target:nil];
                    
                    _codeString = dict[@"code"];
                    
                    ///发送成功之后按钮不可点击 然后倒计时
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                    self.timeCount = 60;
                    ///
                    self.sendCodeButton.enabled = NO;
                    
                }
                else
                {
//                    [PromptLabel custemAlertPromAddView:self.view text:dict[@"msg"]];
                     [DeliveryUtility showMessage:dict[@"msg"] target:nil];
                }
                
                
            } withFieldBlock:^{
                
//                [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
                 [DeliveryUtility showMessage:@"请检查网络" target:nil];
            }];
        }
    }
}

#pragma mark - 倒计时
- (void)updateTimer
{
    if (self.timeCount>1) {
        self.timeCount--;
        self.textLabel.text =[NSString stringWithFormat:@"%d秒后重发",self.timeCount];
//        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重发",self.timeCount] forState:UIControlStateNormal];
    }else
    {
        //关闭计时器
        [self.timer invalidate];
//        [self.sendCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.textLabel.text = @"重新发送";
        self.sendCodeButton.enabled = YES;
    }
}

#pragma mark - 提交成功
- (void)commitButtonAction
{
    [self.view endEditing:YES];
    if ([self.phoneTextField.text isEqualToString:@""]) {
//        [PromptLabel custemAlertPromAddView:self.view text:@"请输入手机号"];
         [DeliveryUtility showMessage:@"请输入手机号码" target:nil];
    }else
    {
        if ([self.codeTextField.text isEqualToString:@""]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"请输入验证码"];
             [DeliveryUtility showMessage:@"请输入验证码" target:nil];
        }else
        {
            if ([self.codeTextField.text isEqualToString:_codeString]) {
//                [PromptLabel custemAlertPromAddView:self.view text:@"验证码不正确"];
                 [DeliveryUtility showMessage:@"验证码不正确" target:nil];
            }else
            {
                
                MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:[UIApplication sharedApplication].keyWindow];
                NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneTextField.text,@"mobile", nil];
                [HttpRequestServers requestBaseUrl:TIUser_Login withParams:userDict withRequestFinishBlock:^(id result) {
                    NSDictionary *dict = result;
                    HHNSLog(@"%@",dict);
                    if ([dict[@"code"]intValue] == 0) {
                        NSDictionary *userInfo = dict[@"data"];
                        UserLoginModel * user = [[UserLoginModel alloc]init];
                        user.user_id = userInfo[@"user_id"];
                        user.phoneNumber = self.phoneTextField.text;
                        [UserLoginModel ArchiveUser:user];
                        APP_DELEGATE.user_id = user.user_id;
                        [MBHudManager removeHud:hud scallBack:^(id obj) {
                            
                            [self.view endEditing:YES];
                            
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                    else
                    {
                        hud.labelText = @"提交成功";
                        [MBHudManager removeHud:hud scallBack:^(id obj) {
                            
                        }];
                    }
                    
                } withFieldBlock:^{
//                    [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
                     [DeliveryUtility showMessage:@"请检查网络" target:nil];
                    [MBHudManager removeHud:hud scallBack:^(id obj) {
                        
                    }];
                }];
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
