//
//  MyCollectionController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyCollectionController.h"

#import "CollectCourseCell.h"
#import "CollectPostCell.h"
#import "MovieMineCollectGoodsModel.h"
#import "MovieCollectStoreModel.h"
#import "ConllectShopModel.h"
#import "CollectGoodsModel.h"
#import "MovieGoodsInfoViewController.h"
#import "SearchShopResultController.h"
#import "GoodCollectionInfo.h"
#import "CollectGoodsCell1.h"
#import "CollectShopCell1.h"
#import "ShopGoodsCell.h"


#define BTN_START_TAG  300

@interface MyCollectionController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_selectedBtn;
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表商品 1 代表商家 2 代表课程 3 代表fatie
    NSString *_btnType;
}

//分组展开与收起
@property (nonatomic,strong) NSMutableDictionary *showListDict;

/** 商品收藏数据 */
@property (nonatomic,strong) NSMutableArray *goodsArray;

/** 商店收藏数据 */
@property (nonatomic,strong) NSMutableArray *storeArray;


@property (nonatomic,assign) int goodPage;
@property (nonatomic,assign) int storePage;

@end

@implementation MyCollectionController

- (NSMutableDictionary *)showListDict
{
    if (!_showListDict) {
        _showListDict = [NSMutableDictionary dictionary];
    }
    return _showListDict;
}

- (NSMutableArray *)goodsArray
{
    if (nil == _goodsArray) {
        _goodsArray = [NSMutableArray new];
    }
    return _goodsArray;
}

- (NSMutableArray *)storeArray
{
    if (nil == _storeArray) {
        _storeArray = [NSMutableArray new];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"我的收藏"];
    
    _btnType = @"0";
    _goodPage = 1;
    _storePage = 1;
    
    //    [self.showListDict removeAllObjects];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    [self setRefreshTableView];
    //    [self requestMyCollectGoodsData];
}

- (void)createUI
{
    //    NSArray *titleArray = @[@"商品",@"商家",@"课程",@"帖子"];
    NSArray * titleArray = @[@"商品",@"商家"];
    CGFloat segmentW = kViewWidth/(titleArray.count);
    
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 50)];
    [self.view addSubview:btnView];
    
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(10,48,segmentW-20,2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton *segementBtn = [WNController createButtonWithFrame:CGRectMake(segmentW*i, 0, segmentW, 50) ImageName:@"" Target:self Action:@selector(segementButtonClicked:) Title:titleArray[i] fontSize:16];
        segementBtn.tag = BTN_START_TAG + i;
        if (0 == i) {
            _selectedBtn = segementBtn;
        }
        [btnView addSubview:segementBtn];
    }
    
    [self createTableView];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0,60, kViewWidth, kViewHeight-60-44) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    [self.view addSubview:_tbView];
}

#pragma mark - 切换商品收藏/店铺收藏选项
- (void)segementButtonClicked:(UIButton *)button
{
    [self.goodsArray removeAllObjects];
    [self.storeArray removeAllObjects];
    [_tbView reloadData];
    
    NSInteger index = button.tag - BTN_START_TAG;
    switch (index) {
        case 0: //商品
        {
            _btnType = @"0";
            [_tbView.header beginRefreshing];
        }
            break;
        case 1: //商家
        {
            _btnType = @"1";
            [_tbView.header beginRefreshing];
        }
            break;
        default:
            break;
    }
    
    CGFloat buttonW = kViewWidth/2;
    
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = button;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = CGRectMake(10+index*buttonW, 48, buttonW-20, 2);
    }];
    [_tbView reloadData];
}

#pragma mark - 请求我收藏的商品数据
- (void)requestMyCollectGoodsData
{
    [MovieHttpRequest createMineCollectGoodsWithPage:_goodPage CallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
        NSArray *resultArray = [NSArray arrayWithArray:obj];
        [self analyseGoodsRequestResult:resultArray];
        
    } andSCallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
        
    }];
}

- (void)analyseGoodsRequestResult:(NSArray *)array
{
    if (1 == _goodPage)
    {
        self.goodsArray = [NSMutableArray arrayWithArray:array];
        if (0 == array.count) {
            [DeliveryUtility showMessage:@"您没有收藏任何商品哦~" target:self];
        }
    }
    else
    {
        [self.goodsArray addObjectsFromArray:array];
        //        if (0 == array.count) {
        //            [DeliveryUtility showMessage:@"没有更多收藏的商品了~" target:self];
        //        }
    }
    
    [_tbView reloadData];
}


