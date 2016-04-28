
#import "TradingManagerController.h"
#import "AllOrderCell.h"
#import "MyOrderCellHeader.h"
#import "MyOrderCellFooter.h"
#import "JGBtnView.h"
#import "ShippingController.h"
#import "OrderGoodsModel.h"
#import "BusinessOrderModel.h"
#import "ShopOrderGoodModel.h"
#import "BusinessOrderDetailController.h"
#import "SeeCommentController.h"



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
///**
// *  订单列表
// */
//@property (nonatomic ,strong)NSMutableArray *orderListArray;

@property (nonatomic,assign)int page;


@property (nonatomic,strong)NSMutableArray *orderArray;
@end

@implementation TradingManagerController
-(NSMutableArray *)orderArray
{
    if(!_orderArray)
    {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
//-(NSMutableArray *)orderListArray
//{
//    if(!_orderListArray)
//    {
//        _orderListArray = [NSMutableArray array];
//    }
//    return _orderListArray;
//
//}

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
    
    [self createTableView];
    [self createRefresh];
    [self getDatawithOrder];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.page=1;
//    [self getDatawithOrder];
    
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
        _page += 1;
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


#pragma mark - allOrderAction 所有订单
- (void)allOrderAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(5, 44, kViewWidth/6-10, 1)];
    _page =1;
    [self getDatawithOrder];
    
}

#pragma mark 未付款
- (void)noPayAction:(UIButton *)btn
{
    
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5+5, 44, kViewWidth/5-10, 1)];
    _page =1;
    [self getDatawithOrder];
}

#pragma mark - 待发货
- (void)noSendAction:(UIButton *)btn
{
    [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*2+5, 44, kViewWidth/5-10, 1)];
    _page =1;
    [self getDatawithOrder];
}

#pragma mark - 待收货
- (void)waitReceiveAction:(UIButton *)btn
{
    [self setBtnType:@"3" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*3+5, 44, kViewWidth/5-10,1)];
    _page =1;
    [self getDatawithOrder];
}

