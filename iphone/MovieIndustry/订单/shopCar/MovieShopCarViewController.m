//
//  MovieShopCarViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieShopCarViewController.h"
#import "MovieShopCarGoodInfoCell.h"
#import "MovieEditShopGoodCell.h"
#import "MovieGoodsDetailViewController.h"
#import "ShopCarGoodsModel.h"
#import "ShopCarShopModel.h"
#import "ShopCarShopHeaderView.h"
#import "SearchShopResultController.h"
#import "MovieComfirmOrderViewController.h"
#import "ShippingAddressListController.h"
#import "MovieOrderDetailViewController.h"
#import "MovieComfirmOrderViewController.h"
#import "CartGoodsModel.h"
#import "CartGood.h"

#define CELL_TAG_START  100

@interface MovieShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,ShippingAddressDelegate>

@property (nonatomic,strong)UITableView *mainTableView;

//商品总价标签
@property (nonatomic,strong) UILabel *totalPrice;


//@property (nonatomic,retain) NSMutableDictionary *chooseDict;
//
//@property (nonatomic,retain) NSMutableDictionary *editDict;

///店铺信息
@property (nonatomic,strong) NSMutableArray *shopsArray;
///商品信息
@property (nonatomic,strong) NSMutableArray *goodsArray;
///总价
@property (nonatomic,assign) CGFloat allPrice;
///提交按钮 去付款 删除
@property (nonatomic,strong) UIButton *comfirmBtn;

@property (nonatomic,strong)NSString  * orderID;

@end

@implementation MovieShopCarViewController

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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：￥0.00"]];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    self.totalPrice.attributedText = priceStr;
    [self loadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"租物车"];
    [self setNavRightItem:@"编辑" rightAction:@selector(editShopingCarAction:)];
    
    self.allPrice = 0.0;
    [self createLoadingView];
    self.view.backgroundColor = kViewBackColor;
    
    [self createShopCarMainView];
    [self createBottomView];
}

- (void)createLoadingView
{
    UIImageView *loadingImage = [WNController createImageViewWithFrame:CGRectMake(0, 120-64, 130, 130) ImageName:@"loading"];
    [self.view addSubview:loadingImage];
    
    loadingImage.center = CGPointMake(kViewWidth/2, loadingImage.center.y);
    
    UILabel *loadigLabel = [WNController createLabelWithFrame:CGRectMake(0, 275-64, 143, 21) Font:18 Text:@"加载中 ..." textAligment:NSTextAlignmentCenter];
    loadigLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1];
    [self.view addSubview:loadigLabel];
    loadigLabel.center = CGPointMake(kViewWidth/2, loadigLabel.center.y);
    
}

#pragma mark - 编辑购物车，提供多项删除
- (void)editShopingCarAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        self.totalPrice.alpha = 0;
        [self.comfirmBtn setTitle:@"删除" forState:UIControlStateNormal];
        
    }else
    {
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        self.totalPrice.alpha = 1;
        [self.comfirmBtn setTitle:@"去付款" forState:UIControlStateNormal];
    }
    
    
    [self addTotalPrice];
    
    
}


