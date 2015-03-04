//
//  GoodsManagerController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "GoodsManagerController.h"
#import "MovieGoodsManageCell.h"
#import "MovieManagerGoodsModel.h"
#import "MovieGoodsInfoViewController.h"
#import "CartGood.h"
#import "PublishProductController.h"
#import "PublishPersonnelController.h"
#import "SiteViewController.h"
#import "MovieGoodsDetailViewController.h"

#define BTN_START_TAG 200

@interface GoodsManagerController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,retain) UITableView *mainTableView;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,assign) NSInteger chooseIndex;
@property (nonatomic,strong) UIView *segmentView;

@property (nonatomic,assign) int allPage;
@property (nonatomic,assign) int rentPage;
@property (nonatomic,copy) NSString *keyword;

@property (nonatomic,strong) NSMutableArray *allGoodsArray;
@property (nonatomic,strong) NSMutableArray *rentGoodsArray;
//用来标记index值  网络请求用到
@property (nonatomic,assign)int currentIndex;

@end

@implementation GoodsManagerController

- (NSMutableArray *)allGoodsArray
{
    if (nil == _allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
    }
    return _allGoodsArray;
}

- (NSMutableArray *)rentGoodsArray
{
    if (nil == _rentGoodsArray) {
        _rentGoodsArray = [NSMutableArray new];
    }
    return _rentGoodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    _allPage = 1;
    _rentPage = 1;
    self.keyword = @"";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReloadDataNew) name:@"商品修改" object:nil];
    [self setNavTabBar:@"商品管理"];
    [self createGoodManangeView];
    [self setupTableViewRefresh];
//    [self requestMineAllManagerGoods];
}


- (void)ReloadDataNew{
    
    _allPage = 0;
    [self.allGoodsArray removeAllObjects];
    _currentIndex = 0;
    [self requestMineAllManagerGoods];
    
}