#pragma mark - 待评价
- (void)waitComAction:(UIButton *)btn
{
    [self setBtnType:@"4" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/5*4+5, 44, kViewWidth/5-10, 1)];
    _page =1;
    [self getDatawithOrder];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BusinessOrderModel *model = _orderArray[section];
    NSArray *array  = model.shop_goods;
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.orderArray.count>0)
    {
        return self.orderArray.count;
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
    BusinessOrderModel *orderModel =  _orderArray[indexPath.section];
    ShopOrderGoodModel *goodsModel = [[ShopOrderGoodModel alloc]initWithDict: orderModel.shop_goods[indexPath.row]];
    cell.goodsNumLabel.text =[NSString stringWithFormat:@"x%@", goodsModel.goods_number];
//    cell.goodsAttrbuteLabel.text = goodsModel.name_value_str;
    cell.goodsAttrbuteLabel.text = @"默认 型号：默认";
    cell.unitPriceLabel.text = goodsModel.goods_price;
    cell.goodsTitleLabel.text  =goodsModel.goods_name;
    cell.yajinLabel.text = [NSString stringWithFormat:@"%.2f",[goodsModel.goods_deposit floatValue]];
    if([goodsModel.is_refund isEqualToString:@"1"])
    {
        cell.refundBtn.hidden=NO;
        [cell.refundBtn setTitle:@"确认退款" forState:UIControlStateNormal];
        cell.refounFn = ^{
            [DeliveryUtility showMessage:@"确认退款" target:self];
        };
    }
    
    //商品的图片url没有
    [cell.goodsImage  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,goodsModel.img_path]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

//section 头部视图

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyOrderCellHeader * header = [[[NSBundle mainBundle]loadNibNamed:@"MyOrderCellHeader" owner:self options:nil]lastObject];
    BusinessOrderModel *model = self.orderArray[section];
    NSArray *goodsArr = model.shop_goods;
    ShopOrderGoodModel *goodsModel = [[ShopOrderGoodModel alloc]initWithDict:goodsArr[0]];
    header.shopNameLabel.text = goodsModel.nickname;
    header.orderStatusLabel.text = model.status_name;
    header.orderArrowImage.hidden=YES;
    CGRect rect = header.shopNameLabel.frame;
    header.shopIcon.hidden = YES;
    UILabel *nickLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(header.shopIcon.frame),
                                                                CGRectGetMinY(header.shopNameLabel.frame),
                                                                header.shopIcon.frame.size.width+20,
                                                                header.shopNameLabel.frame.size.height)];
    [header addSubview:nickLbl];
    nickLbl.text = @"昵称:";
    nickLbl.font = [UIFont systemFontOfSize:12];
    header.shopNameLabel.frame = CGRectMake(rect.origin.x, rect.origin.y, 150, rect.size.height);
    
    
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
    
    BusinessOrderModel *ordelModel = [self.orderArray objectAtIndex:section];
    
    NSMutableArray *goodsArray = [NSMutableArray array];
    for(NSDictionary *dict  in ordelModel.shop_goods)
    {
        ShopOrderGoodModel *goodsModel = [[ShopOrderGoodModel alloc]initWithDict:dict];
        [goodsArray addObject:goodsModel];
    }
    
    int allAmount =0;
    int allNumber = 0;
    //_orderListArray[section][@"shop_goods"][@"goods_deposit"] = @"100";
    for(ShopOrderGoodModel *model in goodsArray)
    {
        allAmount +=[model.goods_price intValue]*[model.goods_number intValue];
        allNumber +=[model.goods_number intValue];
    }
    
    //合计：￥380.00
    footer.goodsPriceTotalLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",(float)allAmount];
    footer.goodsTotalLabel.text = [NSString stringWithFormat:@"共%d件商品",allNumber];
    footer.leftBtn.tag  =100000+section;
    footer.rightBtn.tag = 200000+section;
    
    [self checkCellBtnStatue:footer orderStatus:ordelModel.order_status status:ordelModel.status section:section tableView:tableView];
    
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessOrderDetailController *detailController = [[BusinessOrderDetailController alloc]init];
    BusinessOrderModel *model=_orderArray[indexPath.section];
    detailController.goodsModel =model;
    detailController.order_id =model.order_id;
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark - 根据切换状态改变cell的btn点击事件
- (void)checkCellBtnStatue:(MyOrderCellFooter *)view
               orderStatus:(NSString *)orderStatus
                    status:(NSString *)status
                   section:(NSInteger )section tableView:(UITableView *)tableView
{
    switch ([status intValue]) {
        case 1: //待付款
        {
            [view.rightBtn setTitle:@"关闭订单" forState:UIControlStateNormal];
            [view.rightBtn addTarget:self action:@selector(actionCloseOrder:) forControlEvents:UIControlEventTouchUpInside];
            view.leftBtn.hidden = YES;
            
            
        }
            break;
            
        case 2://待发货
        {
            if([orderStatus intValue]==4)//买家取消订单
            {
                [view.leftBtn setTitle:@"不同意取消" forState:UIControlStateNormal];
                [view.leftBtn addTarget:self action:@selector(actionDisagreeCancelOrdel:) forControlEvents:UIControlEventTouchUpInside];
                [view.rightBtn setTitle:@"同意取消" forState:UIControlStateNormal];
                [view.rightBtn addTarget:self action:@selector(actionCloseOrder:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([orderStatus intValue]==6)//等待买家确认取消
            {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(view.leftBtn.frame), 80, 30)];
                label.font = [UIFont systemFontOfSize:13];
                [view addSubview:label];
                label.textColor = [UIColor redColor];
                label.text = @"等待用户取消";
                view.rightBtn.hidden=YES;
                view.leftBtn.hidden = YES;
            }
            else
            {
                [view.leftBtn setTitle:@"发货" forState:UIControlStateNormal];
                [view.leftBtn addTarget:self action:@selector(actionShipping:) forControlEvents:UIControlEventTouchUpInside];
                [view.rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [view.rightBtn addTarget:self action:@selector(actionBusinessCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
            }
  
            
        }
            break;

        case 3://待收货
        {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(view.leftBtn.frame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [view addSubview:label];
            label.textColor = [UIColor redColor];
            label.text = @"等待用户收货";
            view.rightBtn.hidden=YES;
            view.leftBtn.hidden = YES;

//            [view.rightBtn setTitle:@"提醒收货" forState:UIControlStateNormal];
//            [view.rightBtn addTarget:self action:@selector(actionRemindReceipt:) forControlEvents:UIControlEventTouchUpInside];
//            
//            view.leftBtn.hidden=YES;
        }
            break;
            
            
        case 4: //待评价
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(view.leftBtn.frame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [view addSubview:label];
            label.textColor = [UIColor redColor];
            label.text = @"等待用户评价";
            
            view.rightBtn.hidden=YES;
            view.leftBtn.hidden = YES;
            
            
        }
            break;
            
        case 5://待寄回   暂时没做
        {
            view.rightBtn.hidden=YES;
            view.leftBtn.hidden = YES;
            
            
        }
            break;
            
            
        case 6://已关闭
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(view.leftBtn.frame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [view addSubview:label];
            label.textColor = [UIColor redColor];
            label.text = @"该订单已关闭";
            
            view.rightBtn.hidden=YES;
            view.leftBtn.hidden = YES;
            
        }
            break;
            
            
            
        case 7://已评价
        {
            [view.rightBtn setTitle:@"查看评价" forState:UIControlStateNormal];
            [view.rightBtn addTarget:self action:@selector(actionSeeComment:) forControlEvents:UIControlEventTouchUpInside];
            view.leftBtn.hidden = YES;
        }
            break;
            
            
        case 8://申请退款   暂时没做
        {
            view.rightBtn.hidden=YES;
            view.leftBtn.hidden = YES;
            
            
        }
            break;
            
            
        case 9://已退款   暂时没做
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(view.leftBtn.frame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [view addSubview:label];
            
            label.text = @"该订单已退款";
            
            view.rightBtn.hidden=YES;
            view.leftBtn.hidden = YES;
            
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}
//-(void)action
/**
 *  关闭订单 或取消订单
 */
-(void)actionCloseOrder:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定同意取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确认");
        NSInteger number;
        if(btn.tag<20000)
        {
            number = btn.tag-100000;
        
        }
        else{
            number = btn.tag-200000;
        }
        BusinessOrderModel *model = _orderArray[number];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [param setValue:model.order_id forKey:@"order_id"];
        [param setValue:@"0" forKey:@"status"];
        HHNSLog(@"%@",param);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [HttpRequestServers requestBaseUrl:TIShopOrder_OrderStatus withParams:param withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"%@",result);
            if([dict[@"code"] intValue]==0)
            {
                [hud hide:YES afterDelay:0.5];
                
                
            }
            _page =1;
            [self getDatawithOrder];
            [_tbView reloadData];
            
        } withFieldBlock:^{
            
        }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];

     //  [self changeOrderStatus:order_id status:@"1"];
}
/**
 *  不同意取消订单操作
 *
 *  @param btn 按钮对象
 */
-(void)actionDisagreeCancelOrdel:(UIButton *)btn
{
    NSInteger number = btn.tag-100000;
    BusinessOrderModel *model = _orderArray[number];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:APP_DELEGATE.user_id forKey:@"user_id"];
    [param setValue:model.order_id forKey:@"order_id"];
    [param setValue:@"3" forKey:@"status"];
    HHNSLog(@"%@",param);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HttpRequestServers requestBaseUrl:TIShopOrder_OrderStatus withParams:param withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",result);
        if([dict[@"code"] intValue]==0)
        {
            [hud hide:YES afterDelay:0.5];
            
            
        }
        _page =1;
        [self getDatawithOrder];
        [_tbView reloadData];
        
    } withFieldBlock:^{
        
    }];
    
}
/**
 *  商家待发货取消操作
 *
 *  @param btn 按钮对象
 */
-(void)actionBusinessCancelOrder:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确认");
        NSInteger number = btn.tag-200000;
        BusinessOrderModel *model = _orderArray[number];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [param setValue:model.order_id forKey:@"order_id"];
        HHNSLog(@"%@",param);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [HttpRequestServers requestBaseUrl:TIShopOrder_confirmOrder withParams:param withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"%@",result);
            if([dict[@"code"] intValue]==0)
            {
                [hud hide:YES afterDelay:0.5];
                
                
            }
            _page = 1;
            [self getDatawithOrder];
            [_tbView reloadData];
            
        } withFieldBlock:^{
            
        }];
        

    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];

   
}
/**
 *  发货操作
 *
 *  @param btn 按钮对象  
 if ([self.deliveryMethod.text isEqualToString:@"送货上门"]) {
 deliveryId = @"0";
 }else if([self.deliveryMethod.text isEqualToString:@"快递"]){
 deliveryId = @"1";
 }else if([self.deliveryMethod.text isEqualToString:@"自提"]){
 deliveryId = @"2";
 }

 */
