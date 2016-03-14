//
//  MovieComfirmOrderViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#define kPostTypeButton_Tag
#import "MovieComfirmOrderViewController.h"
#import "MovieComfirmOrderDetailCell.h"
#import "MovieGoodsInfoViewController.h"
#import "ShippingAddressController.h"
#import "ShippingAddressListController.h"
#import "ShippingAddressModel.h"
#import "ChooseExpressTypeView.h"
#import "PaySuccessViewController.h"
#import "ShopCarShopModel.h"
///收货地址
#import "ReceiveAddressView.h"
///店铺的头视图
#import "ShopTableViewHeader.h"
///tableView的尾部视图
#import "ShopGroupFooter.h"
#import "ShipingMethodModel.h"
#import "ShippingAddressController.h"
#import "CartGood.h"

#import "ShopSendView.h"
//支付选择控制器
#import "PayOrderController.h"


@interface MovieComfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,ShippingAddressListDelegate,ShippingAddressControllerDelegate>

@property (nonatomic,retain)UITableView *mainTableView;

//留言文本输入框
@property (nonatomic,strong) UITextField *txtMessage;

//总价标签
@property (nonatomic,strong) UILabel *priceLab;

///默认地址ID
@property (nonatomic,copy) NSString *morenAddressID;

///商品模型数组
@property (nonatomic,strong) NSMutableArray *goodsArray;
///商铺模型
@property (nonatomic,strong) NSMutableArray *shopsArray;
///选择送货方式View
@property (nonatomic,strong) ChooseExpressTypeView *chooseExpressView;
@property (nonatomic,strong)ShopGroupFooter *footView;
///快递label
@property (nonatomic,strong) UILabel *expressLabel;
//当前价格
@property (nonatomic,copy) NSString *currPriceString;
///收货地址View
@property (nonatomic,strong)ReceiveAddressView *addressView;
///送个货方式
@property (nonatomic,strong) NSMutableArray *shippingMethodArr;
////确认订单参数数组
@property (nonatomic,strong) NSMutableArray *paramaterArray;
///存储留言字典
@property (nonatomic,strong) NSMutableDictionary *memoDict;
///存储快递信息字典
@property (nonatomic,strong) NSMutableDictionary *expressDict;

//总价格
@property (nonatomic,assign) CGFloat totalPrice;

@property (nonatomic,assign)BOOL isHaveAddress;

@property (nonatomic,strong)NSString * shopName;


@property (nonatomic,strong)NSString * addressID;

@property (nonatomic,strong)UITextField * textFiledFoot;

@property (nonatomic,assign)CGFloat goodsPrice;


@property (nonatomic,strong)ShopSendView * shop;
@property (nonatomic,strong)UIView * bgView;

@property (nonatomic,strong)NSMutableDictionary * addressDic;

@end

@implementation MovieComfirmOrderViewController

- (void)alertViewControllerShow{

    UIAlertController *Alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"你还没有收货地址，快去添加吧" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Okaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [Alertview addAction:Okaction];
    [self presentViewController:Alertview animated:YES completion:nil];
}

- (NSMutableDictionary *)memoDict
{
    if (!_memoDict) {
        _memoDict = [NSMutableDictionary dictionary];
    }
    return _memoDict;
}

- (NSMutableDictionary *)expressDict
{
    if (!_expressDict) {
        _expressDict = [NSMutableDictionary dictionary];
    }
    return _expressDict;
}

- (NSMutableArray *)shippingMethodArr
{
    if (!_shippingMethodArr) {
        _shippingMethodArr = [NSMutableArray array];
    }
    return _shippingMethodArr;
}
//创建底部的积分View
- (UIView *)CreateScoreView{

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kViewWidth/2+30, 20)];
//这边可以传参过来设置
    label.text = @"   可用200咖么积分";
    [view addSubview:label];
    label.font = [UIFont systemFontOfSize:15];
    UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(kViewWidth/2+30, 15, kViewWidth-30-kViewWidth/2, 20)];
    tf.placeholder = @"100咖么积分＝1元";
    tf.font = [UIFont systemFontOfSize:14];
    tf.textColor = [UIColor lightGrayColor];
    [view addSubview:tf];
    return view;
    
}


