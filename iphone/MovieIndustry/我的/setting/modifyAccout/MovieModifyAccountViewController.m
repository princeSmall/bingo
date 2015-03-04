//
//  MovieModifyAccountViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieModifyAccountViewController.h"

@interface MovieModifyAccountViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtNewPhone;//新手机号
@property (strong, nonatomic) IBOutlet UITextField *txtOriginPassword;//原密码
@property (strong, nonatomic) IBOutlet UITextField *txtNewPassword;//新密码
@property (strong, nonatomic) IBOutlet UITextField *txtComfimPassword;//确认新密码


/** 原密码 */
@property (nonatomic,copy) NSString *originPsw;


@end

@implementation MovieModifyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.originPsw = @"123123";
    
    [self setNavTabBar:@"修改账号"];
    [self addInputeWordNotification];
}

- (void)viewKwyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

- (void)addInputeWordNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAccountTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtNewPhone];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAccountTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtOriginPassword];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAccountTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtNewPassword];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAccountTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtComfimPassword];
}

- (void)changeAccountTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtNewPassword || textField == self.txtComfimPassword || textField == self.txtOriginPassword) {
        //店铺名称,职业,联系人
        kMaxLength = 16;
    }
    else {
        kMaxLength = 11;
    }
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self viewKwyboardDown];
}




#pragma mark - 确认修改账号
- (IBAction)comfirmModifyNewAccount:(id)sender {
    
    if ([self checkModifyInfoValid]) {
        
        NSLog(@"确认修改账号被点击");
    }
}

- (BOOL)checkModifyInfoValid
{
    NSString *telStr = [self.txtNewPhone.text asTrim];
    NSString *oldPsw = [self.txtOriginPassword.text asTrim];
    NSString *newPsw1 = [self.txtNewPassword.text asTrim];
    NSString *newPsw2 = [self.txtComfimPassword.text asTrim];
    
    //判断手机号
    if ([telStr isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入您的手机号" target:self];
        return NO;
    }
    else if (![DeliveryUtility isPureInt:telStr])
    {
        [DeliveryUtility showMessage:@"手机号有误,请重新输入" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:telStr]){
        [DeliveryUtility showMessage:@"手机号不可包含非法字符" target:self];
        return NO;
    }
    
    //判断原密码
    if ([oldPsw isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入原密码" target:self];
        return NO;
    }
    else if (![oldPsw isEqualToString:self.originPsw])
    {
        [DeliveryUtility showMessage:@"原密码有误,请从新输入" target:self];
        return NO;
    }
    
    //判断新密码
    if ([newPsw1 isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入新密码" target:self];
        return NO;
    }
    else if (newPsw1.length<6 || newPsw1.length>16)
    {
        [DeliveryUtility showMessage:@"密码应为6~16字母和数字组成" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:newPsw1]){
        [DeliveryUtility showMessage:@"密码不可包含非法字符" target:self];
        return NO;
    }
    
    //判断确认新密码
    if ([newPsw1 isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请再次输入新密码" target:self];
        return NO;
    }
    else if (newPsw1.length<6 || newPsw1.length>16)
    {
        [DeliveryUtility showMessage:@"密码应为6~16字母和数字组成" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:newPsw1]){
        [DeliveryUtility showMessage:@"密码不可包含非法字符" target:self];
        return NO;
    }
    else if (![newPsw1 isEqualToString:newPsw2])
    {
        [DeliveryUtility showMessage:@"新密码不一致,请重新输入" target:self];
        return NO;
    }
    
    return YES;
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
