//
//  TradeRecordController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/8.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "TradeRecordController.h"
//#import "TradeRecordCell.h"
#import "MovieTradeRecordModel.h"
#import "BtnSelectView.h"
#import "AllOrderCell.h"
#import "MyOrderCellFooter.h"
#import "MyOrderCellHeader.h"
#import "TradeFootCell.h"
#import "TradeHeadCell.h"
#import "OrderGoodsModel.h"
#import "OrderShopModel.h"
#import "OrderDataModel.h"

@interface TradeRecordController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
}

@property (nonatomic,strong) NSMutableArray *recordArray;
@property (nonatomic,assign) int page;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,strong) NSMutableArray *shopArray;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *goodsArray;

@property (nonatomic,strong) NSMutableArray *orderArray;

@end

@implementation TradeRecordController

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)goodsArray
{
    if (nil == _goodsArray) {
        _goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (NSMutableArray *)orderArray
{
    if (nil == _orderArray) {
        _orderArray = [NSMutableArray new];
    }
    return _orderArray;
}

- (NSMutableArray *)recordArray
{
    if (nil == _recordArray) {
        _recordArray = [NSMutableArray new];
    }
    return _recordArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"交易记录"];
    self.page=0;
    self.status=@"0";
    [self createTableView];
    [self setupTableViewRefresh];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight-44) style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    [self.view addSubview:_tbView];
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    NSArray * arraySelect = @[@"全部",@"待发货",@"待发货",@"待收货",@"待评价"];
    BtnSelectView * viewSelect = [[BtnSelectView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45) AndArray:arraySelect AndClickBlock:^(int arrayIndex) {
        NSLog(@"%d",arrayIndex);
        NSString *status;
        if(arrayIndex==0)
        {
            status =[NSString stringWithFormat:@"0"];
          
        }
        if(arrayIndex==1)
        {
            status =[NSString stringWithFormat:@"2"];
            
        }
        if(arrayIndex==2)
        {
            status =[NSString stringWithFormat:@"3"];
            
        }
        if(arrayIndex==3)
        {
            status =[NSString stringWithFormat:@"4"];
            
        }
        if(![self.status isEqualToString: status])
        {
            self.page= 1;
        }
        self.status = status;
        
        [self requestMinetradeRecordInfo];
    }];
    _tbView.tableHeaderView = viewSelect;
}