#pragma mark - 下载数据
- (void)loadData
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [HttpRequestServers requestBaseUrl:TICart_CartGoodsList withParams:userDict withRequestFinishBlock:^(id result) {
        
        NSDictionary *dict = result;
        @try {
            if ([dict[@"code"] intValue] == 0) {
                HUD.labelText = @"加载完成";
                [HUD hide:YES];
                if (dict[@"data"] == [NSNull null]) {
                    [self.goodsArray removeAllObjects];
                    [self.shopsArray removeAllObjects];
                    [self.mainTableView reloadData];
                    
                }else
                {
                    [self.goodsArray removeAllObjects];
                    for (NSDictionary * dic in dict[@"data"]) {
                        
                        CartGoodsModel * goodsModel = [[CartGoodsModel alloc]initWithDict:dic];
                        [self.goodsArray addObject:goodsModel];
                    }
                    
                    NSLog(@"%@",self.goodsArray);
                    
                    [self.mainTableView reloadData];
                }
                
            }else
            {
                [HUD hide:YES];
            }
        }
        @catch (NSException *exception) {
            [HUD hide:YES];
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
    
}

- (void)createShopCarMainView
{
    //创建列表
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44-50) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //    UIColor *bgColor = RGBColor(234, 234, 234, 234);
    //    self.view.backgroundColor = bgColor;
    self.mainTableView.backgroundColor = kViewBackColor;
    [self.view addSubview:self.mainTableView];
    
    //    self.mainTableView.sectionHeaderHeight = 44;
    //    self.mainTableView.sectionFooterHeight = 10;
    
    
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
}




#pragma mark - 创建底部去付款视图
- (void)createBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight-44-50, kViewWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(kViewWidth-110, 0, 110, 50);
    comfirmBtn.backgroundColor = RGBColor(226,0,12,1);
    [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comfirmBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(comfirmPayMineShopcarGoods:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:comfirmBtn];
    ///
    self.comfirmBtn = comfirmBtn;
    
    
    self.totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kViewWidth/2, 30)];
    self.totalPrice.textAlignment = NSTextAlignmentRight;
    self.totalPrice.textColor = RGBColor(226,0,12,1);
    
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：￥0.00"]];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    self.totalPrice.attributedText = priceStr;
    
    [bottomView addSubview:self.totalPrice];
    //
    [self.view addSubview:bottomView];
}

- (void)CreateOrder{
    
    NSMutableString * orderStr = [NSMutableString string];
    int orderMoney = 0;
    for (CartGoodsModel * model in self.goodsArray) {
        NSArray * shop_goodsArray = model.shop_goods;
        for (CartGood *modelGood in shop_goodsArray) {
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
        
    }
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"user_id"] = APP_DELEGATE.user_id;
        dict[@"shipping_address_id"] = APP_DELEGATE.addressPalce;
        dict[@"goods_amount"] = [NSString stringWithFormat:@"%d",orderMoney];
        dict[@"order_amount"] = [NSString stringWithFormat:@"%d",orderMoney];
        dict[@"pay_status"] = @"1";
        dict[@"pay_id"] = @"1";
        dict[@"method"] = @"1";
        dict[@"remark"] = @"购物车";
        dict[@"goods"] = orderStr;
        //创建订单了
        [HttpRequestServers requestBaseUrl:TIOrder_AddOrder withParams:dict withRequestFinishBlock:^(id result) {
            NSLog(@"%@",result);
        } withFieldBlock:^{
            
        }];
    
}

#pragma mark - 点击去付款按钮
- (void)comfirmPayMineShopcarGoods:(UIButton *)button
{
    NSLog(@"点击去付款按钮");
    
    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"去付款"]) {
        NSMutableString * orderStr = [NSMutableString string];
        int orderMoney = 0;
        
        
        NSMutableArray * goodsModelArray = [NSMutableArray array];
         static  NSString * cat_id;
        for (CartGoodsModel * model in self.goodsArray) {
            NSArray * shop_goodsArray = model.shop_goods;
            
            for (CartGood *modelGood in shop_goodsArray) {
                if (modelGood.selectState) {
                    
                    if (cat_id == nil) {
                        cat_id = modelGood.shop_id;
                    }
                    
                    if (![modelGood.shop_id isEqualToString:cat_id]) {
                        
                        [DeliveryUtility showMessage:@"请不要同时交易多家店铺" target:nil];
                        cat_id = nil;
                        [goodsModelArray removeAllObjects];
                        return;
                    }
                    [goodsModelArray addObject:modelGood];
                    [orderStr appendString:modelGood.cat_id];
                    [orderStr appendString:@"-"];
                    [orderStr appendString:modelGood.goods_id];
                    [orderStr appendString:@"-"];
                    [orderStr appendString:modelGood.goods_number];
                    [orderStr appendString:@"-"];
                    [orderStr appendString:modelGood.goods_price];
                    [orderStr appendString:@""];
                        orderMoney += ([modelGood.goods_price intValue]+[modelGood.goods_deposit intValue]) * [modelGood.goods_number intValue];}
            }
                
            }
           
        
        
        if (orderStr.length == 0) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"您还没有选择商品哦"];
             [DeliveryUtility showMessage:@"你还没有选择商品哦" target:nil];
        }else{
   
        MovieComfirmOrderViewController * detail = [[MovieComfirmOrderViewController alloc]init];
//                detail.order_id = result[@"data"];
            detail.goodsInfoArray = goodsModelArray;
            cat_id = nil;
        [self.navigationController pushViewController:detail animated:YES];

        }
    }else
    {
        ///掉删除接口
        NSString *deleteGwcId = @"";
        
        for (CartGoodsModel * model1 in self.goodsArray) {
            
            NSArray * shop_goodsArray = model1.shop_goods;
            
            for (CartGood *model in shop_goodsArray) {
                if (model.selectState) {
                    
                    if ([deleteGwcId isEqualToString:@""]) {
                        //商品ID，商品数量，商品颜色，商品型号
                        deleteGwcId = [NSString stringWithFormat:@"%@",model.cat_id];
                    }else
                    {
                        //商品ID，商品数量，商品颜色，商品型号
                        deleteGwcId = [NSString stringWithFormat:@"%@,%@",deleteGwcId,model.cat_id];
                    }
                }
            }
            
        }
        
        ///删除多个商品
        if ([deleteGwcId isEqual:@""]) {
//        [PromptLabel custemAlertPromAddView:self.view text:@"您还没有选择商品哦"];
             [DeliveryUtility showMessage:@"您还没有选择商品哦" target:nil];
        }else{
        [self DeleteShopingCarGwc_id:deleteGwcId];
        }
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.goodsArray.count;
    //    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CartGoodsModel * model = self.goodsArray[section];
    NSArray * goodsArr = model.shop_goods;
    return goodsArr.count;
    
}

