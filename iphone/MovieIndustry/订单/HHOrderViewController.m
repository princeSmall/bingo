//
//  HHOrderViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHOrderViewController.h"
#import "AllOrderCell.h"
#import "MovieCommentViewController.h"
#import "MovieOrderDetailViewController.h"
#import "MovieRefundMoneyViewController.h"
#import "SearchShopResultController.h"
#import "MovieShopCarViewController.h"
#import "MovieComfirmOrderViewController.h"
#import "MovieDeliveryDetailViewController.h"
#import "PaySuccessViewController.h"
#import "MyOrderCellFooter.h"
#import "MyOrderCellHeader.h"
#import "MyOrderGoodsModel.h"
//#import "MyOrderShopModel.h"
#import "LoginInController.h"
#import "OrderDataModel.h"
#import "OrderGoodsModel.h"
#import "OrderShopModel.h"

@interface HHOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ///选中的按钮
    UIButton *_selectedBtn;
    
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表全部 1 代表待付款按钮 2 代表待发货 3 代表待收货  4 代表待评价
    NSString *_btnType;
}
///点击订单状态 返回数据 订单状态(0待付款,1待发货,2待收货,3待评论,4.已经评论 5 取消订单,为9则为全部) 默认是9
@property (nonatomic,copy) NSString *orderType;
///订单分页
@property (nonatomic,assign) NSUInteger page;

///数据源数组 包含商品的数据
@property (nonatomic,strong) NSMutableArray *dataArray;

///店铺mingc的数组
@property (nonatomic,strong) NSMutableArray *shopArray;

@property (nonatomic,strong) NSMutableArray *orderArray;

@property (nonatomic,strong) NSMutableArray *goodsArray;
@end

@implementation HHOrderViewController
-(NSMutableArray *)shopArray
{
    if(!_shopArray)
    {
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}
-(NSMutableArray *)orderArray
{
    if(!_orderArray)
    {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
//-(NSMutableArray *)goodsArray
//{
//    if(!_goodsArray)
//    {
//        _goodsArray = [NSMutableArray array];
//    }
//    return _goodsArray;
//}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!APP_DELEGATE.user_id) {
        
    }else
    {
        self.page  = 1;
        [self loadData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackColor;
    if(self.Order){
    
        [self setNavTabBar1:@"交易管理"];
    }else{
    [self setNavTabBar:@"我的订单"];
    self.Order = @"DSA";
    }
    
    [self createUI];
    [self createTableView];
    _shopArray = [NSMutableArray array];
    ///初始化变量
    self.orderType = @"0";
    [self createRefresh];
    
    
    
}


- (void)setNavTabBar1:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}




#pragma mark - 添加刷新
- (void)createRefresh
{
    //添加下拉刷新
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self loadData];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tbView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadData];
        
    }];
    _tbView.footer.automaticallyChangeAlpha = YES;
    
    
}




#pragma mark - 初始化数据
- (void)loadData
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.orderType,@"status", nil];
    userDict[@"page"] = [NSString stringWithFormat:@"%lu",(unsigned long)_page];
    [HttpRequestServers requestBaseUrl:TIOrder_OrderList withParams:userDict withRequestFinishBlock:^(id result) {
        [HUD hide:YES];
        NSDictionary *dict = result;

        @try {
           
            [_tbView.header endRefreshing];
            [_tbView.footer endRefreshing];
            
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
                    [_tbView reloadData];

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
                    NSLog(@"%@",ordelModel.order_shops);
                    ordelModel.status = ordelDcit[@"status"];
                    
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
#warning 后台没有返回 我前台写死数据
#warning 后台没有返回 我前台写死数据
#warning 后台没有返回 我前台写死数据
                            goodsDetailModel.goods_deposit = @"100";
                            
                            goodsDetailModel.img_path =goodsDetailDic[@"img_path"];
                             [self.goodsArray addObject:goodsDetailModel];
                        
                            [self.shopArray addObject:self.goodsArray];
                            
                        }
                        
                        ///添加到数组里面
                    
                    }
                     ////商品数据添加到数据源数组
                    if (ordelDcit[@"order_shops"]) {
                        [self.dataArray addObject:ordelModel];
                    }
                    

                    
                }
                
                HUD.labelText = @"加载成功";
                [HUD hide:YES afterDelay:0.25];
                [_tbView reloadData];
                //结束刷新
                [_tbView.header endRefreshing];
                [_tbView.footer endRefreshing];
                //                HHNSLog(@"shopArray --> %@ goodsArray----->%@",self.shopArray,self.dataArray);
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
        HUD.labelText = kNetWork_ERROR;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
    }];
    
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, kViewWidth, kViewHeight-20-94-25) style:UITableViewStyleGrouped];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    UIView *view2 = [[UIView alloc] init];
    _tbView.tableHeaderView = view2;
    
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.00f)];
    
    //设置头部和尾部的高度
    //    _tbView.sectionHeaderHeight = 5;
    //    _tbView.sectionFooterHeight = 5;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tbView];
}

- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 45)];
    [self.view addSubview:btnView];
  
    if (self.Order) {
          _btnLine = [[UIView alloc] initWithFrame:CGRectMake(5, 43, kViewWidth/5-10, 2)];
        _btnLine.backgroundColor = [UIColor redColor];
        [btnView addSubview:_btnLine];
        
        UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/5, 45) ImageName:@"" Target:self Action:@selector(allOrderAction:) Title:@"全部" fontSize:15];
        
        //初始化选中的按钮
        _btnType = @"0";
        _selectedBtn = btn1;
        [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        
        
        [btnView addSubview:btn1];
        UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/5, 0, kViewWidth/5, 45) ImageName:@"" Target:self Action:@selector(noPayAction:) Title:@"待付款" fontSize:14];
        [btnView addSubview:btn2];
        UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/5*2, 0, kViewWidth/5, 45) ImageName:@"" Target:self Action:@selector(noSendAction:) Title:@"待发货" fontSize:14];
        [btnView addSubview:btn3];
        UIButton *btn4 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/5*3, 0, kViewWidth/5, 45) ImageName:@"" Target:self Action:@selector(waitReceiveAction:) Title:@"待收货" fontSize:14];
        [btnView addSubview:btn4];
        
        UIButton *btn5 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/5*4, 0, kViewWidth/5, 45) ImageName:@"" Target:self Action:@selector(waitComAction:) Title:@"待评价" fontSize:14];
        [btnView addSubview:btn5];

        
        
    }else{
      _btnLine = [[UIView alloc] initWithFrame:CGRectMake(5, 43, kViewWidth/6-10, 2)];
        _btnLine.backgroundColor = [UIColor redColor];
        [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(allOrderAction:) Title:@"全部" fontSize:15];
    
    //初始化选中的按钮
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(noPayAction:) Title:@"待付款" fontSize:14];
    [btnView addSubview:btn2];
    UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*2, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(noSendAction:) Title:@"待发货" fontSize:14];
    [btnView addSubview:btn3];
    UIButton *btn4 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*3, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(waitReceiveAction:) Title:@"待收货" fontSize:14];
    [btnView addSubview:btn4];
    
    UIButton *btn5 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*4, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(waitComAction:) Title:@"待评价" fontSize:14];
    [btnView addSubview:btn5];
    
    
    
    UIButton *btn6 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*5, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(BackComAction:) Title:@"退款" fontSize:14];
    [btnView addSubview:btn6];
    }
}

#pragma mark - allOrderAction 所有订单
- (void)allOrderAction:(UIButton *)btn
{
    
    if (self.Order) {
           [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(5, 43, kViewWidth/5-10, 2)];
    }
    
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(5, 43, kViewWidth/6-10, 2)];
    self.orderType = @"9";
    self.page = 1;
    [self loadData];
}

#pragma mark 未付款
- (void)noPayAction:(UIButton *)btn
{
    if (self.Order) {
        [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5+5, 43, kViewWidth/5-10, 2)];
    }else{
    
        [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/6+5, 43, kViewWidth/6-10, 2)];}
    self.orderType = @"1";
    self.page = 1;
    [self loadData];
}

