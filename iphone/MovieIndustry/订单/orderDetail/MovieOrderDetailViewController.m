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

//地址数组
@property (nonatomic,strong)NSMutableArray * addressArray;

@property (nonatomic,strong)OrderShopModel * shopModel;

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
    }
    return _tbFooterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"订单详情"];
    self.dataString = @"";
    [self createOrderDetailView];
    
    [self loadData];
}

#pragma mark - 初始化数据
- (void)loadData
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    
    
    
//    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.order_id,@"order_id",@"6",@"user_id", nil];
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
                    MyOrderShopModel *shopModel = [[MyOrderShopModel alloc] init];
                    [shopModel setValue:[WNController nullString:shopDcit[@"order_status"]] forKey:@"order_status"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"consignee_name"]] forKey:@"consignee_name"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"contact_phone"]] forKey:@"contact_phone"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"post_code"]] forKey:@"post_code"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"province_name"]] forKey:@"province_name"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"city_name"]] forKey:@"city_name"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"district_name"]] forKey:@"district_name"];
                    [shopModel setValue:[WNController nullString:shopDcit[@"address"]] forKey:@"address"];
                    
                    [shopModel setValue:[WNController nullString:shopDcit[@"remark"]] forKey:@"remark"];
                    
                    [shopModel setValue:[WNController nullString:shopDcit[@"order_amount"]] forKey:@"order_amount"];
                    
                    [shopModel setValue:[WNController nullString:shopDcit[@"order_status"]] forKey:@"order_status"];
                  
                    [shopModel setValue:[WNController nullString:shopDcit[@"method"]] forKey:@"method"];
                    shopModel.order_goods = shopDcit[@"order_goods"];
                shopModel.spare_address = shopDcit[@"spare_address"];
                shopModel.status = shopDcit[@"status"];
                [self.shopsArray addObject:shopModel];
                    NSString * addressLStr = [NSString stringWithFormat:@"收货地址：%@%@%@%@",shopModel.province_name,shopModel.city_name,shopModel.district_name,shopModel.address];
                    
                    self.tbHeaderView.addressLabel.text = [WNController nullString:addressLStr];
                    self.tbHeaderView.phoneLabel.text = [WNController nullString:shopModel.contact_phone];
                    self.tbHeaderView.shouhuorenLabel.text =[WNController nullString:shopModel.consignee_name];
                    self.tbFooterView.price.text = [NSString stringWithFormat:@"￥%@",[WNController nullString:shopModel.order_amount]];
                NSString * typePoss = @"";
#warning 这边需要判断送货类型
                if ([shopModel.method isEqualToString:@"0"]) {
                    typePoss = @"商家送货";
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
                    [self.mainTableView reloadData];
                    
                }
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    ///遍历商品数组 ///添加可变数组
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
    self.tbHeaderView.orderStatusLabel.text = [self orderStatusWithString:self.order_status];
    
    [self createViewBottomView];
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


