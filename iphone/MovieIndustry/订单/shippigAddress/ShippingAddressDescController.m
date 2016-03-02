//
//  ShippingAddressDescController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShippingAddressDescController.h"
#import "ResettingAddressController.h"

@interface ShippingAddressDescController ()<UIActionSheetDelegate,ResettingAddressControllerDelegate>

@end

@implementation ShippingAddressDescController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"收货地址"];
    [self setNavRightItem:@"修改" rightAction:@selector(resetAddressAction)];
    
    ///设置地址信息
    self.consigneeLabel.text = self.model.consignee;
    self.phoneLabel.text = self.model.tel;
    self.postCodeLabel.text = self.model.youbian;
    self.areaLabel.text = self.model.regionArea;
    self.addressLabel.text = [NSString stringWithFormat:@"%@",self.model.address];
    [self.deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (![self.model.status isEqualToString:@"1"]) {
        ///添加底部视图
        [self createBottomView];
    }
    
    
}

- (void)createBottomView
{
    UIView *bottomView = [WNController createViewFrame:CGRectMake(0, kViewHeight-44-40, kViewWidth, 40)];
    bottomView.backgroundColor = kViewBackColor;
    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2-60, 0, 120, 30) ImageName:@"" Target:self Action:@selector(setMorenAddress) Title:@"设成默认收货地址" fontSize:12];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0.92 green:0.08 blue:0 alpha:1];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [bottomView addSubview:btn];
    [self.view addSubview:bottomView];
}

#pragma mark - 设置成默认地址
- (void)setMorenAddress
{
    MBProgressHUD *HUD= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在设置";
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.model.address_id,@"shipping_address_id", nil];
    [HttpRequestServers requestBaseUrl:TIShipping_addrDefault withParams:userDict withRequestFinishBlock:^(id result) {

        NSDictionary *dict = result;
        HHNSLog(@"--------> %@",dict);
        @try {
            if ([dict[@"code"]intValue] == 0) {
                HUD.labelText = @"设置成功";
                [HUD hide:YES afterDelay:0.3];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        @catch (NSException *exception) {
            [HUD hide:YES afterDelay:0.3];
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        HUD.labelText = kNetWork_ERROR;
        [HUD hide:YES afterDelay:0.3];
    }];

}

- (void)resetAddressAction
{
    ResettingAddressController *resetVc = [[ResettingAddressController alloc] init];
    resetVc.model = self.model;
    resetVc.delegate = self;
    [self.navigationController pushViewController:resetVc animated:YES];
}

- (void)deleteButtonAction
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"确定删除收货地址,此操作不可逆." delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    [action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self deleteShippingAddress:self.model.address_id];
        
    }
}

#pragma mark - 删除地址
- (void)deleteShippingAddress:(NSString *)addressID
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",addressID,@"shipping_address_id", nil];
    [HttpRequestServers requestBaseUrl:TIShipping_DeleteAddr withParams:userDict withRequestFinishBlock:^(id result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dict = result;
//        HHNSLog(@"--------> %@",dict);
        @try {
            if ([dict[@"code"] intValue] == 0) {
                
//                [PromptLabel custemAlertPromAddView:self.view text:@"删除成功"];
                 [DeliveryUtility showMessage:@"删除成功" target:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else if([dict[@"message"] isEqualToString:@"最少一个地址"]){
            
//            [PromptLabel custemAlertPromAddView:self.view text:@"最少留一个地址"];
                 [DeliveryUtility showMessage:@"最少保留一个地址信息" target:nil];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
}
#pragma mark - 修改成功之后掉这个方法
- (void)setConsignee:(NSString *)consignee andPhoneNumber:(NSString *)phoneNumber andAddress:(NSString *)address andPostCode:(NSString *)postCode andProviceArea:(NSString *)proviceArea
{
    self.consigneeLabel.text = consignee;
    self.phoneLabel.text = phoneNumber;
    self.postCodeLabel.text = postCode;
    self.areaLabel.text = proviceArea;
    self.addressLabel.text = [NSString stringWithFormat:@"%@",address];
}

- (void)sendModel:(ShippingAddressModel *)model{
    self.model = model;
    self.consigneeLabel.text = self.model.consignee;
    self.phoneLabel.text = self.model.tel;
    self.postCodeLabel.text = self.model.youbian;
    self.areaLabel.text = [NSString stringWithFormat:@"%@%@%@",self.model.province_name,self.model.city_name,self.model.district_name];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",self.model.address];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
