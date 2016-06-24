//
//  MovieHelperDetailViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/14.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieHelperDetailViewController.h"

@interface MovieHelperDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,retain) UIWebView *detailWebView;
@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation MovieHelperDetailViewController

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

    if (self.isRegister) {
        [self setNavTabBar:@"用户服务协议"];
    }else
    {
        [self setNavTabBar:@"常见问题"];
    }
    
    [self creatHelperDetailView];
}

- (void)creatHelperDetailView
{
    self.detailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, screenWidth, screenHeight-64)];
    self.detailWebView.backgroundColor = BGColor;
    self.detailWebView.scalesPageToFit = YES;
    self.detailWebView.delegate = self;
    
    if (self.isRegister) {
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@index.php?ctl=api_search&act=help_info&cate_id=6",PREFIX]]]];
    }else
    {
        if (self.heperId) {
            [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&id=%@",Help_info,self.heperId]]]];
        }
        else{
            [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&id=%@",Help_info,@""]]]];
        }
    }
    
    
    
    
    [self.view addSubview:self.detailWebView];
    self.detailWebView.alpha = 0;
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
    self.detailWebView.alpha = 1;
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
