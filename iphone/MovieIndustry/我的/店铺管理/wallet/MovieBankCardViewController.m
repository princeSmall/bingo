//
//  MovieBankCardViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieBankCardViewController.h"

@interface MovieBankCardViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtAccount;//输入开户行

@property (strong, nonatomic) IBOutlet UITextField *txtCardNum;//输入银行卡

@property (strong, nonatomic) IBOutlet UITextField *txtName;//输入姓名

@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNum;//输入手机号


@property (strong, nonatomic) IBOutlet UITextField *txtCode;//输入验证码



@property (strong, nonatomic) IBOutlet UIButton *codeBtn;//获取验证码按钮

@end

@implementation MovieBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTabBar:@"绑定银行卡"];
    [self initBankCardView];
}


- (void)initBankCardView
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //创建尾部视图确认按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(20, 20, kViewWidth-40, 40);
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    [comfirmBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [comfirmBtn addTarget:self action:@selector(comfirmBangdingCardAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:comfirmBtn];
    
    self.tableView.tableFooterView = footerView;
}


#pragma mark - 点击获取验证码
- (IBAction)getVerifyCodeAction:(UIButton *)button {
    
    NSLog(@"点击获取验证码");
}




#pragma mark - 立即绑定银行卡
- (void)comfirmBangdingCardAction:(id)sender
{
    NSLog(@"立即绑定银行卡");
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