//当不存在address的时候，创建一个新的view
- (UIView *)createAddressView{
//CGRectMake(0, 0, kViewWidth, 84);
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 94)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat labelY = 30;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, labelY, kViewWidth, 24)];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = 1;
    label.text = @"点击添加收货地址";
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kViewWidth - 30, 27, 20, 20)];
    imageV.image = [UIImage imageNamed:@"help_right.png"];
    [view addSubview:imageV];
    UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 81, kViewWidth, 3)];
    imageV1.image = [UIImage imageNamed:@"line_red.png"];
    [view addSubview:imageV1];
    UIButton * button = [[UIButton alloc]initWithFrame:view.frame];
    [button addTarget:self action:@selector(goCreateAddress) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 84, kViewWidth, 10)];
    view1.backgroundColor = [UIColor lightGrayColor];
    view1.alpha = 0.5;
    [view addSubview:view1];
    return view;
}

- (void)goCreateAddress{

    NSLog(@"去收货地址页面");
    ShippingAddressController * shipp = [[ShippingAddressController alloc]init];
    [self.navigationController pushViewController:shipp animated:YES];
    
}

- (ReceiveAddressView *)addressView
{
    if (!_addressView) {
        _addressView = [[[NSBundle mainBundle] loadNibNamed:@"ReceiveAddressView" owner:self options:nil] lastObject];
//        _addressView.backgroundColor = [UIColor redColor];
        [_addressView.chooseAddressButton addTarget:self action:@selector(chooseAddressButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressView;
}

- (ChooseExpressTypeView *)chooseExpressView
{
    if (!_chooseExpressView) {
        _chooseExpressView = [[ChooseExpressTypeView alloc] init];
        
    }
    return _chooseExpressView;
}


- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (NSMutableArray *)shopsArray
{
    if (!_shopsArray) {
        _shopsArray = [NSMutableArray array];
    }
    return _shopsArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self setNavTabBar:@"确认订单"];
    self.totalPrice = 0.00;
    if (!self.tebie) {
        self.tebie = @"0";
    }
    
    if (!self.isShoppingCar) {
        self.isShoppingCar = @"0";
    }
    
    //初始化接送方式
    
    if (APP_DELEGATE.addressPalce) {
        self.morenAddressID = APP_DELEGATE.addressPalce;
        
    }
    

    //监听键盘的高度
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    ///首先检查有没有收货地址 和默认地址
    
    if (self.isHaveAddress) {
        
    }else{
    [self loadAddressMoren];
    ////查询呢收货地址
//    [self loadAddressList];
    
    ///初始化确认订单
    [self loadInitOrder];
    
    ///送货方式
        [self loadShippingMethod];
    }
}
- (void)removeTapGesAction
{
    [UIView animateWithDuration:0.3 animations:^{
        self.shop.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 180);
        self.bgView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
    }];
    
}


- (void)viewDidLoad{

    [super viewDidLoad];
    self.addressDic = [NSMutableDictionary dictionary];
    ShopSendView * shop = [[ShopSendView alloc]initWithFrame:CGRectMake(0,kViewHeight, kViewWidth, 180) AndClickBlock:^(NSString *possType) {
        NSLog(@"%@",possType);
        self.expressLabel.text = possType;
        [self removeTapGesAction];
    }];
    self.shop = shop;
    shop.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTapGesAction)];
    [bgView addGestureRecognizer:tapGes];
    
}

