//
//  MovieOrderDetailViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieOrderDetailViewController.h"
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
#import "SysTool.h"
#import "AllOrderCell.h"
#import "OrderCommentsController.h"


#define BTN_TAG_START 300

@interface MovieOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

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

@property (nonatomic,strong)NSString *status;
//价格
@property (nonatomic,strong)NSString * sendPrice;





@end

@implementation MovieOrderDetailViewController

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
        [_tbFooterView.callNumBtn setTitle:@"联系商家" forState:UIControlStateNormal];
    }
    return _tbFooterView;
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
    //    [leftBtn setBackgroundColor:[UIColor whiteColor]];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)backAction{

    if ([self.backRoot isEqualToString:@"1"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar1:@"订单详情"];
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
    
    [HttpRequestServers requestBaseUrl:TIOrder_OrderDetail withParams:userDict withRequestFinishBlock:^(id result) {
        
        NSDictionary *dict = result;
        HHNSLog(@"----->%@,%@,%@",TIOrder_OrderDetail,userDict,dict);
        if ([dict[@"code"] intValue]==0) {
            ///开始要把数据清空
            [self.shopsArray removeAllObjects];
            [self.goodsArray removeAllObjects];
            
            //NSArray *listArray = dict[@"data"];
            NSDictionary *shopDcit  = dict[@"data"];
            MyOrderShopModel *shopModel = [[MyOrderShopModel alloc] initWithDict:shopDcit];
            self.status =  shopModel.status;
            [self.shopsArray addObject:shopModel];

            NSString * addressLStr = [NSString stringWithFormat:@"收货地址：%@%@%@%@",shopModel.province_name,shopModel.city_name,shopModel.district_name,shopModel.address];
            
            self.tbHeaderView.addressLabel.text = [WNController nullString:addressLStr];
            self.tbHeaderView.phoneLabel.text = [WNController nullString:shopModel.contact_phone];
            self.tbHeaderView.shouhuorenLabel.text =[WNController nullString:shopModel.consignee_name];
            self.tbFooterView.price.text = [NSString stringWithFormat:@"￥%@",[WNController nullString:shopModel.order_amount]];
            self.sendPrice = shopModel.order_amount;
            self.tbHeaderView.orderStatusLabel.text = shopModel.status_name;
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
    switch ([self.status integerValue]) {
        case 1:  //待付款
        {
            //取消订单
            UIButton *cancelBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"取消订单"];
            [cancelBtn addTarget:self action:@selector(warnPostMineOrderBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancelBtn];
            
            //付款按钮
            UIButton *payBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"付款"];
            [payBtn addTarget:self action:@selector(payMineOrderFeeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:payBtn];
            
        }
            break;
        case 2:  //待发货
        {
            
            if([self.goodsModel.order_status intValue]==4)
            {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
                label.font = [UIFont systemFontOfSize:13];
                [bottomView addSubview:label];
                
                label.text = @"等待商家取消";
                label.textColor = [UIColor redColor];
                
            }
            else if([self.goodsModel.order_status intValue]==6)//商家取消了订单
            {
                UIButton *left = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"不同意取消"];
                [left addTarget:self action:@selector(actionBuyerDisagreeCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:left];
                
                UIButton *right = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"同意取消"];
                [right addTarget:self action:@selector(actionBuyerAgreeCancelOrder:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:right];


            }
            else
            {
                UIButton *warnBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"取消订单"];
                [warnBtn addTarget:self action:@selector(warnPostMineOrderBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:warnBtn];
                
            }
        }
            break;
        case 3: //待收货
        {
            if([self.goodsModel.order_status intValue]!=9)
            {
                //延迟收货
                UIButton *checkDeliveyBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"延迟收货"];
                [checkDeliveyBtn addTarget:self action:@selector(checkMineOrderDeliveryBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [bottomView addSubview:checkDeliveyBtn];
            }
            else
            {
                
            }
            //确认收货
            UIButton *comfirmReceiveBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"确认收货"];
            [comfirmReceiveBtn addTarget:self action:@selector(comfirmReceiveMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:comfirmReceiveBtn];
            
            
        }
            break;
        case 4: //待评论
        {
            //评价
            UIButton *commentBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"评价"];
            [commentBtn addTarget:self action:@selector(commentMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:commentBtn];
            
        }
            break;
        case 5: //已评论
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth-90, CGRectGetMinY(leftBtnFrame), 80, 30)];
            label.font = [UIFont systemFontOfSize:13];
            [bottomView addSubview:label];
            
            label.text = @"该订单已完成";
            
            label.textColor = [UIColor redColor];
            
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
        case 7://待退押金
            break;
        {
            
            
        }
            break;
            
        case 8://退款中
        {
            
        }
            break;
        case 9://退款成功
        {
            
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

#pragma mark - 付款按钮被点击
- (void)payMineOrderFeeBtnClicked:(UIButton *)button
{
    HHNSLog(@"付款按钮被点击");
    //订单号
    
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"pay_status"] = @"1";
    dict[@"pay_id"] = @"1";
    dict[@"order_id"] = self.order_id;
    dict[@"price"] = self.sendPrice;
    
    PayOrderController * payOrder = [[PayOrderController alloc]init];
    payOrder.orderPayDic = dict;
    [self.navigationController pushViewController:payOrder animated:YES];
}




- (void)goBackLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 取消订单 或关闭订单
- (void)warnPostMineOrderBtnClicked1:(UIButton *)button
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        HHNSLog(@"取消");
        
    }];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.order_id,@"order_id", @"0",@"status", nil];
        [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:userDict withRequestFinishBlock:^(id result) {
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
 *  同意取消订单
 *
 *  @param btn 按钮对象
 */
- (void)actionBuyerAgreeCancelOrder:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定同意取消订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }];
    UIAlertAction *confirmAction  = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确认");
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
 *  不同意取消订单
 *
 *  @param btn 按钮对象
 */
-(void)actionBuyerDisagreeCancelOrder:(UIButton *)btn
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

#pragma mark - 延迟收货
- (void)checkMineOrderDeliveryBtnClicked:(UIButton *)button
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.order_id,@"order_id", nil];
    [HttpRequestServers requestBaseUrl:TIOrder_Delay withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        @try {
            if ([dict[@"code"] intValue] == 0) {
                
                [PromptLabel custemAlertPromAddView:self.view text:@"延迟收货成功"];
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

#pragma mark - 确认收货按钮被点击
- (void)comfirmReceiveMineOrderBtnClicked:(UIButton *)button
{
    HHNSLog(@"确认收货按钮被点击");
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.order_id,@"order_id", @"1",@"status", nil];
    [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        @try {
            if ([dict[@"code"] intValue] == 0) {
                
                //                [PromptLabel custemAlertPromAddView:self.view text:@"确认收货成功"];
                [DeliveryUtility showMessage:@"确认收货成功" target:nil];
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

#pragma mark - 评论按钮被点击
- (void)commentMineOrderBtnClicked:(UIButton *)button
{
    OrderCommentsController *commentVC = [[OrderCommentsController alloc]init];
    commentVC.orderModel = [[OrderDataModel alloc]init];
    commentVC.orderModel = self.goodsModel;
    [commentVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 删除订单按钮被点击
- (void)delectMineOrderBtnClicked:(UIButton *)button
{
    HHNSLog(@"删除订单按钮被点击");
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createDelecteMineOrderWithOrderId:self.order_id CallBack:^(id obj) {
        
        [HUD hide:YES];
        [PromptLabel custemAlertPromAddView:window text:@"删除成功"];
        [self performSelector:@selector(goBackLastView) withObject:nil afterDelay:0.5];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
    
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
    AllOrderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AllOrderCell" owner:self options:nil] lastObject];
    OrderGoodsModel * goodsModel = self.shopModel.shop_goods[indexPath.row];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary ];
    dict[@"order_id"]=goodsModel.order_id;
    dict[@"shop_id"]=goodsModel.shop_id;
    dict[@"goods_id"]=goodsModel.goods_id;
    dict[@"goods_name"]=goodsModel.goods_name;
    dict[@"goods_number"]=goodsModel.goods_number;
    dict[@"goods_price"]=goodsModel.goods_price;
    dict[@"name_value_str"]=goodsModel.name_value_str;
    dict[@"img_path"]=goodsModel.img_path;
    dict[@"goods_deposit"]=goodsModel.goods_deposit;
    dict[@"is_deposit"]=goodsModel.is_deposit;
    dict[@"is_refund"]=goodsModel.is_refund;
    [cell config:dict];
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
    header.orderArrowImage.hidden =YES;
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
    //    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",courierModel.mobile];
    
    UIAlertController *Alertview=[UIAlertController alertControllerWithTitle:@"是否联系商家？" message:self.shopModel.shop_tel preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Okaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [SysTool makePhoneCall:self.shopModel.shop_tel];
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