#pragma mark - 创建UI视图
- (void)createGoodManangeView
{
    //文本框的圆角背景View
    UIView *textView = [WNController createViewFrame:CGRectMake(10, 10, kViewWidth-20, 36)];
    textView.layer.cornerRadius = 16;
    textView.clipsToBounds = YES;
    [self.view addSubview:textView];
    
    self.textField = [WNController createTextFieldWithFrame:CGRectMake(10, 0, kViewWidth-70, 36) boreStyle:UITextBorderStyleNone font:15];
    self.textField.backgroundColor = [UIColor whiteColor];
//    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.returnKeyType = UIReturnKeySearch;
    //添加监听变化
    [self.textField addTarget:self action:@selector(textFieldSearchDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.delegate = self;
    self.textField.placeholder = @"请输入关键字";
    [textView addSubview:self.textField];
    
    UIButton *seacheBtn = [DeliveryUtility createBtnFrame:CGRectMake(kViewWidth-55, 5,26,26)  image:@"search_index" selectedImage:nil target:self action:@selector(searchMineKeywordGoods)];
    [textView addSubview:seacheBtn];
    
    self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(textView.frame) + 10,kViewWidth,45)];
    self.segmentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = kViewWidth/2;
    CGFloat btnHeight = 44;
    
    //底部下滑红线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(45, (btnHeight-2), (btnWidth-90), 2)];
    line.tag = 200;
    line.backgroundColor = [UIColor redColor];
    [self.segmentView addSubview:line];
    
    NSArray *titleArray = @[@"全部商品",@"已出租"];
    
    for (int i = 0; i<titleArray.count; i++) {
        
        CGRect btnFrame = CGRectMake(i*btnWidth, 0, btnWidth, btnHeight);
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentBtn setFrame:btnFrame];
        segmentBtn.tag = BTN_START_TAG + i;
        segmentBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [segmentBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [segmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segmentBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [segmentBtn addTarget:self action:@selector(changeGoodsScreenCondiction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            self.selectedBtn = segmentBtn;
            self.chooseIndex = self.selectedBtn.tag - BTN_START_TAG;
        }
        
        [self.segmentView addSubview:segmentBtn];
    }
    
    [self.view addSubview:self.segmentView];
    
    [self createTableViews];
}

/** 搜索关键字商品 */
- (void)searchMineKeywordGoods
{
    self.keyword = [self.textField.text asTrim];
    [self.textField resignFirstResponder];
    
    if (0 == _chooseIndex) {
        
        _allPage = 1;
        [self requestMineAllManagerGoods];
    }
    else
    {
        _rentPage = 1;
        [self requestMineAleardyRentGoods];
    }
}

#pragma mark - 请求全部商品数据
- (void)requestMineAllManagerGoods
{
    _currentIndex ++;
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"page"] = [NSString stringWithFormat:@"%d",_currentIndex];
    [HttpRequestServers requestBaseUrl:TIShopGoods_GoodsList withParams:dict withRequestFinishBlock:^(id result) {

#warning 这边返回后 需要修改 allgoodsarray的数据
#warning 
#warning 

        HUD.labelText = @"加载成功";
        [HUD hide:YES];
        NSDictionary * dict = result;
        if ([dict[@"code"] intValue] == 0) {
            id dicts = dict[@"data"];
            if ([[dicts class] isSubclassOfClass:[NSArray class]]) {
                NSArray * array = dicts;
                for (int i = 0; i < array.count; i ++) {
                    CartGood * good = [[CartGood alloc]initWithDict:array[i]];
                    [self.allGoodsArray addObject:good];
                }
                [self.mainTableView.header endRefreshing];
                [self.mainTableView.footer endRefreshing];
                [self.mainTableView reloadData];
            }else{
                [self.mainTableView.header endRefreshing];
                [self.mainTableView.footer endRefreshing];
            }
        }
    } withFieldBlock:^{
        HUD.labelText = @"加载失败";
        [HUD hide:YES];
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
    }];
}

- (void)warningStoreAllGoodsStatue
{
    if (1 == _allPage) {
        if ([self.keyword isEqualToString:@""]) {
            [DeliveryUtility showMessage:@"您的店铺还没有任何商品哦~" target:self];
        }
        else
        {
            [DeliveryUtility showMessage:@"您的店铺没有相关商品哦~" target:self];
        }
    }
    else{
        
        if ([self.keyword isEqualToString:@""]) {
            [DeliveryUtility showMessage:@"没有更多商品了哦~" target:self];
        }
        else
        {
            [DeliveryUtility showMessage:@"没有更多相关商品了哦~" target:self];
        }
    }
}

#pragma mark - 请求已租用商品
- (void)requestMineAleardyRentGoods
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"page"] = [NSString stringWithFormat:@"%d",_rentPage];
    [HttpRequestServers requestBaseUrl:TIShopGoods_BorrowGoods withParams:dict withRequestFinishBlock:^(id result) {
        HUD.labelText = @"加载成功！";
        [HUD hide:YES];
        
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
        
        if (_rentPage == 1) {
            [self.rentGoodsArray removeAllObjects];
        }
        if ([[result[@"data"] class] isSubclassOfClass:[NSArray class]]) {
            NSArray * array = result[@"data"];
            for (int i = 0; i < array.count; i ++) {
                CartGood * cart = [[CartGood alloc]initWithDict:array[i]];
                [self.rentGoodsArray addObject:cart];
            }
        }
        [self.mainTableView reloadData];
    } withFieldBlock:^{
        HUD.labelText = @"加载失败！";
        [HUD hide:YES];
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
    }];
}

/** 判断已租用商品数据 */
- (void)warningStoreRentedGoodsStatue
{
    if (1 == _rentPage) {
        if ([self.keyword isEqualToString:@""]) {
            [DeliveryUtility showMessage:@"您的店铺还没有已租用的商品哦~" target:self];
        }
        else
        {
            [DeliveryUtility showMessage:@"您的店铺没有相关已租用的商品哦~" target:self];
        }
    }
    else{
        
        if ([self.keyword isEqualToString:@""]) {
            [DeliveryUtility showMessage:@"没有更多已租用的商品了哦~" target:self];
        }
        else
        {
            [DeliveryUtility showMessage:@"没有更多相关已租用的商品了哦~" target:self];
        }
    }
}


#pragma mark -- 创建表格视图
- (void)createTableViews
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.segmentView.frame)+1, kViewWidth,kViewHeight-44-98) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}


