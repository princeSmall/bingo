
#import "TradingManagerController.h"
#import "AllOrderCell.h"
#import "MyOrderCellHeader.h"
#import "MyOrderCellFooter.h"
#import "JGBtnView.h"



@interface TradingManagerController ()<UITableViewDataSource,UITableViewDelegate>
{///选中的按钮
    UIButton *_selectedBtn;
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    ///判断是哪一个按钮  0 代表全部 1 代表待付款 2 代表待发货 3 代表待收货 4 代表待评价 5 代表退款
    NSString *_btnType;
}
/**
 *  请求订单管理列表所有内容
 */
@property (nonatomic ,strong)NSMutableDictionary *orderDic;
/**
 *  订单列表
 */
@property (nonatomic ,strong)NSMutableArray *orderListArray;

@property (nonatomic,assign)int page;

@end

@implementation TradingManagerController

-(NSMutableArray *)orderListArray
{
    if(!_orderListArray)
    {
        _orderListArray = [NSMutableArray array];
    }
    return _orderListArray;

}

-(NSMutableDictionary *)orderDic
{
    if(!_orderDic)
    {
        _orderDic = [NSMutableDictionary dictionary];
    }
    return _orderDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackColor;
    
    [self setNavTabBar:@"交易管理"];
    [self createUI];
#warning 下拉刷新
#warning 上拉刷新
  [self getDatawithOrder];
    [self createTableView];
    [self createRefresh];

    
}

//这边下拉  和上拉 刷新 有点问题  受page值的影响
- (void)createRefresh
{
    //添加下拉刷新
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self getDatawithOrder];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tbView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page = 1;
        [self getDatawithOrder];
        
    }];
    _tbView.footer.automaticallyChangeAlpha = YES;
    
    
}





- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, kViewWidth, kViewHeight-44-45) style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    UIView *view2 = [[UIView alloc] init];
    _tbView.tableHeaderView = view2;
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.00f)];
    //设置头部和尾部的高度
    _tbView.sectionHeaderHeight = 5;
    _tbView.sectionFooterHeight = 5;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tbView];
}

- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 45)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(5, 44, kViewWidth/5-10, 1)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/5, 45) ImageName:@"" Target:self Action:@selector(allOrderAction:) Title:@"全部" fontSize:14];
    
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
//    UIButton *btn6 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*5, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(BackMoneyComAction:) Title:@"退款" fontSize:14];
//    [btnView addSubview:btn6];
    
}




//- (void)createUI
//{
//    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 45)];
//    [self.view addSubview:btnView];
//    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(5, 44, kViewWidth/6-10, 1)];
//    _btnLine.backgroundColor = [UIColor redColor];
//    [btnView addSubview:_btnLine];
//    
//    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(allOrderAction:) Title:@"全部" fontSize:14];
//    
//    //初始化选中的按钮
//    _btnType = @"0";
//    _selectedBtn = btn1;
//    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    
//    [btnView addSubview:btn1];
//    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(noPayAction:) Title:@"待付款" fontSize:14];
//    [btnView addSubview:btn2];
//    UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*2, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(noSendAction:) Title:@"待发货" fontSize:14];
//    [btnView addSubview:btn3];
//    UIButton *btn4 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*3, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(waitReceiveAction:) Title:@"待收货" fontSize:14];
//    [btnView addSubview:btn4];
//    
//    UIButton *btn5 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*4, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(waitComAction:) Title:@"待评价" fontSize:14];
//    [btnView addSubview:btn5];
//    UIButton *btn6 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/6*5, 0, kViewWidth/6, 45) ImageName:@"" Target:self Action:@selector(BackMoneyComAction:) Title:@"退款" fontSize:14];
//    [btnView addSubview:btn6];
//    
//}
#warning
#warning status=6时会报错
#warning 

