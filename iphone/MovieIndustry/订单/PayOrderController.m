//
//  PayOrderController.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "PayOrderController.h"
#import "PayOrderBottomView.h"
#import "PayOrderHeadCell.h"
#import "CartGood.h"
#import "PaySuccessViewController.h"
#import "UPPaymentControl.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"


@interface PayOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)PayOrderBottomView * bottomView;

@property (nonatomic,strong)NSString * orderId;

@end

@implementation PayOrderController

- (void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"支付订单"];
    //创建地址
    [self createTableView];
    [self createAddress];
    [self loadData];
    // Do any additional setup after loading the view.
}
/**
 *  加载数据
 */
- (void)createAddress{
    self.bottomView.addressDic = self.addressDic;
}

-(void)loadData
{
    if(self.orderPayDic){
   
           NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.orderPayDic[@"order_id"],@"order_id",APP_DELEGATE.user_id,@"user_id", nil];
        [HttpRequestServers requestBaseUrl:TIOrder_OrderDetail withParams:userDict withRequestFinishBlock:^(id result) {
            @try {
                NSLog(@"%@",result);
                NSDictionary * dic = result[@"data"];
                NSArray * goodArray = dic[@"order_goods"][0][@"shop_goods"];
                NSMutableDictionary * addressDic = [NSMutableDictionary dictionary];
                addressDic[@"name"] = [NSString stringWithFormat:@"收货人：%@",dic[@"consignee_name"]];
                addressDic[@"address"] = [NSString stringWithFormat:@"收货地址：%@%@%@%@",dic[@"province_name"],dic[@"city_name"],dic[@"district_name"],dic[@"address"]];
                addressDic[@"phone"] = dic[@"contact_phone"];
                addressDic[@"price"] = self.orderPayDic[@"price"];
                self.addressDic = addressDic;
                self.bottomView.addressDic = self.addressDic;
                NSMutableArray * orderArray = [NSMutableArray array];
                for (int i = 0; i<goodArray.count; i ++) {
                    CartGood * good = [[CartGood alloc]initWithDict:goodArray[i]];
                    good.goods_deposit = @"100";
                    [orderArray addObject:good];
                }
                self.goodsInfoArray = orderArray;
                [self.tableView reloadData];
                
            }
            @catch (NSException *exception) {
            }
            @finally {
            }
            
            
        } withFieldBlock:^{
            
        }];
    }
}
/**
 *  创建tableview视图
 */
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    PayOrderBottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"PayOrderBottomView" owner:self options:nil]lastObject];
    self.bottomView = bottomView;
    [bottomView  createMyTableViewAndEndBlock:^(NSString *type) {
        if ([type isEqualToString:@"0"]) {
            //支付宝
            NSLog(@"支付宝");
            
            if (!self.payDict) {
                [HttpRequestServers sendAlipayWithOrderSn:self.orderPayDic[@"order_id"] orderName:@"咖么支付测试" orderDescription:@"1分钱测试" orderPrice:[NSString stringWithFormat:@"%f",0.01] andScallback:^(id obj)
                 {
                     
                     NSDictionary *aliDict = obj;
                     HHNSLog(@"支付回调参数 aliDict %@",aliDict);
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                     if ([aliDict[@"resultStatus"] isEqualToString:@"9000"])
                     {
                         
                         NSMutableDictionary * orderDic = [NSMutableDictionary dictionaryWithDictionary:self.orderPayDic];
                         
                         [HttpRequestServers requestBaseUrl:TIPay_CallBack withParams:orderDic withRequestFinishBlock:^(id result) {
                             
                             if ([result[@"code"] intValue] == 0) {
                                 PaySuccessViewController *paySucVc = [[PaySuccessViewController alloc] init];
                                 paySucVc.order_SN = self.orderPayDic[@"order_id"];
                                 paySucVc.order_id = self.orderPayDic[@"order_id"];
                                 [self.navigationController pushViewController:paySucVc animated:YES];
                                 
                             }else{
                             }
                         } withFieldBlock:^{
                         }];
                     }
                     
                     if ([aliDict[@"resultStatus"] isEqualToString:@"8000"]) {
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         [DeliveryUtility showMessage:@"正在处理中" target:nil];
                     }
                     if ([aliDict[@"resultStatus"] isEqualToString:@"4000"]) {
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         [DeliveryUtility showMessage:@"订单支付失败" target:nil];
                     }
                     if ([aliDict[@"resultStatus"] isEqualToString:@"6001"]) {
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         [DeliveryUtility showMessage:@"用户中途取消付款" target:nil];
                         
                     }
                     if ([aliDict[@"resultStatus"] isEqualToString:@"6002"]) {
                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         [DeliveryUtility showMessage:@"网络连接出错" target:nil];
                     }
                 }];

            }else {
            NSMutableDictionary * mutDic = [NSMutableDictionary dictionaryWithDictionary:self.payDict];
                [HttpRequestServers requestBaseUrl:TIOrder_AddOrder withParams:mutDic withRequestFinishBlock:^(id result) {
                    NSDictionary *dict = result;
                    HHNSLog(@"---------->> %@",dict);
                    
                    
                    
                    
                    @try {
                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                     
                            ///开始调用支付接口
                                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
                                dict1[@"user_id"] = APP_DELEGATE.user_id;
                                dict1[@"pay_status"] = @"1";
                                dict1[@"pay_id"] = @"1";
                            dict1[@"order_id"]= dict[@"data"];
                            if (!self.orderId) {
                                self.orderId =dict[@"data"];
                            }
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [HttpRequestServers sendAlipayWithOrderSn:self.orderId orderName:@"咖么测试" orderDescription:@"1分钱测试" orderPrice:[NSString stringWithFormat:@"%.2f",0.01] andScallback:^(id obj) {
                                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                    NSDictionary *aliDict = obj;
                                    HHNSLog(@"支付回调参数 aliDict %@",aliDict);
                                    
                                    if ([aliDict[@"resultStatus"] isEqualToString:@"9000"])
                                    {
                                        PaySuccessViewController *paySucVc = [[PaySuccessViewController alloc] init];
                                        paySucVc.order_SN = dict[@"data"];
                                        paySucVc.order_id = dict[@"data"];
                                        [HttpRequestServers requestBaseUrl:TIPay_CallBack withParams:dict1 withRequestFinishBlock:^(id result) {
                                            //                                    [DeliveryUtility showMessage:@"支付成功" target:self];
                                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                            
                                            [self.navigationController pushViewController:paySucVc animated:YES];
                                        } withFieldBlock:^{
                                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
                                
                            }];
                      
            
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                   }
   
                } withFieldBlock:^{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }];
        }
        }
        if ([type isEqualToString:@"1"]){
            //银联
            NSLog(@"银联");
            [[UPPaymentControl defaultControl] startPay:@"12324564875434721"fromScheme:@"UPPayDemokM" mode:@"00" viewController:self];

            
            NSMutableDictionary * mutDic = [NSMutableDictionary dictionaryWithDictionary:self.payDict];
//            [HttpRequestServers requestBaseUrl:TIOrder_AddOrder withParams:mutDic withRequestFinishBlock:^(id result) {
//                NSDictionary *dict = result;
//                HHNSLog(@"---------->> %@",dict);
//                @try {
//                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                    if ([dict[@"code"] intValue]==0)
//                    {
//                        ///开始调用支付接口
//                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                        NSMutableDictionary * dict1 = [NSMutableDictionary dictionary];
//                        dict1[@"user_id"] = APP_DELEGATE.user_id;
//                        dict1[@"pay_status"] = @"1";
//                        dict1[@"pay_id"] = @"1";
//                        dict1[@"order_id"]= dict[@"data"];
//                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                        [[UPPaymentControl defaultControl] startPay:dict1[@"order_id"]fromScheme:@"UPPayDemokM" mode:@"00" viewController:self];
//                        }];
//                    }
//                }
//                @catch (NSException *exception) {
//                    
//                }
//                @finally {
//                    
//                }
//                
//            } withFieldBlock:^{
//                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            }];
        }
        if ([type isEqualToString:@"2"]) {
            [self WXpayDemo:@"201601191229196401538"];
        }
        
    }];
    CGSize size =CGSizeMake(self.view.frame.size.width, 103*3+400+100);
    bottomView.tableView.frame = CGRectMake(0, 0,  self.view.frame.size.width, 192);
    self.tableView.contentSize = size;
    bottomView.payBtn.layer.cornerRadius = 5.0f;
    [bottomView.payBtn addTarget:self action:@selector(actionPay) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = bottomView;
    
}


- (void)WXpayDemo:(NSString *)orderid{
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:@"wxd8f37269581ddec2" mch_id:@"1300124601"];
    //设置密钥
    [req setKey:@"SDL94P6OUQ1I6A82ED4TP7APCKOF53SQ"];
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demoWith:@"dd" withOrderId:orderid withPrise:@"1"];
    if(dict == nil) {
        //错误提示
    } else {
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = [dict[@"timestamp"] intValue];
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        if (![WXApi isWXAppInstalled]) {
            NSLog(@"没有安装微信");
        }
        [WXApi sendReq:req];
        [WXApi openWXApp];
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model) {
        return 1;
    }else{
        return self.goodsInfoArray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PayHeadCell";
    PayOrderHeadCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PayOrderHeadCell" owner:self options:nil]lastObject];
    }
    if (self.model) {
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.model.imgs[0]]]];
        cell.goodsNameLbl.text = self.model.goods_name;
        cell.goodsPriceLbl.text = [NSString stringWithFormat:@"￥%@",self.model.goods_price];
        cell.goodsNumebrLbl.text = [NSString stringWithFormat:@"X%@",self.goodsCount];
        
        if (!self.model.goods_deposit) {
            self.model.goods_deposit = @"0";
        }
        
        cell.yajinLabel.text = [NSString stringWithFormat:@"￥%@",self.model.goods_deposit];
    }else{
        CartGood * good = self.goodsInfoArray[indexPath.row];
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,good.img_path]]];
        cell.goodsNameLbl.text = good.goods_name;
        cell.goodsPriceLbl.text = [NSString stringWithFormat:@"￥%@",good.goods_price];
        cell.goodsNumebrLbl.text = [NSString stringWithFormat:@"X%@",good.goods_number];
        cell.yajinLabel.text = [NSString stringWithFormat:@"￥%@",good.goods_deposit];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)actionPay{}
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