#pragma mark - 切换全部/已租条件
- (void)changeGoodsScreenCondiction:(UIButton *)btn
{
    [self keyBoardDown];
    
    self.chooseIndex = btn.tag - BTN_START_TAG;
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    if (0 == _chooseIndex) {
        _allPage = 1;
//        [self.mainTableView.header beginRefreshing];
        [self requestMineAllManagerGoods];
    }
    else{
        _rentPage = 1;
       // [self.mainTableView.header beginRefreshing];
        [self requestMineAleardyRentGoods];
    }
    
    UIView *line = (UIView *)[btn.superview viewWithTag:200];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect lineFrame = line.frame;
        lineFrame.origin.x = (kViewWidth/2)*_chooseIndex + 45;
        line.frame = lineFrame;
    }];
    
    [self.mainTableView reloadData];
}


#pragma mark - 回收键盘
- (void)keyBoardDown
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
    [self.textField resignFirstResponder];
}

#pragma mark - 确认归还接口
- (void)requestComfirmReturnMyGoods:(NSString *)itemId AndOrderID:(NSString *)order_id
{
    [MovieHttpRequest createGoodManagerConfirmReturenWithTradeId:itemId AndOrderID:order_id CallBack:^(id obj) {
        [self.mainTableView.header beginRefreshing];
    } andSCallBack:^(id obj) {
        
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.chooseIndex) {
        case 0: //全部商品
            return self.allGoodsArray.count;
            break;
        case 1: //已出租
            return self.rentGoodsArray.count;
            break;
        default:
            return 0;
        break;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIdentifier";
    MovieGoodsManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieGoodsManageCell" owner:self options:nil] lastObject];
    }
    
    cell.rightBtn.tag = indexPath.section;
    [self checkoutListStatue:cell];

    if (0 == _chooseIndex) {
    CartGood * good = _allGoodsArray[indexPath.row];
        cell.goodsName.text = good.goods_name;
#warning 缺少送货方式
#warning 缺少送货方式
#warning 缺少送货方式字段
       // cell.deliveryWay
        cell.price.text = [NSString stringWithFormat:@"￥%@",good.goods_price];
        cell.address.text = good.local_name;
        cell.typeLabel.hidden = YES;
        if ([good.type isEqual:@"0"]) {
            if ([good.goods_express isEqual:@"0"]) {
                cell.deliveryWay.text = @"商家送货";
            }
            if ([good.goods_express isEqual:@"1"]) {
                cell.deliveryWay.text = @"顺丰快递";
            }
            if ([good.goods_express isEqual:@"2"]) {
                cell.deliveryWay.text = @"圆通快递";
            }
        }
        if ([good.type isEqual:@"1"]) {
            cell.deliveryWay.text = @"人员";
        }
        if ([good.type isEqualToString:@"2"]) {
            cell.deliveryWay.text = @"场地";
        }
        
//        cell.deliveryWay.text =
//        [cell.goodsImg sd_setImageWithURL:[NSURL URLWithString:good.img_path]];
        [cell.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,good.img_path]]];
        cell.address.text = good.spare_address;
        cell.rightBtn.hidden = NO;
        cell.rightBtn.tag = 666 + indexPath.row;
        [cell.rightBtn addTarget:self action:@selector(ChangeGoodsDes:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        if (1 == _chooseIndex) {
            CartGood * good = _rentGoodsArray[indexPath.row];
            cell.goodsName.text = good.goods_name;
#warning 缺少送货方式
#warning 缺少送货方式
#warning 缺少送货方式字段
            // cell.deliveryWay
            cell.price.text = [NSString stringWithFormat:@"￥%@",good.goods_price];
            cell.address.text = good.local_name;
            cell.typeLabel.hidden = YES;
            if ([good.type isEqual:@"0"]) {
                if ([good.goods_express isEqual:@"0"]) {
                    cell.deliveryWay.text = @"商家送货";
                }
                if ([good.goods_express isEqual:@"1"]) {
                    cell.deliveryWay.text = @"顺丰快递";
                }
                if ([good.goods_express isEqual:@"2"]) {
                    cell.deliveryWay.text = @"圆通快递";
                }
            }
            if ([good.type isEqual:@"1"]) {
                cell.deliveryWay.text = @"人员";
            }
            if ([good.type isEqualToString:@"2"]) {
                cell.deliveryWay.text = @"场地";
            }
            
            //        cell.deliveryWay.text =
            //        [cell.goodsImg sd_setImageWithURL:[NSURL URLWithString:good.img_path]];
            [cell.goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,good.img_path]]];
            cell.address.text = good.spare_address;
            cell.rightBtn.hidden = NO;
    }
    }
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    [self ReloadDataNew];
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
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
/**
 *  修改商品
 *
 *  @param sender 按钮对象
 */
