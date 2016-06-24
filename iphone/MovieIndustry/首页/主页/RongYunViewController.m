//
//  RongYunViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/23.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "RongYunViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "YourTestChatViewController.h"
@interface RongYunViewController ()

@end

@implementation RongYunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RCIM sharedRCIM] initWithAppKey:@"qf3d5gbj3my5h"];
    
    [[RCIM sharedRCIM] connectWithToken:@"M5jUEJEZsBfTmqwJs3Pp0SbYHuAAZjlWtC47uOsD645PlClQV8xiMx8cTFEo2hh492l79a9j8YDVQIhduaIRKA==" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    
    [chat setValue:[UIColor whiteColor] forKey:@"titleColor"];
    
    chat.targetId = @"KM1";
    //设置聊天会话界面要显示的标题
    chat.title = @"KM1";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
    
    //这边可以获得 聊天列表
    
//    YourTestChatViewController *chatList = [[YourTestChatViewController alloc] init];
//    [self.navigationController pushViewController:chatList animated:YES];
//    
    

    // Do any additional setup after loading the view.
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
