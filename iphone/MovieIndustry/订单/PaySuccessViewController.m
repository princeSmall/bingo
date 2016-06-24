//
//  PaySuccessViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "MovieOrderDetailViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.OrderDetailButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backHomeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.OrderDetailButton addTarget:self action:@selector(lookOrderDescAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backHomeButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setNavTabBar:@"支付成功"];
    
}

#pragma mark - 查看
- (void)lookOrderDescAction
{
    MovieOrderDetailViewController *orderDescVc = [[MovieOrderDetailViewController alloc] init];
    orderDescVc.order_id = self.order_id;
    orderDescVc.orderNum = self.order_SN;
    orderDescVc.order_status = @"2";
   orderDescVc.backRoot = @"1";
    [self.navigationController pushViewController:orderDescVc animated:YES];
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
    [leftBtn addTarget:self action:@selector(backNavigation) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

//返回根视图
- (void)backAction
{
    NSArray *viewArray = [NSArray arrayWithObject:self.navigationController.viewControllers[0]];
    self.navigationController.viewControllers = viewArray;
    APP_DELEGATE.tbbC.selectedViewController = APP_DELEGATE.tbbC.viewControllers[0];
}

-(void)backNavigation
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