#pragma mark - 待发货
- (void)noSendAction:(UIButton *)btn
{
    
    if (self.Order) {
        [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*2+5, 43, kViewWidth/5-10, 2)];
    }else{
        [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/6*2+5, 43, kViewWidth/6-10, 2)];}
    self.orderType = @"2";
    self.page = 1;
    [self loadData];
}

#pragma mark - 待收货
- (void)waitReceiveAction:(UIButton *)btn
{
    
    if (self.Order) {
        [self setBtnType:@"3" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*3+5, 43, kViewWidth/5-10, 2)];
    }else{
        [self setBtnType:@"3" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/6*3+5, 43, kViewWidth/6-10,2)];}
    self.orderType = @"3";
    self.page  =1;
    [self loadData];
}

#pragma mark - 待评价
- (void)waitComAction:(UIButton *)btn
{
    
    if (self.Order) {
        [self setBtnType:@"4" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*4+5, 43, kViewWidth/5-10, 2)];
    }else{
        [self setBtnType:@"4" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/6*4+5, 43, kViewWidth/6-10, 2)];}
    self.orderType = @"4";
    self.page  =1;
    [self loadData];
}

//退款按钮  事件的处理

- (void)BackComAction:(UIButton *)btn{
    
    [self setBtnType:@"4" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/6*5+5, 43, kViewWidth/6-10, 2)];
    self.orderType = @"5";
    self.page  =1;
    [self loadData];
}

