//
//  BusinessOrderDetailController.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/11.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "BusinessOrderDetailController.h"
#import "MovieDeliveryDetailViewController.h"
#import "MovieShopCarViewController.h"
#import "OrderDetailTableCell.h"
#import "OrderDetailTableFooter.h"
#import "OrderDetailTableHeader.h"
#import "MyOrderShopModel.h"
#import "MyOrderCellHeader.h"
#import "MovieCommentViewController.h"
#import "PaySuccessViewController.h"
#import "OrderGoodsModel.h"
#import "OrderShopModel.h"
#import "PayOrderController.h"
#import "MovieCommentListViewController.h"
#import "ShippingController.h"
#import "SysTool.h"
#import "ShopOrderGoodModel.h"
#import "SeeCommentController.h"
#define BTN_TAG_START 300

@interface BusinessOrderDetailController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,retain)UITableView *mainTableView;
///tableView头部视图
@property (nonatomic,strong) OrderDetailTableHeader *tbHeaderView;
////tableView尾部视图
@property (nonatomic,strong) OrderDetailTableFooter *tbFooterView;
///商铺数组
@property (nonatomic,strong) NSMutableArray *shopsArray;
///商品数组
@property (nonatomic,strong) NSMutableArray *goodsArray;
///保存接口参数数据
@property (nonatomic,copy) NSString *dataString;

@property (nonatomic,copy) NSString *totalPrice;
///订单ID

//支付的字典
@property (nonatomic,strong)NSDictionary * orderPayDic;
//地址数组
@property (nonatomic,strong)NSMutableArray * addressArray;

@property (nonatomic,strong)OrderShopModel * shopModel;
//价格
@property (nonatomic,strong)NSString * sendPrice;
/**
 *  收货人的电话
 */
@property (nonatomic,strong)NSString *contact_phone;

@property (nonatomic,strong)NSString *status;


@end

@implementation BusinessOrderDetailController

- (NSMutableArray *)shopsArray
{
    if (!_shopsArray) {
        _shopsArray = [NSMutableArray array];
    }
    
    return _shopsArray;
}

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}
//-(OrderDataModel *)goodsModel
//{
//    if(!_goodsModel)
//    {
//        _goodsModel = [[OrderDataModel alloc]init];
//    }
//    return _goodsModel;
//}
- (OrderDetailTableHeader *)tbHeaderView
{
    if (!_tbHeaderView) {
        _tbHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailTableHeader" owner:self options:nil] lastObject];
    }
    return _tbHeaderView;
}

- (OrderDetailTableFooter *)tbFooterView
{
    if (!_tbFooterView) {
        _tbFooterView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailTableFooter" owner:self options:nil] lastObject];
        [_tbFooterView.callNumBtn setTitle:@"联系买家" forState:UIControlStateNormal];
    }
    return _tbFooterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"订单详情"];
    self.dataString = @"";
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadData];
    
}