#pragma mark - 请求交易记录数据
- (void)requestMinetradeRecordInfo
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    [userDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [userDict setObject:self.status forKey:@"status"];
    [userDict setObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    [HttpRequestServers requestBaseUrl:TIOrder_OrderList withParams:userDict withRequestFinishBlock:^(id result) {
        [HUD hide:YES];
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        @try {
            
            if ([dict[@"code"] intValue]==0)
            {
                
                if (self.page == 1) {
                    ///开始要把数据清空
                    [self.shopArray removeAllObjects];
                    [self.dataArray removeAllObjects];
                }
                
                

                NSArray *listArray = dict[@"data"];
                id arr = dict[@"data"];
                if(![[arr class] isSubclassOfClass:[NSArray class]])
                {
                    [_tbView.header endRefreshing];
                    [_tbView reloadData];
                    [_tbView.footer endRefreshing];
                    
                    return ;
                }
                
                for (NSDictionary *ordelDcit  in listArray)
                {
                    OrderDataModel *ordelModel = [[OrderDataModel alloc]init];
                    ordelModel.order_id = ordelDcit[@"order_id"];
                    ordelModel.order_amount = ordelDcit[@"order_amount"];
                    ordelModel.order_status = ordelDcit[@"order_status"];
                    ordelModel.pay_status = ordelDcit[@"pay_status"];
                    ordelModel.shop_status = ordelDcit[@"shop_status"];
                    ordelModel.order_shops = ordelDcit[@"order_shops"];
                    ordelModel.status = ordelDcit[@"status"];
                    
                    NSLog(@"%@",ordelModel.order_shops);
                    
                    
                    [self.orderArray addObject:ordelModel];
                    ///遍历商品数组 ///添加可变数组
                    self.shopArray = [NSMutableArray array];
                    for (NSDictionary *goodsDict in ordelDcit[@"order_shops"])
                    {
                        self.goodsArray = [NSMutableArray array];
                        OrderShopModel *goodsModel = [[OrderShopModel alloc] init];
                        goodsModel.shop_id = goodsDict[@"order_id"];
                        goodsModel.shop_name = goodsDict[@"shop_name"];
                        goodsModel.shop_logo = goodsDict[@"shop_logo"];
                        goodsModel.shop_tel = goodsDict[@"shop_tel"];
                        goodsModel.shop_goods = goodsDict[@"shop_goods"];
                        
                        NSArray *arr = goodsDict[@"shop_goods"];
                        for(NSDictionary *goodsDetailDic in arr)
                        {
                            OrderGoodsModel * goodsDetailModel = [[OrderGoodsModel alloc]init];
                            goodsDetailModel.order_id = goodsDetailDic[@"order_id"];
                            goodsDetailModel.shop_id = goodsDetailDic[@"shop_id"];
                            goodsDetailModel.goods_id = goodsDetailDic[@"goods_id"];
                            goodsDetailModel.goods_name = goodsDetailDic[@"goods_name"];
                            goodsDetailModel.goods_number = goodsDetailDic[@"goods_number"];
                            goodsDetailModel.goods_price = goodsDetailDic[@"goods_price"];
                            goodsDetailModel.name_value_str = goodsDetailDic[@"name_value_str"];
                            goodsDetailModel.img_path =goodsDetailDic[@"img_path"];
                            
                            [self.goodsArray addObject:goodsDetailModel];
                        }
                        
                        ///添加到数组里面
                        [self.shopArray addObject:self.goodsArray];
                        
                    }
                    ////商品数据添加到数据源数组
                    
                    [self.dataArray addObject:ordelModel];
                    
                    
                }
                
                HUD.labelText = @"加载成功";
                [HUD hide:YES afterDelay:0.25];
                [_tbView reloadData];
                //结束刷新
                [_tbView.header endRefreshing];
                [_tbView.footer endRefreshing];
                
              
            }else
            {
                
                [HUD hide:YES afterDelay:0.25];
            }
            
        }
        @catch (NSException *exception) {
            
            [HUD hide:YES afterDelay:0.25];
        }
        @finally {
            
        }
    } withFieldBlock:^{
        
    }];
        
//        [_tbView.header endRefreshing];
//        [_tbView.footer endRefreshing];
//        [DeliveryUtility showMessage:obj target:self];
 
}


#pragma mark - tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataArray.count==0)
    {
        return 0;
    }
    else
    {
    OrderDataModel*data=  self.dataArray[section];
    NSArray *goodsListArr = data.order_shops;
    NSArray *goodsArray = goodsListArr[0][@"shop_goods"];
    return goodsArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"tradeCellID";
    AllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AllOrderCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderDataModel*data=  self.dataArray[indexPath.section];
    NSArray *goodsListArr = data.order_shops;
    NSArray *goodsArray = goodsListArr[0][@"shop_goods"];
    NSDictionary *dict = goodsArray[indexPath.row];


   [cell config:dict];

    
    return cell;
}

////TableView的分割线处理
-(void)viewDidLayoutSubviews {
    
    if ([_tbView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tbView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tbView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tbView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark 订单头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /* OrderDataModel*data=  self.dataArray[section];
     NSArray *goodsListArr = data.order_shops;
     NSArray *goodsArray = goodsListArr[0][@"shop_goods"];

     */
    OrderDataModel*data=  self.dataArray[section];
    NSArray *goodsListArr = data.order_shops;
    NSDictionary *dic = goodsListArr[0];
   

    TradeHeadCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"TradeHeadCell" owner:self options:nil] lastObject];
    cell.shopNameLabel.text = dic[@"shop_name"];
    cell.orderStatus.text = [self orderStatusWithString:[NSString stringWithFormat:@"%d",data.status]];
    
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TradeFootCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"TradeFootCell" owner:self options:nil] lastObject];
    OrderDataModel*data=  self.dataArray[section];
    NSArray *goodsListArr = data.order_shops;
    NSArray *goodsArray = goodsListArr[0][@"shop_goods"];

    cell.goodsNumberLabel.text = [NSString stringWithFormat:@"共%lu件商品",(unsigned long)goodsArray.count];
    int all=0;
    for (NSDictionary *dic in goodsArray)
    {
        all = [dic[@"goods_price"] intValue]*[dic[@"goods_number"] intValue]+all;
    }
    cell.goodsPrice.text = [NSString stringWithFormat:@"合计:¥%d",all];
    
    cell.orderNumberLbl.text = data.order_id;
    return cell;

}
#pragma mark - 设置刷新头尾视图
- (void)setupTableViewRefresh
{
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self requestMinetradeRecordInfo];
    }];
    [_tbView.header beginRefreshing];
    
    
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        [self requestMinetradeRecordInfo];
    }];
}
- (NSString *)orderStatusWithString:(NSString *)type
{
    NSInteger index = [type integerValue];
    switch (index) {
        case 1:
            return @"待付款";
            break;
        case 2:
            return @"待发货";
            break;
        case 3:
            return @"待收货";
            break;
        case 4:
            return @"待评价";
            break;
        case 5:
            return @"取消订单";
            break;
        default:
            break;
    }
    
    return type;
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
