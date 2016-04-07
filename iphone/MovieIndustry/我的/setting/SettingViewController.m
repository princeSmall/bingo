//
//  SettingViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SettingViewController.h"
#import "MovieCreateMineShopViewController.h"
#import "MovieHelperViewController.h"
#import "MovieModifyAccountViewController.h"
#import "MoviePrivacyViewController.h"
#import "ManagerShippingAddressController.h"
#import "LoginInController.h"
#import "HelpViewController.h"
#import "VerificationUserController.h"
#import "FeedbackViewController.h"


@interface SettingViewController ()<UIAlertViewDelegate>
/**
 *  是否点击退出登录  是 为yes; 否  为no
 */
@property (nonatomic,assign)BOOL existFlag;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置缓存显示
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
    self.clearCacheLabel.text = [NSString stringWithFormat:@"%@",currentVolum];
    [self setNavTabBar:@"设置"];
}
- (void)backAction
{
        [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidAppear:(BOOL)animated
{
    if(self.existFlag==YES)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - 我要开店
- (IBAction)createMineShopAction:(UIButton *)sender {
    NSLog(@"开店");
//    if (![self.locationId isEqualToString:@"0"]) {
//        [DeliveryUtility showMessage:@"您已经开通店铺啦~" target:self];
//        return;
//    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
    MovieCreateMineShopViewController *createShopVC = [storyboard instantiateViewControllerWithIdentifier:@"createMineShop"];
    [self.navigationController pushViewController:createShopVC animated:YES];
}


#pragma mark - 修改账号
- (IBAction)modifyMineAccountAction:(UIButton *)sender
{
   VerificationUserController  *paySucVc = [[VerificationUserController alloc] init];
//    paySucVc.type = @"1";
    [self.navigationController pushViewController:paySucVc animated:YES];
//    UIStoryboard *storeboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
//    MovieModifyAccountViewController *modifyVC = [storeboard instantiateViewControllerWithIdentifier:@"changeAccount"];
//    [self.navigationController pushViewController:modifyVC animated:YES];
}


#pragma mark - 收货地址
- (IBAction)minePrivateAction:(UIButton *)sender {
    
    ManagerShippingAddressController *managerVc = [[ManagerShippingAddressController alloc] init];
    [self.navigationController pushViewController:managerVc animated:YES];
    
}

#pragma mark - 帮助与反馈
- (IBAction)helperAndRecommended:(UIButton *)sender {
    
    FeedbackViewController * feed = [[FeedbackViewController alloc]init];
    [self.navigationController pushViewController:feed animated:YES];
//    MovieHelperViewController *helperView = [[MovieHelperViewController alloc] init];
//    [self.navigationController pushViewController:helperView animated:YES];
}




#pragma mark - 清空缓存
- (IBAction)clearCacheAction:(id)sender {
    
    //获取缓存的大小
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    //
    NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"确认清理%@缓存?",currentVolum] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    [alert show];

}

#pragma mark - 计算缓存大小
//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

#pragma mark - 退出登录
- (IBAction)quietLoginAction:(UIButton *)sender {
    
    self.existFlag = YES;
    LoginInController *loginVc = [[LoginInController alloc] init];
    UINavigationController *navLogin = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [self.navigationController presentViewController:navLogin animated:YES completion:^{
        APP_DELEGATE.user_id = nil;
        [UserLoginModel ArchiveUser:nil];
    }];
;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 101) {
            //获取缓存的大小
            NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
            //
            NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
//            [PromptLabel custemAlertPromAddView:self.view text:[NSString stringWithFormat:@"成功清理%@缓存",currentVolum]];
            [[SDImageCache sharedImageCache] clearDisk];
            self.clearCacheLabel.text = [NSString stringWithFormat:@"有0K缓存"];
        }
        
    }
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