- (void)setBottmPrice{

    if(self.model){
        CGFloat  price = [self.model.goods_price intValue] * [self.goodsCount intValue] + [self.model.goods_deposit intValue] * [self.goodsCount intValue];
        self.addressDic[@"price"] = [NSString stringWithFormat:@"%.2f",price];
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f",price]];
        [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        self.priceLab.attributedText = priceStr;
    }else{
        int count = 0;
        CGFloat price1;
        for (CartGood * good in self.goodsInfoArray) {
            count += [good.goods_number intValue];
            price1 += [good.goods_price intValue] * [good.goods_number intValue] +[good.goods_deposit intValue] * [good.goods_number intValue];
        }
        self.addressDic[@"price"] = [NSString stringWithFormat:@"%.2f",price1];
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f",price1]];
        [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        self.priceLab.attributedText = priceStr;
    }
}



#pragma mark - 选择收货地址
- (void)chooseAddressButtonAction
{
    ShippingAddressListController *addressList = [[ShippingAddressListController alloc] init];
    addressList.delegate = self;
    [self.navigationController pushViewController:addressList animated:YES];
}

#pragma mark - 初始化订单信息
- (void)loadInitOrder{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;

    if (!self.model) {
        GoodDesModel * model = self.goodsInfoArray[0];
        dict[@"shop_id"] = model.shop_id;
    }else{
        dict[@"shop_id"] = self.model.shop_id;
    }
    
    
    [HttpRequestServers requestBaseUrl:TIShop_ShopDetail withParams:dict withRequestFinishBlock:^(id result) {
        if ([result[@"code"] intValue] == 0) {
              self.shopName = result[@"data"][0][@"shop_name"];
        }
    } withFieldBlock:^{
        
    }];
    

}


#pragma mark - 检查默认地址 获取默认地址
- (void)loadAddressMoren
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [HttpRequestServers requestBaseUrl:TIShipping_AddrList withParams:userDict withRequestFinishBlock:^(id result) {
        
        @try {
            NSDictionary *dict = result;
            HHNSLog(@"-------->%@",dict);
            if ([dict[@"code"] intValue]==0) {
                id addressDict = dict[@"data"];
                
            
                
                if (![[addressDict class] isSubclassOfClass:[NSArray class]]) {
                    self.isHaveAddress = NO;
                    [self createComifirmOrderView];
                }
                else
                {
                    self.isHaveAddress = YES;

                    [self createComifirmOrderView];
                    NSArray *addressArr = dict[@"data"];
                    
                    if (addressArr.count>0)
                    {
                        //                    NSDictionary *infoDict = addressArray[0];
                        for (NSDictionary *dic in addressArr)
                        {
                            if([dic[@"is_default"] intValue]==1)
                            {
                                NSString * consigneeStr = [NSString stringWithFormat:@"收货人：%@",dic[@"consignee_name"]];
                                self.addressID = dic[@"shipping_address_id"];
                                self.addressView.consigneeLabel.text = consigneeStr;

                                self.addressDic[@"name"] = consigneeStr;
                                NSString * addressStr = [NSString stringWithFormat:@"收货地址：%@%@%@",dic[@"province_name"],dic[@"city_name"],dic[@"district_name"]];
                               
                                NSMutableString * addStr = [NSMutableString string];
                                [addStr appendString:addressStr];
                                [addStr appendString:dic[@"addr_detail"]];
                                self.addressView.addressLabel.text = addStr;
                                self.addressView.phoneNumber.text = dic[@"mobile"];
                                self.addressDic[@"address"] = addStr;
                                self.addressDic[@"phone"] = dic[@"mobile"];
                        
                                ///默认地址ID
                                self.morenAddressID = dic[@"shipping_address_id"];
                                APP_DELEGATE.addressPalce = dic[@"shipping_address_id"];
                                ///有收获地址之后才会
                        
                                int  price;
                                if (self.model) {
                                    price = [self.model.goods_price intValue] * [self.goodsCount intValue];
                                }else{
                        
                                    price = self.goodsPrice;
                                }
                                NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2d",price]];
                                [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
                                self.priceLab.attributedText = priceStr;
                            }
                        }
                    }
                }
                
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
//        [PromptLabel custemAlertPromAddView:self.view text:@"请检查网络"];
          [DeliveryUtility showMessage:@"请检查网络" target:nil];
        
    }];
    
    
}
#pragma mark 创建TableView
- (void)createComifirmOrderView
{
    //创建列表
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44-50) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainTableView];
    
    ///设置头视图
    self.mainTableView.tableHeaderView.frame = CGRectMake(0, 0, kViewWidth, 84);
    self.mainTableView.tableFooterView.frame = CGRectMake(0, 0, kViewWidth, 60);
    
#warning 积分管理页面
    self.mainTableView.tableFooterView = [self CreateScoreView];
    if (self.isHaveAddress==YES) {
        self.mainTableView.tableHeaderView = self.addressView;
    }else if(self.isHaveAddress == NO){
        self.mainTableView.tableHeaderView = [self createAddressView];
    }
    self.mainTableView.backgroundColor = kViewBackColor;
    
    ///创建底部View
    [self createBottomView];
}

- (void)createBottomView
{
    //创建底部
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight-44-50, kViewWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(kViewWidth-110, 0, 110, 50);
    comfirmBtn.backgroundColor = RGBColor(226,0,12,1);
    [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(comfirmMineOrderInfo:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:comfirmBtn];
    
    
    
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(comfirmBtn.frame)-160, 10, 130, 30)];
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.textColor = RGBColor(226,0,12,1);
    //    self.priceLab.text = ;
    [bottomView addSubview:self.priceLab];
    //
    [self.view addSubview:bottomView];
    [self setBottmPrice];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.model) {
        return 1;
    }else{
    return self.goodsInfoArray.count;
}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"comfirmCellID";
    MovieComfirmOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieComfirmOrderDetailCell" owner:self options:nil] lastObject];
    }
    
    if (self.model) {
        [cell config:self.model Andtype:@"0"];
           cell.goodsNumLabel.text = [NSString stringWithFormat:@"x%@",self.goodsCount];
    }else{
    
        CartGood * good = self.goodsInfoArray[indexPath.row];
        [cell initCGood:good];
            cell.goodsNumLabel.text = [NSString stringWithFormat:@"x%@",good.goods_number];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopTableViewHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"ShopTableViewHeader" owner:self options:nil]lastObject];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          headerView.shopName.text = self.shopName;
    });
    
  
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ShopGroupFooter *footerView = [[[NSBundle mainBundle] loadNibNamed:@"ShopGroupFooter" owner:self options:nil] lastObject];
    
    self.footView = footerView;
    ////初始化界面数据

    
    if(self.model){
    
        footerView.totalGoodsLabel.text = [NSString stringWithFormat:@"共%@件商品",self.goodsCount];
        CGFloat  price = [self.model.goods_price intValue] * [self.goodsCount intValue] + [self.model.goods_deposit intValue] * [self.goodsCount intValue];
        footerView.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price];
    
        self.goodsPrice = price;
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f",price]];
        [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        self.priceLab.attributedText = priceStr;
        
    }
    else{
        int count = 0;
        CGFloat price1;
        for (CartGood * good in self.goodsInfoArray) {
            count += [good.goods_number intValue];
            price1 += [good.goods_price intValue] * [good.goods_number intValue] +[good.goods_deposit intValue] * [good.goods_number intValue];
        }
           footerView.totalGoodsLabel.text = [NSString stringWithFormat:@"共%d件商品",count];
      
      footerView.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price1];
        self.goodsPrice = price1;
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f",price1]];
        [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        self.priceLab.attributedText = priceStr;

    
    }

    NSNumber *number = [NSNumber numberWithInteger:section];
    
    ////设置快递和留言的状态
    footerView.postTypeLabel.text = @"送货上门";
    self.textFiledFoot = footerView.textField;
    if ([[self.memoDict objectForKey:number] isEqualToString:@"无"]) {
        footerView.textField.text = @"";
    }else
    {
      footerView.textField.text =  [self.memoDict objectForKey:number];
    }
    
    ///
    
    [footerView.choosePostTypeButton addTarget:self action:@selector(choosePostTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    footerView.choosePostTypeButton.tag = kPostTypeButton_Tag+section;
    ////设置tag值 用于取到快递信息
    footerView.tag = section;
    footerView.textField.tag = section;
    [footerView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    return footerView;
}


#pragma mark - 选择快递方式
- (void)choosePostTypeButtonAction:(UIButton *)btn
{
    ///取到点击到的尾部视图
    ShopGroupFooter *footerView = (ShopGroupFooter *)btn.superview;
    self.expressLabel = footerView.postTypeLabel;
    [self.tabBarController.view addSubview:self.bgView];
    [self.tabBarController.view addSubview:self.shop];
    [UIView animateWithDuration:0.3 animations:^{
        self.shop.frame = CGRectMake(0, kViewHeight - 160, kViewWidth, 180);
        self.bgView.alpha = 0.3f;
    } completion:^(BOOL finished) {
    }];
    
}

#pragma mark - 判断商家送货方式
- (NSString *)judgeExpressType:(NSString *)express
{
    if ([express isEqualToString:@"送货上门"]) {
        return @"0";
    }
    if ([express isEqualToString:@"快递"]) {
        return @"1";
    }
    if ([express isEqualToString:@"自提"]) {
        return @"2";
    }
    return @"快递";
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mainTableView.contentOffset = CGPointMake(0, 100);
    }];
    return YES;
}