#pragma mark - TableView
////返回每组中的cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderDataModel *order = self.dataArray[section];
    NSArray *array = order.order_shops;
    NSArray *goodsArray =[NSArray arrayWithArray:array[0][@"shop_goods"]];
    NSInteger num = goodsArray.count;
    return num;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"allOrderCell";
    OrderDataModel *ordersArr = self.dataArray[indexPath.section];
    
     NSArray *array = ordersArr.order_shops;
     NSArray *goodsArray =[NSArray arrayWithArray:array[0][@"shop_goods"]];
    
    NSDictionary *goodsModel1= goodsArray[indexPath.row];
    
    NSMutableDictionary * goodsModel = [NSMutableDictionary dictionaryWithDictionary:goodsModel1];
      goodsModel[@"goods_deposit"] = @"100.00";
    AllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AllOrderCell" owner:nil options:nil]lastObject];
        
    }
    ///如果第一行和最后一行不显示分割线
    if (indexPath.row+1==goodsArray.count) {
        
    }else
    {
        UIView *lineView = [WNController createViewFrame:CGRectMake(0, 100, kViewWidth, 2)];
        [cell.contentView addSubview:lineView];
    }
    
    [cell config:goodsModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 设置tableView的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark --tableView的尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 86;
}
#pragma mark 订单的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /*///商品订单状态
     
     ///进入店铺按钮 (0待付款,1待发货,2待收货,3待评论,
     @property (weak, nonatomic) IBOutlet UIButton *enterShopButton;*/
    MyOrderCellHeader *tbheaderView = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderCellHeader" owner:self options:nil]lastObject];

    if (self.dataArray.count>0) {
        OrderDataModel *order = self.dataArray[section];
        NSArray *array= order.order_shops;
        ///设置订单按钮
        tbheaderView.orderStatusLabel.text = [self orderStatusWithString:order.status];
        tbheaderView.shopNameLabel.text = array[0][@"shop_name"];
        
        tbheaderView.enterShopButton.tag = 100+section;
        [tbheaderView.enterShopButton addTarget:self action:@selector(enterShopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return tbheaderView;
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
            return @"交易成功";
            break;
        case 6:
            return @"交易关闭";
            break;
        default:
            break;
    }
    
    return type;
}

#pragma mark - 点击进入店铺
- (void)enterShopButtonAction:(UIButton *)btn
{
    OrderDataModel *model = self.dataArray[btn.tag -100];
    
    SearchShopResultController *shopVc = [[SearchShopResultController alloc] init];
    shopVc.shopId = model.order_shops[0][@"shop_goods"][0][@"shop_id"];
    
    [shopVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark - 返回tableView尾部的View
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MyOrderCellFooter *tbFooterView = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderCellFooter" owner:self options:nil] lastObject];
    OrderDataModel *order = self.dataArray[section];
    NSArray *array =  order.order_shops;
    NSArray *arrGoods = array[0][@"shop_goods"];
    if (arrGoods.count>0) {
        int number =0;
        int amount = 0;
        for(NSDictionary *goodsDict in arrGoods)
        {
#warning 写死的数据
            number += [goodsDict[@"goods_number"] intValue];
            amount += [goodsDict[@"goods_number"] intValue] *([goodsDict[@"goods_price"] intValue] + 100);
        }
        
         ///设置订单按钮
//         tbheaderView.orderStatusLabel.text = [self orderStatusWithString:order.order_status];
//         tbheaderView.shopNameLabel.text = array[0][@"shop_name"];
        

        tbFooterView.goodsPriceTotalLabel.text = [NSString stringWithFormat:@"合计：￥%.2f （含运费￥0.00）",(float)amount];
        tbFooterView.goodsTotalLabel.text = [NSString stringWithFormat:@"共%d件商品",number];
        tbFooterView.leftBtn.tag = 10000+section;
        tbFooterView.rightBtn.tag = 20000+section;
//        [tbFooterView.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //tbFooterView.goodsPriceTotalLabel.text = [NSString stringWithFormat:@"%@",];
        [self checkCellBtnStatue:tbFooterView orderStatus:order.status];
        
    }
    
    return tbFooterView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieOrderDetailViewController *comfirmOrderVC = [[MovieOrderDetailViewController alloc] init];
    [comfirmOrderVC setHidesBottomBarWhenPushed:YES];
    
    OrderDataModel *dataModel = self.dataArray[indexPath.section];
    //NSArray *arr = dataModel.order_shops;
    ///传递商品信息过去
    comfirmOrderVC.order_id = dataModel.order_id;
    //comfirmOrderVC.orderNum = model.order_id;
    
    comfirmOrderVC.order_status = dataModel.status;
    [self.navigationController pushViewController:comfirmOrderVC animated:YES];
}


#pragma mark - 根据切换状态改变cell的btn点击事件
- (void)checkCellBtnStatue:(MyOrderCellFooter *)view orderStatus:(NSString *)orderStatus
{
    
    //0 待付款 1 待发货 2 已发货 3 待评价  4 已取消
//    _btnType 0:全部 1:待付款 2:待发货 3:待收货 4:待评价
        
    switch ([orderStatus integerValue]) {
        case 1:
        {
            [view.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [view.leftBtn addTarget:self action:@selector(cancelMineOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UIColor *btnColor = RGBColor(251, 0, 6, 1);
            [view.rightBtn setTitle:@"付款" forState:UIControlStateNormal];
//            [view.rightBtn setTitleColor:btnColor forState:UIControlStateNormal];
            view.rightBtn.layer.borderColor = btnColor.CGColor;
            [view.rightBtn addTarget:self action:@selector(payForMineOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 2:
        {
            view.leftBtn.hidden = YES;
            
            [view.rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [view.rightBtn addTarget:self action:@selector(warnSenderMineOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 3:
        {
            [view.leftBtn setTitle:@"延迟收货" forState:UIControlStateNormal];
            [view.leftBtn addTarget:self action:@selector(checkoutOrderDelivery:) forControlEvents:UIControlEventTouchUpInside];
            
            UIColor *btnColor = RGBColor(251, 0, 6, 1);
            [view.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
//            [view.rightBtn setTitleColor:btnColor forState:UIControlStateNormal];
            view.rightBtn.layer.borderColor = btnColor.CGColor;
         
            [view.rightBtn addTarget:self action:@selector(comfirmReceiveMineGood:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case 4:
        {
            view.leftBtn.hidden = YES;
            
            UIColor *btnColor = RGBColor(251, 0, 6, 1);
            [view.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
//            [view.rightBtn setTitleColor:btnColor forState:UIControlStateNormal];
            view.rightBtn.layer.borderColor = btnColor.CGColor;
            [view.rightBtn addTarget:self action:@selector(gotoCommentView:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 5:
        {
            [view.leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [view.leftBtn addTarget:self action:@selector(checkoutOrderDelivery:) forControlEvents:UIControlEventTouchUpInside];
            
            UIColor *btnColor = RGBColor(251, 0, 6, 1);
            [view.rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
//            [view.rightBtn setTitleColor:btnColor forState:UIControlStateNormal];
            view.rightBtn.layer.borderColor = btnColor.CGColor;
            [view.rightBtn addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case 6:
        {
            view.leftBtn.hidden = YES;
            
            UIColor *btnColor = RGBColor(251, 0, 6, 1);
            [view.rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
//            [view.rightBtn setTitleColor:btnColor forState:UIControlStateNormal];
            view.rightBtn.layer.borderColor = btnColor.CGColor;
            [view.rightBtn addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 删除订单
- (void)deleteOrder:(UIButton *)button
{
    HHNSLog(@"删除订单 %ld",button.tag);
    
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    
    MyOrderShopModel *shopModel = self.shopArray[button.tag - 20000];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:shopModel.order_id,@"order_id", nil];
    [HttpRequestServers requestBaseUrl:Delete_Order_Url withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"----->dict %@",dict);
        @try {
            if ([dict[@"status"] isEqualToString:Status_Success]) {
                
                hud.labelText = @"删除完成";
                [MBHudManager removeHud:hud scallBack:^(id obj) {
                    
                    
                }];
                self.page  =1;
                [self loadData];
                
            }else
            {
                
                hud.labelText = @"删除失败";
                [MBHudManager removeHud:hud scallBack:^(id obj) {
                    
                    
                }];
            }
        }
        @catch (NSException *exception) {
            [MBHudManager removeHud:hud scallBack:^(id obj) {
                
                
            }];
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
            
        }];
    }];
    
    
}

#pragma mark - 进入评价页面
- (void)gotoCommentView:(UIButton *)sender
{
    
//    [PromptLabel custemAlertPromAddView:self.view text:@"二期开发中"];
     [DeliveryUtility showMessage:@"二期开发中" target:nil];
    
//    MyOrderShopModel *shopsModel = self.shopArray[sender.tag - 20000];
//    NSArray *array = self.dataArray[sender.tag - 20000];
//    MovieCommentViewController *commentVC = [[MovieCommentViewController alloc] init];
//    commentVC.shopModel = shopsModel;
//    commentVC.goodsModelArray = array;
//    [commentVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:commentVC animated:YES];
}


#pragma mark - 进入申请退款页面
- (void)applyRefundAction:(UIButton *)button
{
    MovieRefundMoneyViewController *refundVC = [[MovieRefundMoneyViewController alloc] init];
    [refundVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:refundVC animated:YES];
}


#pragma mark - 取消订单
- (void)cancelMineOrderAction:(UIButton *)button
{
    NSLog(@"取消订单被点击 %ld",button.tag);
    
    @try {
        
        MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
        hud.labelText = @"正在取消";
        OrderDataModel *model = self.dataArray[button.tag - 10000];
        
        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:model.order_id,@"order_id",APP_DELEGATE.user_id,@"user_id",@"0",@"status", nil];
        
        [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:userDict withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"dict = %@",dict);
            
            @try {
                if ([dict[@"code"] intValue]==0) {
                    
                    hud.labelText = @"取消成功";
                    [MBHudManager removeHud:hud scallBack:^(id obj) {
                        
                        self.page  =1;
                        [self loadData];
                    }];
                    
                }else
                {
                    hud.labelText = dict[@"msg"];
                    [MBHudManager removeHud:hud scallBack:^(id obj) {
                        
                    }];
                }
                
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        } withFieldBlock:^{
            hud.labelText = kNetWork_ERROR;
            [MBHudManager removeHud:hud scallBack:^(id obj) {
                
            }];
        }];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma mark - 付款按钮被点击
- (void)payForMineOrder:(UIButton *)button
{
    NSLog(@"付款按钮被点击");



    int a = (int)button.tag -20000;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"pay_status"] = @"1";
    dict[@"pay_id"] = @"1";
    OrderDataModel * dataModel = self.dataArray[a];
    dict[@"order_id"] = dataModel.order_id;
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    hud.labelText = @"正在付款";
    
    
        [HttpRequestServers sendAlipayWithOrderSn:dataModel.order_id orderName:@"咖么支付测试" orderDescription:@"1分钱测试" orderPrice:[NSString stringWithFormat:@"%f",0.01] andScallback:^(id obj)
         {
    
             NSDictionary *aliDict = obj;
             HHNSLog(@"支付回调参数 aliDict %@",aliDict);
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             if ([aliDict[@"resultStatus"] isEqualToString:@"9000"])
             {
                 
                 
                 [HttpRequestServers requestBaseUrl:TIPay_CallBack withParams:dict withRequestFinishBlock:^(id result) {
                     
                     if ([result[@"code"] intValue] == 0) {
                         hud.labelText = @"付款成功！";
                         [hud hide:YES afterDelay:0.25];
                         PaySuccessViewController *paySucVc = [[PaySuccessViewController alloc] init];
                         paySucVc.order_SN = dataModel.order_id;
                         paySucVc.order_id = dataModel.order_id;
                         [self.navigationController pushViewController:paySucVc animated:YES];
                         
                     }else{
                         hud.labelText = @"付款失败！";
                         [hud hide:YES];
                     }
                 } withFieldBlock:^{
                     hud.labelText = @"付款失败！";
                     [hud hide:YES];
                 }];
             }
    
             if ([aliDict[@"resultStatus"] isEqualToString:@"8000"]) {
    
                 [DeliveryUtility showMessage:@"正在处理中" target:nil];
             }
             if ([aliDict[@"resultStatus"] isEqualToString:@"4000"]) {
                 [DeliveryUtility showMessage:@"订单支付失败" target:nil];
             }
             if ([aliDict[@"resultStatus"] isEqualToString:@"6001"]) {
                 [DeliveryUtility showMessage:@"用户中途取消付款" target:nil];
    
             }
             if ([aliDict[@"resultStatus"] isEqualToString:@"6002"]) {
    
                 [DeliveryUtility showMessage:@"网络连接出错" target:nil];
             }
         }];
}

#pragma mark - 取消订单
- (void)warnSenderMineOrder:(UIButton *)button
{
//          [PromptLabel custemAlertPromAddView:self.view text:@"请联系商家"];
    
     [DeliveryUtility showMessage:@"请联系商家" target:nil];
//    int a = (int)button.tag -20000;
//    
//
//    
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[@"user_id"] = APP_DELEGATE.user_id;
//    dict[@"status"] = @"0";
//    dict[@"pay_id"] = @"1";
//    OrderDataModel * dataModel = self.dataArray[a];
//    dict[@"order_id"] = dataModel.order_id;
//
//    [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:dict withRequestFinishBlock:^(id result) {
//        NSDictionary *dict = result;
//        HHNSLog(@"%@",dict);
//        @try {
//            if ([dict[@"code"] intValue] == 0) {
//                
//                _page = 1;
//                [self loadData];
//                
//            }
//        }
//        @catch (NSException *exception) {
//            
//        }
//        @finally {
//            
//        }
//        
//        
//    } withFieldBlock:^{
//        
//    }];
}

#pragma mark -- 查看物流
- (void)checkoutOrderDelivery:(UIButton *)button
{
//    [PromptLabel custemAlertPromAddView:self.view text:@"后期开发中"];
     [DeliveryUtility showMessage:@"后期开发中" target:nil];
    
//    NSInteger index = button.tag - 10000;
//    
//    MyOrderShopModel *model = self.shopArray[index];
//    
//    MovieDeliveryDetailViewController *deliveryVC = [[MovieDeliveryDetailViewController alloc] init];
//    deliveryVC.orderId = model.order_id;
//    [deliveryVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:deliveryVC animated:YES];
}

#pragma mark -- 确认收货
- (void)comfirmReceiveMineGood:(UIButton *)button
{
    int a = (int)button.tag -20000;
    
    
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"status"] = @"1";
    dict[@"pay_id"] = @"1";
    OrderDataModel * dataModel = self.dataArray[a];
    dict[@"order_id"] = dataModel.order_id;
    
    [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:dict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        @try {
            if ([dict[@"code"] intValue] == 0) {
                
                _page = 1;
                [self loadData];
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
}

- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
}

/// 点击按钮执行的动画和参数的变化
- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
{
    _btnType = btnType;
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = selectedBtn;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = btnLineFrame;
    }];
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
