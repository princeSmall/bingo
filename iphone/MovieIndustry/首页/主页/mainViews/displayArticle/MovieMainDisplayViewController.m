//
//  MovieMainDisplayViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/12/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieMainDisplayViewController.h"

@interface MovieMainDisplayViewController ()<UIWebViewDelegate>

@property (nonatomic,retain) UIWebView *articleWebView;

@property (nonatomic,retain) MBProgressHUD *webHUD;


@end

@implementation MovieMainDisplayViewController

- (MBProgressHUD *)webHUD
{
    if (nil == _webHUD) {
        _webHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _webHUD.labelText = @"正在加载";
    }
    
    return _webHUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBtnAndTitle];
    [self createDisplayActiveArticleView];
}

- (void)setNavBtnAndTitle
{
    if (self.viewTitle) {
        [self setNavTabBar:self.viewTitle];
    }else{
        [self setNavTabBar:@"详情"];
    }
}

- (void)createDisplayActiveArticleView
{
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, 1)];
//    line.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:line];
    
    self.articleWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, screenWidth, screenHeight-64)];
    self.articleWebView.backgroundColor = BGColor;
    self.articleWebView.scalesPageToFit = YES;
    self.articleWebView.delegate = self;
    
    [self.articleWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:MainPageDisplay_Article]]];
    
    [self.view addSubview:self.articleWebView];
    self.articleWebView.alpha = 0;
}



#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [self.webHUD show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webHUD.labelText = @"加载成功";
    [self.webHUD hide:YES];
    self.articleWebView.alpha = 1;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.webHUD.labelText = @"加载失败";
    [self.webHUD hide:YES];
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
