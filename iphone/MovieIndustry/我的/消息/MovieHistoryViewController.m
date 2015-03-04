//
//  MovieHistoryViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieHistoryViewController.h"
#import "MovieHistoryActiveCell.h"
#import "MovieMineNeedsRushedModel.h"
#import "MovieGoodsInfoViewController.h"
#import "SearchShopResultController.h"

@interface MovieHistoryViewController ()<UITableViewDataSource,UITableViewDelegate,MovieRequestGoodsInfoDelegate>

@property (nonatomic,strong) UITableView *mainTableView;

/** 清单列表数据 */
@property (nonatomic,strong) NSMutableArray *rushArray;

@property (nonatomic,assign) int page;

@end

@implementation MovieHistoryViewController

- (NSMutableArray *)rushArray
{
    if (nil == _rushArray) {
        _rushArray = [NSMutableArray new];
    }
    return _rushArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"抢单列表"];
    [self createHistoryRecordActiveAction];
    [self setMineRushTableViewRefresh];
}

- (void)createHistoryRecordActiveAction
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    UIColor *bgColor = RGBColor(234,234,234,1);
//    self.view.backgroundColor = bgColor;
    self.mainTableView.backgroundColor = kViewBackColor;
}


#pragma mark - 请求我的需求抢单列表的数据
- (void)requestRushOrderListDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createMineNeedsRushedListWithPage:_page andRentId:self.rentId CallBack:^(id obj) {
        
        
        if (1 == _page) {
            self.rushArray = [NSMutableArray arrayWithArray:obj];
        }
        else{
            [self.rushArray addObjectsFromArray:obj];
        }
        
        [HUD hide:YES];
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rushArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIdentifier";
    MovieHistoryActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieHistoryActiveCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MovieMineNeedsRushedModel *rushModel = _rushArray[indexPath.section];
    cell.delegate = self;
    [cell setRushInfoModel:rushModel];
    
    return cell;
}


#pragma mark -- UITableViewDelegate
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieMineNeedsRushedModel *rushModel = _rushArray[indexPath.section];
    NSArray *goodsInfoArray = rushModel.dealInfo;
    return (goodsInfoArray.count)?265:85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieMineNeedsRushedModel *rushModel = _rushArray[indexPath.section];
    SearchShopResultController *shopVC = [[SearchShopResultController alloc] init];
    shopVC.shopId = rushModel.locationId;
    [self.navigationController pushViewController:shopVC animated:YES];
}


#pragma mark - 添加列表上下了刷新功能
- (void)setMineRushTableViewRefresh
{
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        _page = 1;
        [self requestRushOrderListDatas];
    }];
    
    [self.mainTableView.header beginRefreshing];
    
    self.mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        [self requestRushOrderListDatas];
    }];
}


#pragma mark - 点击商品到商品详情
- (void)checkToSkimGoodInfoWithStoreId:(NSString *)storeId andGoodId:(NSString *)goodId
{
    HHNSLog(@"商店Id --> %@\n商品Id --> %@",storeId,goodId);
    
    MovieGoodsInfoViewController *goodDetailVC = [[MovieGoodsInfoViewController alloc] init];
    goodDetailVC.shopID = storeId;
    goodDetailVC.goodsId = goodId;
    [self.navigationController pushViewController:goodDetailVC animated:YES];
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