//我要退款
- (void)BackMoneyComAction:(UIButton *)btn{
    [self setBtnType:@"5" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/6*5+5, 44, kViewWidth/6-10, 1)];
    [self getDatawithOrder];
    
}
#pragma mark - allOrderAction 所有订单
- (void)allOrderAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(5, 44, kViewWidth/6-10, 1)];
    [self getDatawithOrder];
    
}

#pragma mark 未付款
- (void)noPayAction:(UIButton *)btn
{
    
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5+5, 44, kViewWidth/5-10, 1)];
    [self getDatawithOrder];
}

#pragma mark - 待发货
- (void)noSendAction:(UIButton *)btn
{
    [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*2+5, 44, kViewWidth/5-10, 1)];
    [self getDatawithOrder];
}

#pragma mark - 待收货
- (void)waitReceiveAction:(UIButton *)btn
{
    [self setBtnType:@"3" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*3+5, 44, kViewWidth/5-10,1)];
    [self getDatawithOrder];
}

#pragma mark - 待评价
- (void)waitComAction:(UIButton *)btn
{
    [self setBtnType:@"4" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*4+5, 44, kViewWidth/5-10, 1)];
    [self getDatawithOrder];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_orderListArray.count>0)
    {
        return _orderListArray.count;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"allOrderCell";
    AllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AllOrderCell" owner:nil options:nil]lastObject];
        
    }
    NSDictionary *dic =_orderListArray[indexPath.section][@"shop_goods"];
    cell.goodsNumLabel.text =[NSString stringWithFormat:@"x%@",   dic[@"goods_number"]];
    cell.goodsAttrbuteLabel.text = dic[@"name_value_str"];
    cell.unitPriceLabel.text = dic[@"goods_price"];
    cell.goodsTitleLabel.text  =dic[@"goods_name"];
    
    //商品的图片url没有
    [cell.goodsImage  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,dic[@"img_path"]]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

//section 头部视图

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyOrderCellHeader * header = [[[NSBundle mainBundle]loadNibNamed:@"MyOrderCellHeader" owner:self options:nil]lastObject];
    header.shopNameLabel.text = _orderListArray[section][@"shop_name"];
    header.orderStatusLabel.text = _orderListArray[section][@"shop_goods"][@"status_name"];
    
#warning 这边需要传出事件  点击进入店铺
#warning 这边需要传出事件  点击进入店铺
#warning 这边需要传出事件  点击进入店铺
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 86;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    MyOrderCellFooter * footer = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderCellFooter" owner:self options:nil] lastObject];
    footer.leftBtn.hidden = YES;
    footer.rightBtn.hidden = YES;
    NSString *status =  _orderListArray[section][@"shop_goods"][@"status_name"];
    //待付款
    NSArray * array1 = @[@"关闭订单",@"取消订单",@"修改订单",@"订单备注"];
    //待发货
    NSArray * array2 = @[@"发货",@"关闭订单",@"取消订单",@"订单备注"];
    //待收货
    NSArray * array3 = @[@"收货"];
    //待评价
    NSArray * array4 = @[@"订单评价"];
    //退款
    NSArray * array5 = @[@"退款处理"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:array1,@"待付款",array2,@"待发货",array3,@"待收货",array4,@"待评价",array5,@"退款", nil];
    NSArray *array = dic[status];
    
    NSDictionary *dict = _orderListArray[section];
    NSString* order_id = _orderListArray[section][@"shop_goods"][@"order_id"];
   
    //这边btn的tag值从678开始为第一个btn的index under
    JGBtnView * viewBtn = [[JGBtnView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 34) AndArray:array AndEndBlock:^(NSString *btnType) {
        NSLog(@"%@",dic[status][[btnType intValue]-678] );
        NSString * status1 =dic[status][[btnType intValue]-678];
        if([status1 isEqualToString:@"关闭订单"])
        {
            [self changeOrderStatus:order_id status:@"1"];
            
        }else if([status1 isEqualToString:@"取消订单"])
        {
            [self changeOrderStatus:order_id status:@"0"];
        }else if ([status1 isEqualToString:@"订单备注"])
        {
//            [self  orderRemark:order_id];
//               [PromptLabel custemAlertPromAddView:self.view text:@"二期开发中"];
             [DeliveryUtility showMessage:@"二期开发中" target:nil];
        }else if ([status1 isEqualToString:@"发货"])
        {
            [self changeOrderStatus:order_id status:@"2"];
        }
        if ([status1 isEqualToString:@"修改订单"]) {
//                    [PromptLabel custemAlertPromAddView:self.view text:@"二期开发中"];
             [DeliveryUtility showMessage:@"二期开发中" target:nil];
        }
        if ([status1 isEqualToString:@"订单评价"]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"二期开发中"];
             [DeliveryUtility showMessage:@"二期开发中" target:nil];
        }
        if ([status1 isEqualToString:@"收货"]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"请确定用户已经收货"];
             [DeliveryUtility showMessage:@"请确定用户已经收货" target:nil];
        }
        
        
    }] ;
    [footer addSubview:viewBtn];
    int allAmount=0;
    //运费
    int freight = 0;