- (void)ChangeGoodsDes:(UIButton *)sender{
   CartGood * model =_allGoodsArray[sender.tag - 666];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];

    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"goods_id"] = model.goods_id;
    
    [HttpRequestServers requestBaseUrl:TIGoods_Details withParams:dict withRequestFinishBlock:^(id result) {
        NSDictionary * dict1 = result[@"data"];
        NSMutableDictionary * dict2 = [NSMutableDictionary dictionaryWithDictionary:dict1];
        if (!dict2[@"local_name"]) {
            dict2[@"local_name"] = @"";
        }
        
        GoodDesModel * model = [[GoodDesModel alloc]initWithDict:dict2];
        if([model.type isEqualToString:@"0"]){
            PublishProductController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"publishProduct"];
            tradingVc.desModel = model;
            [self.navigationController pushViewController:tradingVc animated:YES];}
        if([model.type isEqualToString:@"1"]){
            PublishPersonnelController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"issuePerson"];
            tradingVc.desModel = model;
            [self.navigationController pushViewController:tradingVc animated:YES];}
        if([model.type isEqualToString:@"2"]){
            SiteViewController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"issueGround"];
            tradingVc.desModel = model;
            [self.navigationController pushViewController:tradingVc animated:YES];}
        
        
    } withFieldBlock:^{

    }];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        MovieGoodsDetailViewController *goodsInfo = [[MovieGoodsDetailViewController alloc] init];
    
    switch (self.chooseIndex) {
        case 0:{
            CartGood *goodsModel = self.allGoodsArray[indexPath.row];
            goodsInfo.goodsId= goodsModel.goods_id;
            goodsInfo.shopID = goodsModel.shop_id;}
            break;
        case 1:{
            CartGood *goodsModel = self.rentGoodsArray[indexPath.row];
            goodsInfo.goodsId= goodsModel.goods_id;
            goodsInfo.shopID = goodsModel.shop_id;}
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:goodsInfo animated:YES];
}


#pragma mark - 根据列表状态给button添加不同点击事件
- (void)checkoutListStatue:(MovieGoodsManageCell *)cell
{
    if (0 == _chooseIndex) {
        
        //全部商品 修改金额
//        [cell.rightBtn setTitle:@"修改金额" forState:UIControlStateNormal];
//        [cell.rightBtn addTarget:self action:@selector(modifyGoodsPriceAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.rightBtn.hidden = YES;
    }
    else
    {
        cell.rightBtn.hidden = NO;
        
        //已出租的商品 确认归还
        [cell.rightBtn setTitle:@"确认归还" forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(confirmAlreadyReturnGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - 修改商品金额
- (void)modifyGoodsPriceAction:(UIButton *)button
{
    NSInteger index = button.tag;
    
    NSLog(@"修改商品的金额 --> %zd",index);
}

#pragma mark - 确认归还商品
- (void)confirmAlreadyReturnGoods:(UIButton *)button
{
    NSInteger index = button.tag;
    
    int currentIndex = (int)index;
      CartGood * good = _rentGoodsArray[currentIndex];
    [self requestComfirmReturnMyGoods:good.goods_id AndOrderID:good.order_id];
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchMineKeywordGoods];
    return YES;
}

- (void)textFieldSearchDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        
        [self searchMineKeywordGoods];
    }
}
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//{
//    return YES;
//}


#pragma mark - 添加头尾刷新
- (void)setupTableViewRefresh
{
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (0 == _chooseIndex) {
            
            //全部商品
            _allPage = 1;
            [self requestMineAllManagerGoods];
        }
        else
        {
            _rentPage = 1;
            [self requestMineAleardyRentGoods];
        }
    }];
    
//    [self.mainTableView.header beginRefreshing];
    
    self.mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (0 == _chooseIndex) {
            
            //全部商品
            _allPage++;
            [self requestMineAllManagerGoods];
        }
        else
        {
            _rentPage++;
            [self requestMineAleardyRentGoods];
        }
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