#pragma mark - 请求我收藏的店铺数据
- (void)requestMyCollectStoreData
{
    [MovieHttpRequest createMineCollectStoreWithPage:_storePage CallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
        NSArray *resultArray = (NSArray *)obj;
        [self analyseStoreRequestResult:resultArray];
        
    } andSCallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


- (void)analyseStoreRequestResult:(NSArray *)array
{
    if (1 == _storePage)
    {
        self.storeArray = [NSMutableArray arrayWithArray:array];
        
        if (0 == array.count) {
            [DeliveryUtility showMessage:@"您没有收藏任何店铺哦~" target:self];
        }
    }
    else
    {
        [self.storeArray addObjectsFromArray:array];
        //        if (0 == array.count) {
        //            [DeliveryUtility showMessage:@"没有更多收藏的店铺了~" target:self];
        //        }
    }
    
    [_tbView reloadData];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_btnType isEqualToString:@"0"]) {
        return self.goodsArray.count;
    }else{
        return self.storeArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_btnType isEqualToString:@"2"]) {
        NSString *keyValue = [self.showListDict objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section+1]];
        if (keyValue) {
            return 0;
        }else
            return 125;
    }
    
    if ([_btnType isEqualToString:@"1"]) {
        return 139;
    }
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"0"]) {
        static NSString *cellID = @"goodsCellID";
        ShopGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopGoodsCell" owner:nil options:nil] lastObject];
        }
        
        CollectGoodsModel  *model = self.goodsArray[indexPath.row];
//        [cell config:model];
        [cell configD:model];
      return cell;
        
    }else if ([_btnType isEqualToString:@"1"])
    {
        //店铺收藏
        static NSString *cellID = @"CollectShopCellID";
        CollectShopCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectShopCell1" owner:self options:nil]lastObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ConllectShopModel *model = self.storeArray[indexPath.row];
        cell.connectBtn.layer.borderWidth=1;
        cell.connectBtn.layer.borderColor = RGBColor(234,234, 234, 1).CGColor;
        cell.connectBtn.layer.cornerRadius = 5;
        cell.connectBtn.tag = 3333 + indexPath.row;
        [cell.connectBtn addTarget:self action:@selector(MessageShoper:) forControlEvents:UIControlEventTouchUpInside];
        [cell config:model];
        return cell;
        
    }else if ([_btnType isEqualToString:@"2"])
    {
        static NSString *cellID = @"CollectCourseCellID";
        CollectCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectCourseCell" owner:self options:nil]lastObject];
        }
        cell.statusLbl.hidden = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([_btnType isEqualToString:@"3"])
    {
        static NSString *cellID = @"CollectPostCellID";
        CollectPostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectPostCell" owner:self options:nil]lastObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
    
}

- (void)MessageShoper:(UIButton *)sender{
    int index = (int)sender.tag - 3333;
    if ([_btnType isEqualToString:@"0"]) {
        CollectGoodsModel *model = self.goodsArray[index];
        NSString * urlStr = [NSString stringWithFormat:@"tel://%@",model.shop_tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        
    }
    if ([_btnType isEqualToString:@"1"]) {
        ConllectShopModel *model = self.storeArray[index];
        NSString * urlStr = [NSString stringWithFormat:@"tel://%@",model.shop_tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    
    
    
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([_btnType isEqualToString:@"0"]) {
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0,130,0, 0)];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
            [cell setSeparatorInset:UIEdgeInsetsMake(0,130,0, 0)];
        }
    }
    else
    {
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (![_btnType isEqualToString:@"3"]) {
        return nil;
    }
    UIView *view = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 40)];
    UILabel *label = [WNController createLabelWithFrame:CGRectMake(5, 9, 180, 21) Font:15 Text:@"我的教程" textAligment:NSTextAlignmentLeft];
    label.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1];
    [view addSubview:label];
    //        view.userInteractionEnabled = YES;
    UIImageView *arrow = [WNController createImageViewWithFrame:CGRectMake(kViewWidth-18-6, 12, 18, 18) ImageName:@"down_arrow.png"];
    [view addSubview:arrow];
    
    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(kViewWidth-40, 0, 40, 40) ImageName:@"" Target:self Action:@selector(showListAction:) Title:@""];
    btn.tag = section;
    [view addSubview:btn];
    
    UIView *line = [WNController createViewFrame:CGRectMake(0, 39, kViewWidth, 1)];
    line.backgroundColor = kViewBackColor;
    [view addSubview:line];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"0"]) {
        
        //点击商品收藏
        CollectGoodsModel *goodModel = _goodsArray[indexPath.row];
        
        MovieGoodsInfoViewController *goodInfoVC = [[MovieGoodsInfoViewController alloc] init];
        goodInfoVC.shopID = goodModel.shop_id;
        goodInfoVC.goodsId = goodModel.goods_id;
        [self.navigationController pushViewController:goodInfoVC animated:YES];
    }
    else if ([_btnType isEqualToString:@"1"]){
        
        //点击商家收藏
        ConllectShopModel *storeModel = _storeArray[indexPath.row];
        
        SearchShopResultController *shopInfoVC = [[SearchShopResultController alloc] init];
        shopInfoVC.shopId = storeModel.shop_id;
        [self.navigationController pushViewController:shopInfoVC animated:YES];
    }
}


