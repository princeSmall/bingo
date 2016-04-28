//
//  MovieHelpViewController.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/27.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieHelpViewController.h"

@interface MovieHelpViewController ()<UIWebViewDelegate>

@property (nonatomic ,strong)UIWebView *webView;
@end

@implementation MovieHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTabBar:@"帮助"];
    [self createWebView];
    [self loadData];
}

-(void)createWebView
{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];

}

-(void)loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary ];
    param[@"id"] = @"1";
    [HttpRequestServers requestBaseUrl:TIInformation_info withParams:param withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"TINews_Discusslist:%@",dict);
        if([dict[@"code"] intValue]==0)
        {
            self.webView.delegate = self;

            [self.webView loadHTMLString:dict[@"data"][@"content"] baseURL:nil];
        }
    } withFieldBlock:^{
        
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
//    webView.userInteractionEnabled = NO;
//    if (self.view.frame.size.width == 320) {
//        [webView stringByEvaluatingJavaScriptFromString:
//         @"var script = document.createElement('script');"
//         "script.type = 'text/javascript';"
//         "script.text = \"function ResizeImages() { "
//         "var myimg,oldwidth;"
//         "var maxwidth = 320.0;" // UIWebView中显示的图片宽度
//         "for(i=0;i <document.images.length;i++){"
//         "myimg = document.images[i];"
//         "oldwidth = myimg.width;"
//         "if(oldwidth > maxwidth){"
//         "myimg.width = maxwidth;"
//         "myimg.height *= (maxwidth/oldwidth)*2;"
//         "}"
//         "}"
//         "}\";"
//         "document.getElementsByTagName('head')[0].appendChild(script);"];
//    }else if (self.view.frame.size.width == 375){
//        [webView stringByEvaluatingJavaScriptFromString:
//         @"var script = document.createElement('script');"
//         "script.type = 'text/javascript';"
//         "script.text = \"function ResizeImages() { "
//         "var myimg,oldwidth;"
//         "var maxwidth = 375.0;" // UIWebView中显示的图片宽度
//         "for(i=0;i <document.images.length;i++){"
//         "myimg = document.images[i];"
//         "oldwidth = myimg.width;"
//         "if(oldwidth > maxwidth){"
//         "myimg.width = maxwidth;"
//         "myimg.height *= (maxwidth/oldwidth)*2 -10;"
//         "}"
//         "}"
//         "}\";"
//         "document.getElementsByTagName('head')[0].appendChild(script);"];
//    }else{
//        [webView stringByEvaluatingJavaScriptFromString:
//         @"var script = document.createElement('script');"
//         "script.type = 'text/javascript';"
//         "script.text = \"function ResizeImages() { "
//         "var myimg,oldwidth;"
//         "var maxwidth = 414.0;" // UIWebView中显示的图片宽度
//         "for(i=0;i <document.images.length;i++){"
//         "myimg = document.images[i];"
//         "oldwidth = myimg.width;"
//         "if(oldwidth > maxwidth){"
//         "myimg.width = maxwidth;"
//         "myimg.height *= (maxwidth/oldwidth)*2-20;"
//         "}"
//         "}"
//         "}\";"
//         "document.getElementsByTagName('head')[0].appendChild(script);"];
//    }
    
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    CGFloat webHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    CGRect webFrame = self.webView.frame;
    webFrame.size.height = webHeight-64;
    
    self.webView.frame = webFrame;
    
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