- (void)createViewBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight-44-50,kViewWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = 80.0f;
    CGRect rightBtnFrame = CGRectMake(kViewWidth-90, 10,btnWidth, 30.0f);
    CGRect leftBtnFrame = CGRectMake(kViewWidth-100-btnWidth,10,btnWidth, 30.0f);
    
    //点击订单状态 返回数据 订单状态(0待付款,1待发货,2待收货,3待评论,为9则为全部) 默认是9
    switch ([self.order_status integerValue]) {
        case 1:  //待付款
        {
            //付款按钮
            UIButton *payBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"付款"];
            [payBtn addTarget:self action:@selector(payMineOrderFeeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:payBtn];
            
            //取消订单
            UIButton *cancelBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"取消订单"];
            [cancelBtn addTarget:self action:@selector(warnPostMineOrderBtnClicked1:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancelBtn];
        }
            break;
        case 2:  //待发货
        {
            //提醒发货
            UIButton *warnBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"取消订单"];
            [warnBtn addTarget:self action:@selector(warnPostMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:warnBtn];
        }
            break;
        case 3: //待收货
        {
            //确认收货
            UIButton *comfirmReceiveBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"确认收货"];
            [comfirmReceiveBtn addTarget:self action:@selector(comfirmReceiveMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:comfirmReceiveBtn];
            
            //查看物流
            UIButton *checkDeliveyBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"延迟收货"];
            [checkDeliveyBtn addTarget:self action:@selector(checkMineOrderDeliveryBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:checkDeliveyBtn];
        }
            break;
        case 4: //待评论
        {
            //评价
            UIButton *commentBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"评价"];
            [commentBtn addTarget:self action:@selector(commentMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:commentBtn];
            
            //删除订单
//            UIButton *delectBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"删除订单"];
//            [delectBtn addTarget:self action:@selector(delectMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [bottomView addSubview:delectBtn];
        }
            break;
        case 5: //待评论
        {
            //删除订单
            UIButton *delectBtn = [self orderDetailButtonWithFrame:leftBtnFrame andTitle:@"删除订单"];
            [delectBtn addTarget:self action:@selector(delectMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:delectBtn];
        }
            break;
        case 6:
        {
            //删除订单
            UIButton *delectBtn = [self orderDetailButtonWithFrame:rightBtnFrame andTitle:@"删除订单"];
            [delectBtn addTarget:self action:@selector(delectMineOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:delectBtn];
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
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    hud.labelText = @"正在付款";

   [HttpRequestServers sendAlipayWithOrderSn:self.order_id orderName:@"咖么测试" orderDescription:@"1分钱测试" orderPrice:@"0.01" andScallback:^(id obj)
     {
         
         NSDictionary *aliDict = obj;
         HHNSLog(@"支付回调参数 aliDict %@",aliDict);
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         if ([aliDict[@"resultStatus"] isEqualToString:@"9000"])
         {
             [HttpRequestServers requestBaseUrl:TIPay_CallBack withParams:dict withRequestFinishBlock:^(id result) {
                 
                 if ([result[@"code"] intValue] == 0) {
                     hud.labelText = @"付款成功！";
                     [hud hide:YES];
                     PaySuccessViewController *paySucVc = [[PaySuccessViewController alloc] init];
                     paySucVc.order_SN = self.order_id;
                     paySucVc.order_id = self.order_id;
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


#pragma mark - 取消订单按钮被点击
- (void)cancelMineOrderBtnClicked:(UIButton *)button
{
    HHNSLog(@"取消订单按钮被点击");
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createConfirmCancelMineOrderWithOrdernum:self.orderNum CallBack:^(id obj) {
        
        [HUD hide:YES];
//        [PromptLabel custemAlertPromAddView:window text:@"订单取消成功"];
         [DeliveryUtility showMessage:@"订单取消成功" target:nil];
        [self performSelector:@selector(goBackLastView) withObject:nil afterDelay:0.5];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

- (void)goBackLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 取消订单
- (void)warnPostMineOrderBtnClicked1:(UIButton *)button
{
 
    
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
}



- (void)warnPostMineOrderBtnClicked:(UIButton *)button
{
//    [PromptLabel custemAlertPromAddView:self.view text:@"已支付订单，如要取消须联系商家"];
     [DeliveryUtility showMessage:@"已支付订单，如要取消须联系商家" target:nil];
    
//    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.order_id,@"order_id", @"0",@"status", nil];
//    [HttpRequestServers requestBaseUrl:TIOrder_ConfirmOrder withParams:userDict withRequestFinishBlock:^(id result) {
//        NSDictionary *dict = result;
//        HHNSLog(@"%@",dict);
//        @try {
//            if ([dict[@"code"] intValue] == 0) {
//                
//                [PromptLabel custemAlertPromAddView:self.view text:@"取消订单成功"];
//                [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - 查看订单物流按钮被点击
- (void)checkMineOrderDeliveryBtnClicked:(UIButton *)button
{
    HHNSLog(@"查看订单物流按钮被点击");
    
    MovieDeliveryDetailViewController *deliveryVC = [[MovieDeliveryDetailViewController alloc] init];
    deliveryVC.orderId = self.order_id;
    [self.navigationController pushViewController:deliveryVC animated:YES];
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
    MyOrderShopModel *shopModel = self.shopsArray[0];
    NSArray *goodsModelArray = self.goodsArray[0];
    HHNSLog(@"评论按钮被点击");
    MovieCommentViewController *commentVC = [[MovieCommentViewController alloc] init];
    commentVC.shopModel = shopModel;
    commentVC.goodsModelArray = goodsModelArray;
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
    
    UIAlertController *Alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否联系商家？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Okaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString * urlStr = [NSString stringWithFormat:@"tel://10086"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
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