#pragma mark - tableView头部的View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ShopCarShopHeaderView *tbHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ShopCarShopHeaderView" owner:self options:nil] lastObject];
    tbHeaderView.chooseBtn.tag = section;
    ///添加选择点击事件
    [tbHeaderView.chooseBtn addTarget:self action:@selector(chooseStoreGoodsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CartGoodsModel *model = self.goodsArray[section];
    [tbHeaderView config:model];
    
    tbHeaderView.enterShopButton.tag = 100+section;
    [tbHeaderView.enterShopButton addTarget:self action:@selector(enterShopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return tbHeaderView;
}

#pragma mark - 点击进入店铺
- (void)enterShopButtonAction:(UIButton *)btn
{
    CartGoodsModel * goodsModel = self.goodsArray[btn.tag -100];
    
    SearchShopResultController *shopVc = [[SearchShopResultController alloc] init];
    shopVc.shopId = goodsModel.shop_id;
    [shopVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:shopVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *goodsCellID = @"goodCellIdentifier";
    //默认情况下
    MovieShopCarGoodInfoCell *goodCell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
    if (goodCell == nil) {
        goodCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieShopCarGoodInfoCell" owner:self options:nil] lastObject];
    }
    
    goodCell.chooseBtn.superview.tag = indexPath.section;
    goodCell.chooseBtn.tag = indexPath.row;
    ///选中当前的行
    [goodCell.chooseBtn addTarget:self action:@selector(chooseCurrentSingleGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    ////设置数据
    CartGoodsModel * cartModel = self.goodsArray[indexPath.section];
    NSArray * goodsArr = cartModel.shop_goods;
    CartGood *model = goodsArr[indexPath.row];
    
    ///如果第一行和最后一行不显示分割线
    if (indexPath.row+1==goodsArr.count) {
        
    }else
    {
        UIView *lineView = [WNController createViewFrame:CGRectMake(0, 100, kViewWidth, 2)];
        [goodCell.contentView addSubview:lineView];
    }
    goodCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [goodCell config:model];
    
    return goodCell;
}

#pragma mark - 每一行按钮的点击事件
- (void)chooseCurrentSingleGoods:(UIButton *)btn
{
    
    NSInteger sectionIndex = btn.superview.tag;
    ////设置数据
    CartGoodsModel * goodsModel = self.goodsArray[sectionIndex];
    NSArray * goodsArr = goodsModel.shop_goods;
    CartGood *model = goodsArr[btn.tag];
    HHNSLog(@"celltag--->%ldbtntag--->%ld",sectionIndex,btn.tag);
    
    if (model.selectState) {
        model.selectState = NO;
        
    }else
    {
        model.selectState = YES;
    }
    
    //要判断这个店铺里面的商品是否全部选中 或者全部不选中
    NSInteger selelct = 0;
    NSInteger noSelect = 0;
    for (CartGood *goodmodel in goodsArr) {
        //如果
        if (goodmodel.selectState) {
            selelct++;
        }else
        {
            noSelect++;
        }
    }
    
    CartGoodsModel *shopModel = self.goodsArray[sectionIndex];
    ///判断如果全部为选中状态则该分组选中  如果全部不是选中状态 店铺取消选中
    if (selelct == goodsArr.count) {
        shopModel.selectState = YES;
    }
    if (noSelect >0) {
        shopModel.selectState = NO;
    }
    
    ///刷新这个分组列表
    [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    ///计算总价格
    [self addTotalPrice];
}

#pragma mark - 选择店铺里面的商品
- (void)chooseStoreGoodsAction:(UIButton *)btn
{
    CartGoodsModel *model = self.goodsArray[btn.tag];
    
    if (model.selectState) {
        model.selectState = NO;
        //设置这个店铺的所所有商品为选中状态
        NSArray *shopGoodsArray = model.shop_goods;
        for (CartGood *goodmodel in shopGoodsArray) {
            goodmodel.selectState = NO;
        }
        
    }else
    {
        model.selectState = YES;
        //设置这个店铺的所所有商品为选中状态
        NSArray *shopGoodsArray = model.shop_goods;
        for (ShopCarGoodsModel *goodmodel in shopGoodsArray) {
            goodmodel.selectState = YES;
        }
    }
    
    
    
    ///刷新分组
    [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    //计算总价
    [self addTotalPrice];
}


#pragma mark - UITableViewDelegate
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
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///为了设置自定义分割线 高度需要变化
    CartGoodsModel * model = self.goodsArray[indexPath.section];
    
    NSArray * goodsArr = model.shop_goods;
    
    if (indexPath.row+1==goodsArr.count) {
        return 100;
    }else{
        return 102;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartGoodsModel * model = self.goodsArray[indexPath.section];
    CartGood *goodsModel = model.shop_goods[indexPath.row];
    MovieGoodsDetailViewController *goodsInfo = [[MovieGoodsDetailViewController alloc] init];
    goodsInfo.goodsId= goodsModel.goods_id;
    goodsInfo.shopID = goodsModel.shop_id;
    
    [self.navigationController pushViewController:goodsInfo animated:YES];
}

#pragma mark - 滑动删除效果
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 调用删除接口
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartGoodsModel * model = self.goodsArray[indexPath.section];
    CartGood *goodsModel = model.shop_goods[indexPath.row];
    
    [self DeleteShopingCarGwc_id:goodsModel.cat_id];
    
    self.mainTableView.editing = NO;
}

#pragma mark - 修改删除的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark -- 计算价格
-(void)addTotalPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    
    for (int i= 0; i<self.goodsArray.count; i++) {
        
        CartGoodsModel * model = self.goodsArray[i];
        NSArray *array = model.shop_goods;
        for (CartGood *model in array) {
            
            if (model.selectState) {
                int number = [model.goods_number intValue];
                CGFloat price = [model.goods_price floatValue];
                self.allPrice = self.allPrice+number*(price + [model.goods_deposit floatValue]);
            }
            
        }
    }
    //给总价文本赋值
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：￥%.2f",self.allPrice]];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    self.totalPrice.attributedText = priceStr;
    
    //每次算完要重置为0，因为每次的都是全部循环算一遍
    self.allPrice = 0.0;
}

- (void)DeleteShopingCarGwc_id:(NSString *)gwc_id
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:gwc_id,@"cat_id",APP_DELEGATE.user_id,@"user_id", nil];
    HHNSLog(@"------- %@dict%@",DeleteGoodsCars_URL,userDict);
    
    [HttpRequestServers requestBaseUrl:TICart_DeleteCartGoods withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"------- %@dict%@",DeleteGoodsCars_URL,dict);
        if ([dict[@"code"] intValue] == 0) {
            
            ///重新加载数据
            [self loadData];
            
            //计算总价
            [self addTotalPrice];
        }
        
        //        [PromptLabel custemAlertPromAddView:self.view  text:dict[@"msg"]];
        
    } withFieldBlock:^{
        
        
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
