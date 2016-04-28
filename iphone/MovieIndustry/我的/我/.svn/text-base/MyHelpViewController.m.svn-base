//
//  MyHelpViewController.m
//  MovieIndustry
//
//  Created by aaa on 16/2/16.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MyHelpViewController.h"

@interface MyHelpViewController ()

@end

@implementation MyHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar1:@"帮助"];
    //这边暂时先加载百度页面
    CGRect rect = self.view.frame;
    rect.size.height -= 100;
    UIWebView * web = [[UIWebView alloc]initWithFrame:rect];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [web loadRequest:request];
    [self.view addSubview:web];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavTabBar1:(NSString *)title
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

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