#pragma mark - UIAlertViewDelegate 设置收货地址的时候使用
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (buttonIndex == 1) {
        ShippingAddressController *shippingVc =[[ ShippingAddressController alloc] init];
        shippingVc.isQuerenOrder = YES;
        shippingVc.delegate = self;
        [self.navigationController pushViewController:shippingVc animated:YES];
    }
}


#pragma mark - 确认订单
- (void)comfirmMineOrderInfo:(UIButton *)btn
{
    
    if (!self.isHaveAddress) {
        [self alertViewControllerShow];
    } 
    else
    {
    if([self.delegate respondsToSelector:@selector(payMineOrderSuccess:)])
    {}
      
//    if ([self.textFiledFoot.text isEqualToString:@""]) {
//            [DeliveryUtility showMessage:@"留言没有填写" target:nil];
//            return;
//        }
   
        
        if (self.goodsInfoArray) {
            NSMutableString * orderStr = [NSMutableString string];
            int orderMoney = 0;
            for (CartGood *modelGood in self.goodsInfoArray) {
                if (modelGood.selectState) {
                    [orderStr appendString:modelGood.cat_id];
                    [orderStr appendString:@"-"];
                    [orderStr appendString:modelGood.goods_id];
                    [orderStr appendString:@"-"];
                    [orderStr appendString:modelGood.goods_number];
                    [orderStr appendString:@"-"];
                    [orderStr appendString:modelGood.goods_price];
                    [orderStr appendString:@","];
                    orderMoney += [modelGood.goods_price intValue] * [modelGood.goods_number intValue];
                }
            }
            
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict[@"user_id"] = APP_DELEGATE.user_id;
            
            if (self.addressID == nil) {
                dict[@"shipping_address_id"] = self.morenAddressID;
            }else{
                dict[@"shipping_address_id"] = self.addressID;
            }
            
        
            dict[@"goods_amount"] = [NSString stringWithFormat:@"%d",orderMoney];
            dict[@"order_amount"] = [NSString stringWithFormat:@"%d",orderMoney];
            dict[@"pay_status"] = @"1";
            dict[@"pay_id"] = @"1";
            dict[@"method"] =  [self judgeExpressType:self.expressLabel.text];
            dict[@"remark"] = @"购物车";
            dict[@"goods"] = orderStr;
            //创建订单了
            
            PayOrderController * payOrder = [[PayOrderController alloc]init];
            payOrder.payDict = dict;
            payOrder.goodsInfoArray = self.goodsInfoArray;
            payOrder.addressDic = self.addressDic;
            [self.navigationController pushViewController:payOrder animated:YES];

            }else{
    NSString *dataString = @"";
    for (int i = 0; i<self.goodsArray.count; i++) {
        //取到每个商店的id
        ShopCarShopModel *shopModel = self.shopsArray[i];
        NSNumber *number = [NSNumber numberWithInteger:i];
        NSString *expressString = [self judgeExpressType:[self.expressDict objectForKey:number]];
        NSString *memoString = [self.memoDict objectForKey:number];

        ////拼接字符串
        NSString *gString = @"";
        NSArray *gArray = self.goodsArray[i];
        for (InitOrderModel *goodsModel in gArray) {
            
            gString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",goodsModel.goodsId,goodsModel.number,shopModel.supplier_id,goodsModel.colors,goodsModel.xinghao,expressString,memoString];
            
            if ([dataString isEqualToString:@""]) {
                dataString = [NSString stringWithFormat:@"%@",gString];
            }else
            {
                dataString = [NSString stringWithFormat:@"%@-%@",dataString,gString];
            }
        }
  
    }
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",nil];
            
        [userDict  setObject:self.morenAddressID forKey:@"shipping_address_id"];
        
            int  price = [self.model.goods_price intValue] * [self.goodsCount intValue];
        NSString * priceStr = [NSString stringWithFormat:@"%d",price];
        
        [userDict setObject:priceStr forKey:@"goods_amount"];
        [userDict setObject:priceStr forKey:@"order_amount"];
        [userDict setObject:@"1" forKey:@"pay_status"];
//支付状态 支付方式 需要修改
        [userDict setObject:@"1" forKey:@"pay_id"];
        
        NSString * methodStr = @"0";
        if ([self.expressLabel.text isEqualToString:@"送货上门"]) {
            methodStr = @"0";
        }
        if ([self.expressLabel.text isEqualToString:@"快递"]) {
            methodStr = @"1";
        }
        if ([self.expressLabel.text isEqualToString:@"自提"]) {
            methodStr = @"2";
        }
        
        
        [userDict setObject:methodStr forKey:@"method"];
        [userDict setObject:self.footView.textField.text forKey:@"remark"];
        NSString * string = [NSString stringWithFormat:@"%@-%@-%@-%@",self.dataStr,self.model.goods_id,self.goodsCount,priceStr];
        [userDict setObject:string forKey:@"goods"];
        
        if ([self.textFiledFoot.text isEqualToString:@""]) {
            self.textFiledFoot.text = @" ";}
            PayOrderController * payOrder = [[PayOrderController alloc]init];
                payOrder.payDict = userDict;
                    if (self.model) {
                        payOrder.model = self.model;
                        payOrder.goodsCount = self.goodsCount;
                    }else{
                        payOrder.goodsInfoArray = self.goodsInfoArray;
                        }

//                        payOrder.addressID = self.addressID;

                        payOrder.addressDic = self.addressDic;

                    [self.navigationController pushViewController:payOrder animated:YES];
    
  }
 }
}

