//
//  ShippingAddressListController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/4.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShippingAddressListController.h"
#import "ManagerShippingAddressController.h"
#import "ShippingAddressCell.h"
#import "ProvinceModel.h"


@interface ShippingAddressListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tbView;
///地址数据
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ShippingAddressListController

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
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
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
    [self setNavRightItem:@"管理" rightAction:@selector(managerAddressAction:)];
    [self.view addSubview:self.tbView];
    [self loadAddressList];
    
}
#pragma mark - 管理收货地址
- (void)managerAddressAction:(UIButton *)btn
{
    ManagerShippingAddressController *manVC = [[ManagerShippingAddressController alloc] init];
    [self.navigationController pushViewController:manVC animated:YES];
}

#pragma mark - 查询收货地址 用于判断是否有默认地址
- (void)loadAddressList
{
    HHNSLog(@"%@",[UserInfo uid]);
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [HttpRequestServers requestBaseUrl:TIShipping_AddrList withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"-------->%@",dict);
        
        if ([dict[@"code"] intValue] == 0) {
            [self.dataArray removeAllObjects];
            NSDictionary *morenDict;
            
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
                //                    NSString * string = listDict[@"spare_address"];
                //                    NSArray * strArray = [string componentsSeparatedByString:@","];
                //                    NSString * regionArea = [ProvinceModel GetStrFormArray:strArray];
                
                
                
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
           
        }
    } withFieldBlock:^{
        
//        [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
         [DeliveryUtility showMessage:@"请检查网络" target:nil];
        
    }];}




#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
    ShippingAddressModel *model = self.dataArray[indexPath.row];
    NSString * consigneeStr = [NSString stringWithFormat:@"收货人：%@",model.consignee];
    [self.delegate setAddressWithConsignee:consigneeStr andAddress:[NSString stringWithFormat:@"收货地址：%@%@",model.regionArea,model.address] andTel:model.tel andAddress_id:model.address_id];
    
    APP_DELEGATE.addressPalce = model.address_id;
    [self.dele CreateOrder];
    
    [self.navigationController popViewControllerAnimated:YES];
}


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