-(void)actionShipping:(UIButton *)btn
{
    NSInteger number = btn.tag-100000;
    BusinessOrderModel *model = _orderArray[number];
    NSString *isKuaidi;
    for(NSDictionary *dict in model.shop_goods)
    {
        ShopOrderGoodModel *goodsModel = [[ShopOrderGoodModel alloc]initWithDict:dict ];
        if([goodsModel.method isEqualToString:@"1"])
        {
            isKuaidi = @"Yes";
        }
    }
    if([isKuaidi isEqualToString:@"Yes"])
    {
        ShippingController *shippingController = [[ShippingController alloc]init];
        [self.navigationController pushViewController:shippingController animated:YES];
        shippingController.orderModel = model;
    }
    else
    {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud show:YES];
        NSMutableDictionary *prama = [NSMutableDictionary dictionary];
        [prama setValue:model.order_id forKey:@"order_id"];
        [prama setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [prama setValue:@"1" forKey:@"status"];
        [prama setValue:@"" forKey:@"express_number"];
        [prama setValue:@"" forKey:@"express_company"];
        HHNSLog(@"发货传的字典%@",prama);
        [HttpRequestServers requestBaseUrl:TIShopOrder_UpdateOrderStatus withParams:prama withRequestFinishBlock:^(id result) {
            HHNSLog(@"发货请求的数据%@",result);
            NSDictionary *dict = result;
            
            if([dict[@"code"] intValue]==0)
            {
                [hud hide:YES];
            }
            else
            {
                hud.labelText = @"发货失败";
                [hud hide:YES afterDelay:0.5];
            }
            _page =1;
            [self getDatawithOrder];
            
        } withFieldBlock:^{
            
        }];

    }
}
/**
 *  提醒收货操作
 *
 *  @param btn 按钮对象
 */