#pragma mark - 送个货方式
- (void)loadShippingMethod
{
    
    
    [HttpRequestServers requestBaseUrl:Shipping_Method_Url withParams:nil withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",result);
        
        @try {
            if ([dict[@"status"] isEqualToString:Status_Success]) {
                
                for (NSDictionary *infoDict in dict[@"list"]) {
                    
                    ShipingMethodModel *model = [[ShipingMethodModel alloc] init];
                    model.spMethodID = infoDict[@"id"];
                    model.spMethodName = infoDict[@"name"];
                    //                HHNSLog(@"%@",model.spMethodName);
                    [self.shippingMethodArr addObject:model];
                }
                
            }else
            {
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    withFieldBlock:^{
        
        
        
    }];
    
}

//其次键盘的高度计算：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}


//传入的(NSDictionary *)userInfo用于存放键盘的各种信息，其中UIKeyboardFrameEndUserInfoKey对应的存放键盘的尺寸信息，以CGRect形式取出。

//最终返回的是键盘在当前视图中的高度。
//然后，根据键盘高度将当前视图向上滚动同样高度。
-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.mainTableView.frame;
    
    
    //先恢复原位 //可能这个方法重复调用
    currentFrame.origin.y = 0;
    self.mainTableView.frame = currentFrame;
    
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    
    //    CGFloat textViewH = self.view.frame.origin.y - CGRectGetMaxY(_introduceText.frame);
    

        currentFrame.origin.y = -change+50;
        self.mainTableView.frame = currentFrame;
        NSLog(@"%@",NSStringFromCGRect(currentFrame));
    
    
}
//最后，当键盘消失后，视图需要恢复原状。
-(void)keyboardWillDisappear:(NSNotification *)notification
{
    //恢复原位
    CGRect currentFrame = self.mainTableView.frame;
    currentFrame.origin.y = 0;
    self.mainTableView.frame = currentFrame;
    
}

#pragma mark - text代理方法
- (void)textFieldDidChange:(UITextField *)textField
{
    ///设置留言信息
    NSNumber *number = [NSNumber numberWithInteger:textField.tag];
    [self.memoDict setObject:textField.text forKey:number];
    
}

#pragma mark - 收货地址代理方法
- (void)setAddressWithConsignee:(NSString *)consignee andAddress:(NSString *)regionAreaAddress andTel:(NSString *)tel andAddress_id:(NSString *)address_id
{
    self.addressView.consigneeLabel.text = consignee;
    self.addressView.addressLabel.text = regionAreaAddress;
    self.addressView.phoneNumber.text = tel;
    
    //设置收货地址ID
    self.morenAddressID = address_id;
}

- (void)backleftViewController
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
