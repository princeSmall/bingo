//
//  VerificationUserController.m
//  MovieIndustry
//
//  Created by aaa on 16/2/24.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "VerificationUserController.h"
#import "HelpCommitSuccessController.h"
#import "HelpViewController.h"


@interface VerificationUserController ()
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)int currentNum;
@property (weak, nonatomic) IBOutlet UIButton *senderBtn;
@property (nonatomic,strong)NSString * codeStr;

@end

@implementation VerificationUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentNum = 60;
    UserLoginModel * model = [UserLoginModel UnarchiverUser];
    self.phoneNum.text = model.phoneNumber;
    self.timeLabel.layer.cornerRadius = 3;
    self.timeLabel.layer.masksToBounds = YES;
    [self setNavTabBar:@"验证手机"];
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

- (void)TimePlay{

    if (_currentNum>1) {
        _currentNum --;
            self.timeLabel.text = [NSString stringWithFormat:@"%d秒后重发",_currentNum];
    }else{
    self.timeLabel.text = @"重新发送";
        [self.timer invalidate];
        self.timer = nil;
        _currentNum = 60;
        self.senderBtn.enabled = YES;
        _codeStr = nil;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (IBAction)sendCodeAction:(UIButton*)sender {
    [self sendCodeButtonAction];
}

//这边需要判断手机验证 对的话 跳转 不对的话 提示
- (IBAction)commitAction:(id)sender {
    if ([self.codeText.text isEqualToString:self.codeStr]) {
        HelpViewController * help = [[HelpViewController alloc]init];
        [self.navigationController pushViewController:help animated:YES];
    }else{
    //验证错误
        
    }
    
}


- (void)sendCodeButtonAction
{
      self.senderBtn.enabled = NO;
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNum.text,@"mobile", nil];
            
            [HttpRequestServers requestBaseUrl:TIMessage_Verifed withParams:userDict withRequestFinishBlock:^(id result) {
                
                NSDictionary *dict = result;
                if ([dict[@"code"] intValue]==0)
                {
                    HHNSLog(@"%@",dict);
                    [DeliveryUtility showMessage:@"验证码已经发到你的手机，请查收" target:nil];
                    _codeStr = dict[@"data"][@"code"];
                    ///发送成功之后按钮不可点击 然后倒计时
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimePlay) userInfo:nil repeats:YES];
                    ///
                    self.senderBtn.enabled = NO;
                }
                else
                {
//                    [PromptLabel custemAlertPromAddView:self.view text:dict[@"msg"]];
                     [DeliveryUtility showMessage:dict[@"message"] target:nil];
                }
            } withFieldBlock:^{
//                [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
                 [DeliveryUtility showMessage:@"请检查网络" target:nil];
            }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    _codeStr = nil;
}

@end