-(void)actionRemindReceipt:(UIButton *)btn
{
#warning 现在没有提醒发货这个借口，先转菊花
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    btn.hidden = YES;
}

/**
 *  查看评价
 *
 *  @param btn 按钮对象
 */
-(void)actionSeeComment:(UIButton *)btn
{
    NSInteger number = btn.tag-200000;
    BusinessOrderModel *model = _orderArray[number];
    
    SeeCommentController *seeController = [[SeeCommentController alloc]init];
    seeController.order_id = model.order_id;
    [self.navigationController pushViewController:seeController animated:YES];
    
    [self setHidesBottomBarWhenPushed:YES];
    
    
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
//            weakself.orderArray =[NSMutableArray array];
            if(weakself.page ==1 ||weakself.page==0)
            {
                weakself.orderArray = [NSMutableArray array];
            }

        }
        else
        {
            if(weakself.page ==1 ||weakself.page==0)
            {
                weakself.orderArray = [NSMutableArray array];
            }
            for(NSDictionary *orderDict in arr)
            {
                BusinessOrderModel *orderModel = [[BusinessOrderModel alloc]initWithDict:orderDict];
                [weakself.orderArray addObject:orderModel];
                
            }
            
            
        }
        
        [_tbView reloadData];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
    } withFieldBlock:^{
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [hud hide:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
