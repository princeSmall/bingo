//
//  ManagerShippingAddressController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/4.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ManagerShippingAddressController.h"
#import "ShippingAddressController.h"
#import "ShippingAddressDescController.h"
#import "ShippingAddressCell.h"
#import "ProvinceModel.h"
#import "ShippingAddressListController.h"


@interface ManagerShippingAddressController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tbView;
///地址数据
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ManagerShippingAddressController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kViewWidth, kViewHeight-44-40-30) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.backgroundColor = kViewBackColor;
        _tbView.tableFooterView = [[UIView alloc] init];
    }
    return _tbView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadAddressList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"选择收货地址"];
    
    [self.view addSubview:self.tbView];
    //最多添加5个收货地址
    UILabel * topShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    topShowLabel.text = @"最多添加5个收货地址";
    topShowLabel.textAlignment = NSTextAlignmentCenter;
    topShowLabel.backgroundColor = [UIColor lightGrayColor];
    topShowLabel.font = [UIFont systemFontOfSize:14];
    topShowLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:topShowLabel];
    //        self.bgView.backgroundColor = [UIColor colorWithRed:0.46 green:0.47 blue:0.51 alpha:1];
    [self createBottomView];
    
    
}

- (void)createBottomView
{
    UIView *bottomView = [WNController createViewFrame:CGRectMake(0, kViewHeight-44-40, kViewWidth, 40)];
    bottomView.backgroundColor = kViewBackColor;
    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth, 40) ImageName:@"" Target:self Action:@selector(addShippingAddress:) Title:@"添加新的收货地址" fontSize:15];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor colorWithRed:0.92 green:0.08 blue:0 alpha:1];
//    btn.layer.cornerRadius = 10;
//    btn.clipsToBounds = YES;
    [bottomView addSubview:btn];
    [self.view addSubview:bottomView];
}

#pragma mark - 添加收货地址 
- (void)addShippingAddress:(UIButton *)btn
{
    if (self.dataArray.count == 5) {
//     [PromptLabel custemAlertPromAddView:self.view text:@"最多可添加5个地址"];
          [DeliveryUtility showMessage:@"最多可添加5个地址" target:nil];
    }else{
    
    ShippingAddressController *addSdVc = [[ShippingAddressController alloc] init];
        [self.navigationController pushViewController:addSdVc animated:YES];}
}

#pragma mark - 查询收货地址 用于判断是否有默认地址
- (void)loadAddressList
{
    NSMutableDictionary * userDict = [NSMutableDictionary dictionary];
    userDict[@"user_id"] = APP_DELEGATE.user_id;

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HttpRequestServers requestBaseUrl:TIShipping_AddrList withParams:userDict withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"-------->%@",dict);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([dict[@"code"] intValue] == 0) {
                [self.dataArray removeAllObjects];
                NSDictionary *morenDict;
                
                if (![dict[@"data"] isKindOfClass:[NSArray class]]) {
                    
                }else{
                
                NSMutableArray * mutArray = [NSMutableArray arrayWithArray:dict[@"data"]];
                for (NSDictionary * dic in mutArray) {
                    if ([dic[@"is_default"] isEqualToString:@"1"]) {
                        morenDict = dic;
                        [mutArray removeObject:dic];
                        break;
                    }
                }
                    ShippingAddressModel *morenModel = [[ShippingAddressModel alloc] init];
                     NSString * userAddress;
                morenModel.province_name = morenDict[@"province_name"];
                morenModel.province_id = morenDict[@"province_id"];
                morenModel.city_name = morenDict[@"city_name"];
                morenModel.city_id = morenDict[@"city_id"];
                morenModel.district_name = morenDict[@"district_name"];
                morenModel.district_id = morenDict[@"district_id"];
                
               NSString * regionArea = [NSString stringWithFormat:@"%@%@%@",morenDict[@"province_name"],morenDict[@"city_name"],morenDict[@"district_name"]];
                userAddress = morenDict[@"addr_detail"];
                morenModel.youbian = morenDict[@"post_code"];
                    morenModel.address = userAddress;
                    morenModel.address_id = morenDict[@"shipping_address_id"];
                    morenModel.consignee = morenDict[@"consignee_name"];
                morenModel.regionArea = regionArea;                    morenModel.tel = morenDict[@"mobile"];
                    morenModel.moren = @"1";
                    [self.dataArray addObject:morenModel];
                for (NSDictionary *listDict in mutArray) {
                        ShippingAddressModel *model = [[ShippingAddressModel alloc] init];
                    NSString * userAddress1;
                        userAddress1 = listDict[@"addr_detail"];
                    model.address = userAddress1;
                    model.address_id = listDict[@"shipping_address_id"];
                    model.consignee = listDict[@"consignee_name"];
                    model.youbian = listDict[@"post_code"];
                    model.regionArea = [NSString stringWithFormat:@"%@%@%@",listDict[@"province_name"],listDict[@"city_name"],listDict[@"district_name"]];
                    model.tel = listDict[@"mobile"];
                    
                    model.province_name = listDict[@"province_name"];
                    model.province_id = listDict[@"province_id"];
                    model.city_name = listDict[@"city_name"];
                    model.city_id = listDict[@"city_id"];
                    model.district_name = listDict[@"district_name"];
                    model.district_id = listDict[@"district_id"];
                    [self.dataArray addObject:model];
                    
                }
                [self.tbView reloadData];
                [self createBottomView];
            }
            } } withFieldBlock:^{
        
//        [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
                  [DeliveryUtility showMessage:@"请检查网络" target:nil];
        
    }];
}




#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"managerShipingAddressCellID";
    ShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShippingAddressCell" owner:self options:nil] lastObject];
    }
    ShippingAddressModel *model = self.dataArray[indexPath.row];
    [cell config:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressDescController *saDescVc = [[ShippingAddressDescController alloc] init];
    ShippingAddressModel *model = self.dataArray[indexPath.row];
    saDescVc.model = model;
    [self.navigationController pushViewController:saDescVc animated:YES];
}

#pragma mark - 滑动删除效果
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 调用删除接口
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressModel *model = self.dataArray[indexPath.row];
    [self deleteShippingAddress:model.address_id];
    
    self.tbView.editing = NO;
}

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
                  [DeliveryUtility showMessage:@"删除成功！" target:nil];
                [self loadAddressList];
                
                
            }else if([dict[@"message"] isEqualToString:@"最少一个地址"]){
                
//                [PromptLabel custemAlertPromAddView:self.view text:@"最少留一个地址"];
                  [DeliveryUtility showMessage:@"最少保留一个收货地址！" target:nil];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
}



#pragma mark - 修改删除的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 删除地址


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
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
