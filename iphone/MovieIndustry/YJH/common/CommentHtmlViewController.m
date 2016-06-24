//
//  DeliveryHtmlDatasViewController.m
//  Delivery_iOS
//
//  Created by 童乐 on 15/10/31.
//  Copyright (c) 2015年 yuejue. All rights reserved.
//

#import "CommentHtmlViewController.h"

@interface CommentHtmlViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) MBProgressHUD *HUD;

@property (nonatomic,retain) UIWebView *mainWebView;


@end

@implementation CommentHtmlViewController

- (MBProgressHUD *)HUD
{
    if (nil == _HUD) {
        _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _HUD.labelText = @"正在加载";
    }
    return _HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:self.titleName];
    [self createHtmlMainWebView];
}



- (void)createHtmlMainWebView
{
    self.mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, screenWidth, screenHeight-64)];
    self.mainWebView.backgroundColor = BGColor;
    self.mainWebView.scalesPageToFit = YES;
    self.mainWebView.delegate = self;
    
//    if (self.heperId) {
        [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//    }
//    else{
//        [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&id=%@",Help_info,@""]]]];
//    }
    
    
    [self.view addSubview:self.mainWebView];
    self.mainWebView.alpha = 0;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.HUD show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.HUD.labelText = @"加载成功";
    [self.HUD hide:YES];
    self.mainWebView.alpha = 1;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.HUD.labelText = @"加载失败";
    [self.HUD hide:YES afterDelay:0.3];
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