#pragma mark - 调用删除接口
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"0"])
    {
        CollectGoodsModel *model = self.goodsArray[indexPath.row];
        [self delete_deal_collect:model.collect_id];
    }
    
    if ([_btnType isEqualToString:@"1"])
    {
        ConllectShopModel *model = self.storeArray[indexPath.row];
        [self delete_location_collect:model.collect_id];
    }
    
    _tbView.editing = NO;
}

#pragma mark - 修改删除的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)delete_deal_collect:(NSString *)deal_id
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:deal_id,@"collect_id",APP_DELEGATE.user_id,@"user_id", nil];
    userDict[@"collect_type"] = @"0";
//    userDict 
    
    HHNSLog(@"------- %@dict%@",TIAdd_DeleteCollection,userDict);
    
    [HttpRequestServers requestBaseUrl:TIAdd_DeleteCollection withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"------->dict%@",dict);
        @try {
            
            if ([dict[@"code"] intValue]==0) {
                
                HUD.labelText = @"删除成功";
                [HUD hide:YES];
                ///重新加载数据
                _goodPage = 1;
                [self requestMyCollectGoodsData];
            }
            
            //            [PromptLabel custemAlertPromAddView:self.view  text:dict[@"msg"]];
        }
        @catch (NSException *exception) {
            [HUD hide:YES];
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HUD.labelText = kNetWork_ERROR;
        [HUD hide:YES];
        
    }];
    
    
}




- (void)delete_location_collect:(NSString *)location_id
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:location_id,@"collect_id",APP_DELEGATE.user_id,@"user_id", nil];
    userDict[@"collect_type"] = @"1";
    HHNSLog(@"------- %@dict%@",TIAdd_DeleteCollection,userDict);
    
    [HttpRequestServers requestBaseUrl:TIAdd_DeleteCollection withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"------->dict%@",dict);
        @try {
            
            if ([dict[@"code"] intValue]==0) {
                
                HUD.labelText = @"删除成功";
                [HUD hide:YES];
                ///重新加载数据
                _storePage = 1;
                [self requestMyCollectStoreData];
            }
            
            //            [PromptLabel custemAlertPromAddView:self.view  text:dict[@"msg"]];
        }
        @catch (NSException *exception) {
            [HUD hide:YES];
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        
        HUD.labelText = kNetWork_ERROR;
        [HUD hide:YES];
        
    }];
    
}


#pragma mark - 点击展开列表 收起列表
- (void)showListAction:(UIButton *)btn
{
    NSUInteger didSection = btn.tag+1;
    
    NSString *key = [NSString stringWithFormat:@"%ld",didSection];
    if (![self.showListDict objectForKey:key]) {
        [self.showListDict setObject:@"1" forKey:key];
    }else
    {
        [self.showListDict removeObjectForKey:key];
    }
    
    //刷新这个分组
    [_tbView reloadSections:[NSIndexSet indexSetWithIndex:didSection-1] withRowAnimation:UITableViewRowAnimationFade];
}

////TableView的分割线处理
-(void)viewDidLayoutSubviews {
    
    if ([_tbView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tbView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tbView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tbView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - 添加刷新头部尾部视图
- (void)setRefreshTableView
{
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([_btnType isEqualToString:@"0"]) {
            _goodPage = 1;
            [self requestMyCollectGoodsData];
        }
        else if ([_btnType isEqualToString:@"1"]){
            _storePage = 1;
            [self requestMyCollectStoreData];
        }
    }];
    
    [_tbView.header beginRefreshing];
    
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if ([_btnType isEqualToString:@"0"]) {
            _goodPage++;
            [self requestMyCollectGoodsData];
        }
        else if ([_btnType isEqualToString:@"1"]){
            _storePage++;
            [self requestMyCollectStoreData];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