#pragma mark - 初始化数据
- (void)loadData
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.order_id,@"order_id",APP_DELEGATE.user_id,@"user_id", nil];
    
    [HttpRequestServers requestBaseUrl:TIShopOrder_OrderDetail withParams:userDict withRequestFinishBlock:^(id result) {
        
        NSDictionary *dict = result;
        HHNSLog(@"----->%@,%@,%@",TIOrder_OrderDetail,userDict,dict);
        if ([dict[@"code"] intValue]==0) {
            ///开始要把数据清空
            [self.shopsArray removeAllObjects];
            [self.goodsArray removeAllObjects];
            
            //NSArray *listArray = dict[@"data"];
            NSDictionary *shopDcit  = dict[@"data"];
            MyOrderShopModel *shopModel = [[MyOrderShopModel alloc] initWithDict:shopDcit];
            self.status = shopModel.status;
            [self.shopsArray addObject:shopModel];
            
            self.contact_phone = shopModel.contact_phone;
            NSString * addressLStr = [NSString stringWithFormat:@"收货地址：%@%@%@%@",shopModel.province_name,shopModel.city_name,shopModel.district_name,shopModel.address];
            
            self.tbHeaderView.addressLabel.text = [WNController nullString:addressLStr];
            self.tbHeaderView.phoneLabel.text = [WNController nullString:shopModel.contact_phone];
            self.tbHeaderView.shouhuorenLabel.text =[WNController nullString:shopModel.consignee_name];
            self.tbFooterView.price.text = [NSString stringWithFormat:@"￥%@",[WNController nullString:shopModel.order_amount]];
            self.sendPrice = shopModel.order_amount;
            NSString * typePoss = @"";
#warning 这边需要判断送货类型
            if ([shopModel.method isEqualToString:@"0"]) {
                typePoss = @"送货上门";
            }
            if ([shopModel.method isEqualToString:@"1"]) {
                typePoss = @"快递";
            }
            if ([shopModel.method isEqualToString:@"2"]) {
                typePoss = @"自提";
            }
            
            self.tbFooterView.postCompanyName.text = typePoss;
            [self.tbFooterView.contactBtn addTarget:self action:@selector(contactBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
#warning 这边隐藏联系商家的按钮
            self.tbFooterView.contactBtn.hidden = YES;
            
            [self.tbFooterView.callNumBtn addTarget:self action:@selector(callNumBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            for (NSDictionary * shDict in shopModel.order_goods) {
                
                OrderShopModel * shModel = [[OrderShopModel alloc]initWithDict:shDict];
                self.shopModel = shModel;

                
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ///遍历商品数组 ///添加可变数组
            [self createOrderDetailView];
        }
    } withFieldBlock:^{
        hud.labelText = kNetWork_ERROR;
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
            
        }];
    }];
    
}


- (void)createOrderDetailView
{
    //创建列表
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-94) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    self.mainTableView.backgroundColor = kViewBackColor;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    self.mainTableView.tableHeaderView = self.tbHeaderView;
    self.mainTableView.tableFooterView = self.tbFooterView;
    ///显示状态
    self.tbHeaderView.orderStatusLabel.text = self.goodsModel.status_name;
    [self createViewBottomView];
}
- (void)createViewBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight-44-50,kViewWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = 80.0f;
    CGRect rightBtnFrame = CGRectMake(kViewWidth-90, 10,btnWidth, 30.0f);
    CGRect leftBtnFrame = CGRectMake(kViewWidth-100-btnWidth,10,btnWidth, 30.0f);
    
    //点击订单状态 返回数据 订单状态(0待付款,1待发货,2待收货,3待评论,为9则为全部) 默认是9
    switch ([self.goodsModel.status integerValue]) {
        case 1:  //待付款
        {
            //取消订单
            UIButton *cancelBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"关闭订单"];
            [cancelBtn addTarget:self action:@selector(warnPostMineOrderBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancelBtn];
            
        }
            break;
        case 2:  //待发货
        {
            
            if([self.goodsModel.order_status intValue]==4)//买家取消订单
            {
                UIButton *disagreeBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"不同意取消"];
                [disagreeBtn addTarget:self action:@selector(actionDisagree:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:disagreeBtn];
                
                UIButton *cancel = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"同意取消"];
                [cancel addTarget:self action:@selector(warnPostMineOrderBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:cancel];

                
            }else if([self.goodsModel.order_status intValue]==6)//等待买家确认取消
            {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
                label.font = [UIFont systemFontOfSize:13];
                [bottomView addSubview:label];
                label.textColor = [UIColor redColor];
                label.text = @"等待用户取消";
            
            }
            else
            {
                UIButton *shipping = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"发货"];
                [shipping addTarget:self action:@selector(actionShipping:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:shipping];
                UIButton *cancel = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"取消订单"];
                [cancel addTarget:self action:@selector(actionBusinessCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:cancel];

                
            }
            
                   }
            break;
        case 3: //待收货
        {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [bottomView addSubview:label];
            label.textColor = [UIColor redColor];
            label.text = @"等待用户收货";
            
            [bottomView addSubview:label];

//            UIButton *checkDeliveyBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"提醒收货"];
//            [checkDeliveyBtn addTarget:self action:@selector(actionRemindReceipt:) forControlEvents:UIControlEventTouchUpInside];
//            [bottomView addSubview:checkDeliveyBtn];
//            
            
            
        }
            break;
        case 4: //待评论
        {
            //评价
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [bottomView addSubview:label];
            label.textColor = [UIColor redColor];
            label.text = @"等待用户评价";
            
            [bottomView addSubview:label];
            
        }
            break;
        case 5: //待寄回   暂时没做
        {
            
            
        }
            break;
        case 6://已关闭
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [bottomView addSubview:label];
            
            label.text = @"该订单已关闭";
            
            label.textColor = [UIColor redColor];
        }
            break;
        case 7://已评价
        {
            UIButton *cancel = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"查看评价"];
            [cancel addTarget:self action:@selector(actionSeeComment:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancel];
            
        }
            break;
            
        case 8://申请退款   暂时没做
        {
            
        }
            break;
        case 9://已退款   暂时没做
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [bottomView addSubview:label];
            
            label.text = @"该订单已退款";
            
        }
            break;
            
        default:
            break;
    }
    
    [self.view addSubview:bottomView];
}

- (UIButton *)orderDetailButtonWithFrame:(CGRect)btnFrame andTitle:(NSString *)btnTitle
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = btnFrame;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:RGBColor(38, 38, 38, 1) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = RGBColor(212,212,212, 1).CGColor;
    
    return btn;
}

