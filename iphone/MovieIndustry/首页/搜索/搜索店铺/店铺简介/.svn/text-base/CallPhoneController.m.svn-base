//
//  CallPhoneController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CallPhoneController.h"

@interface CallPhoneController ()
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation CallPhoneController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _webView=[[UIWebView alloc] init];
        
    }
    return self;
}



-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self removeFromParentViewController];
}


+(void)call:(NSString *)number inViewController:(UIViewController *)vc failBlock:(void(^)())failBlock
{
    
    //拨打电话
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
    
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    
    if(!canOpen){//不能打开
        if(failBlock!=nil) failBlock(); return;
    }
    
    CallPhoneController *phoneVC=[[CallPhoneController alloc] init];
    
    [vc addChildViewController:phoneVC];
    
    phoneVC.view.frame=CGRectZero;
    phoneVC.view.alpha=.0f;
    
    [vc.view addSubview:phoneVC.view];
    
    //打电话
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [phoneVC.webView loadRequest:request];
}



-(void)dealloc
{
    self.webView=nil;
}



@end