//_orderListArray[section][@"shop_goods"][@"goods_deposit"] = @"100";
    allAmount =([_orderListArray[section][@"shop_goods"][@"goods_price"] intValue]+[@"100" intValue])*[_orderListArray[section][@"shop_goods"][@"goods_number"] intValue] ;
    
   
    //合计：￥380.00 （含运费￥10）
    footer.goodsPriceTotalLabel.text = [NSString stringWithFormat:@"合计：￥%.2f （含运费￥%.2f）",(float)allAmount,(float)freight];
    
    
    return footer;
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
    
    [_tbView reloadData];
}

#pragma mark    获得订单列表
-(void)getDatawithOrder
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
   
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_btnType ,@"status", nil];
    [userDic setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    //[userDic setObject:@"6" forKey:@"user_id"];
    userDic[@"page"] = [NSString stringWithFormat:@"%d",_page];
    __weak typeof(self) weakself = self;
    [HttpRequestServers requestBaseUrl:TIShopOrder_OrderList withParams:userDic withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        id arr = dict[@"data"];
        NSLog(@"%@",dict);
        _orderDic = [NSMutableDictionary dictionaryWithDictionary:dict];
        hud.labelText = @"加载成功";
        [hud hide:YES];
        if(![[arr class] isSubclassOfClass:[NSArray class]])
        {
            weakself.orderListArray = [NSMutableArray array];
        }
        else
        {
            weakself.orderListArray = arr;        }
        
        [_tbView reloadData];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
    } withFieldBlock:^{
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [hud hide:YES];
    }];
    
}
/**
 *  订单备注
 */
-(void)orderRemark:(NSString *)orderID
{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    [userDic setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [userDic setObject:orderID forKey:@"order_id"];
    [userDic setObject:@"" forKey:@"remark"];
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    [HttpRequestServers requestBaseUrl:TIShopOrder_OrderRemark withParams:userDic withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        if([dict[@"code"] intValue]==0)
        {
            hud.labelText = @"备注成功";
            [hud hide:YES];
        }
        else
        {
            hud.labelText = @"备注失败";
            [hud hide:YES];
        }
    } withFieldBlock:^{
        
    }];
}
/**
 *  修改订单状态
 */
-(void)changeOrderStatus:(NSString *)orderID
                  status:(NSString *)status
{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    [userDic setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [userDic setObject:orderID forKey:@"order_id"];
    [userDic setObject:status forKey:@"status"];
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
       [HttpRequestServers requestBaseUrl:TIShopOrder_OrderStatus withParams:userDic withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
           if([dict[@"code"] intValue]==0)
           {
               hud.labelText = @"修改成功";
               [hud hide:YES];
           }
           else
           {
               hud.labelText = @"修改失败";
               [hud hide:YES];
           }
           [self getDatawithOrder];
           //[_tbView reloadData];

    } withFieldBlock:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