- (void)goBackLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 取消订单 关闭订单
- (void)warnPostMineOrderBtnClicked1:(UIButton *)button
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        HHNSLog(@"取消");
        
    }];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HHNSLog(@"确认");
        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",
                                         self.order_id,@"order_id",
                                         @"0",@"status", nil];
        [HttpRequestServers requestBaseUrl:TIShopOrder_OrderStatus withParams:userDict withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"%@",dict);
            @try {
                if ([dict[@"code"] intValue] == 0) {
                    
                    [PromptLabel custemAlertPromAddView:self.view text:@"取消订单成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        } withFieldBlock:^{
            
        }];

    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];

  }
/**
 *  不同意取消
 *
 *  @param btn 按钮对象
 */
-(void)actionDisagree:(UIButton *)btn
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",
                                     self.order_id,@"order_id",
                                     @"3",@"status", nil];
    [HttpRequestServers requestBaseUrl:TIShopOrder_OrderStatus withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        @try {
            if ([dict[@"code"] intValue] == 0) {
                
                [PromptLabel custemAlertPromAddView:self.view text:@"操作订单成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
}
/**
 *  商家待发货列表取消订单
 *
 *  @param button 按钮对象
 */
-(void)actionBusinessCancelOrder:(UIButton *)button
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"确认");
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:APP_DELEGATE.user_id forKey:@"user_id"];
        [param setValue:self.order_id forKey:@"order_id"];
        HHNSLog(@"%@",param);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [HttpRequestServers requestBaseUrl:TIShopOrder_confirmOrder withParams:param withRequestFinishBlock:^(id result) {
            NSDictionary *dict = result;
            HHNSLog(@"%@",result);
            if([dict[@"code"] intValue]==0)
            {
                [hud hide:YES afterDelay:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } withFieldBlock:^{
            
        }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 *  发货按钮
 *
 *  @param btn 按钮对象
 */
-(void)actionShipping:(UIButton *)btn
{
    NSArray *goodsArray =   self.goodsModel.shop_goods;
    NSString *isKuaidi ;
    for(NSDictionary *dict in goodsArray)
    {
        ShopOrderGoodModel *model = [[ShopOrderGoodModel alloc]initWithDict:dict];
        if([model.method isEqualToString:@"1"])
        {
            isKuaidi = @"Yes";
        }
    }
    if([isKuaidi isEqualToString:@"Yes"])
    {
        ShippingController *shippingController = [[ShippingController alloc]init];
        [self.navigationController pushViewController:shippingController animated:YES];
        shippingController.isDetail = @"Yes";
        shippingController.orderModel = self.goodsModel;
    }
    else
    {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud show:YES];
        NSMutableDictionary *prama = [NSMutableDictionary dictionary];
        [prama setValue:self.goodsModel.order_id forKey:@"order_id"];
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
            [self.navigationController popViewControllerAnimated:YES];
            
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
 *  @param button 按钮对象
 */
-(void)actionSeeComment:(UIButton *)button
{
    SeeCommentController *seeController = [[SeeCommentController alloc]init];
    seeController.order_id = self.order_id;
    [self.navigationController pushViewController:seeController animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.shopsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopModel.shop_goods.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailTableCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailTableCell" owner:self options:nil] lastObject];
    OrderGoodsModel * goodsModel = self.shopModel.shop_goods[indexPath.row];
    
    [cell config:goodsModel];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyOrderCellHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderCellHeader" owner:self options:nil] lastObject];
    header.orderStatusLabel.alpha = 0;
    header.orderArrowImage.hidden = YES;
    header.shopNameLabel.text = self.shopModel.shop_name;
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - 发消息联系买家
- (void)contactBtnClickedAction:(UIButton *)btn
{
#warning 联系商家需要即时通讯
    NSLog(@"发消息联系买家");
    //    MovieShopCarViewController *refundVC = [[MovieShopCarViewController alloc] init];
    //    [refundVC setHidesBottomBarWhenPushed:YES];
    //    [self.navigationController pushViewController:refundVC animated:YES];
}

#pragma mark - 打电话按钮
- (void)callNumBtnClickedAction:(UIButton *)btn
{
    NSLog(@"打电话按钮");
    UIAlertController *Alertview=[UIAlertController alertControllerWithTitle:@"是否联系买家？" message:self.contact_phone preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Okaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        [SysTool makePhoneCall:self.contact_phone];

    }];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [Alertview addAction:cancleAction];
    [Alertview addAction:Okaction];
    
    [self presentViewController:Alertview animated:YES completion:nil];
    
    
    
    
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
