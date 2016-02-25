//
//  MyMessageController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyMessageController.h"
#import "MovieHistoryViewController.h"
#import "FriendsMesCell.h"
#import "PublishMesCell.h"
#import "ReciveMesCell.h"
#import "NotisMesCell.h"
#import "MJRefresh.h"
#import "MovieMineReceiveNeedsModel.h"
#import "MovieMineIssueNeedsModel.h"

#define BTN_START_TAG  200

@interface MyMessageController ()<UITableViewDataSource,
UITableViewDelegate>
{
    ///选中的按钮
    UIButton *_selectedBtn;
    
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表好友消息 1 代表发布的需求 2 代表收到的需求 3 代表通知
    NSString *_btnType;
    
}

/** 发布的需求数据 */
@property (nonatomic,retain) NSMutableArray *issueArray;

/** 收到的需求数据 */
@property (nonatomic,retain) NSMutableArray *receiveArray;

/** 通知数据 */
@property (nonatomic,retain) NSMutableArray *notiArray;

@property (nonatomic,assign) int issuePage;
@property (nonatomic,assign) int receivePage;
@property (nonatomic,assign) int notiPage;

@end

@implementation MyMessageController

- (NSMutableArray *)issueArray
{
    if (nil == _issueArray) {
        _issueArray = [NSMutableArray new];
    }
    return _issueArray;
}

- (NSMutableArray *)receiveArray
{
    if (nil == _receiveArray) {
        _receiveArray = [NSMutableArray new];
    }
    return _receiveArray;
}

- (NSMutableArray *)notiArray
{
    if (nil == _notiArray) {
        _notiArray = [NSMutableArray new];
    }
    return _notiArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _receivePage = 1;
    _issuePage = 1;
    _notiPage = 1;
    _btnType = @"1";
    
    [self setNavTabBar:@"消息"];
    [self createUI];
    [self setTableViewRefrseh];
}


- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, kViewWidth, kViewHeight-20-44-20) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    self.view.backgroundColor = kViewBackColor;
    
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.00f)];
    
    [self.view addSubview:_tbView];
    
    self.view.backgroundColor = kViewBackColor;
    _tbView.backgroundColor = kViewBackColor;
}

- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 42)];
    [self.view addSubview:btnView];
    
    CGFloat btnW = kViewWidth/3;
    
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(10, 40, btnW-20, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    NSArray *titleArray = @[@"发布的需求",@"收到的需求",@"通知"];
    for (int i= 0; i< titleArray.count; i++) {
        
        UIButton *segmentBtn = [WNController createButtonWithFrame:CGRectMake(btnW*i,0,btnW, 42) ImageName:@"" Target:self Action:@selector(segmentBtnClickedAction:) Title:titleArray[i] fontSize:15];
        segmentBtn.tag = BTN_START_TAG + i;
        if (0 == i) {
            _selectedBtn = segmentBtn;
        }
        [btnView addSubview:segmentBtn];
    }
    
    _btnType = @"1"; //默认为发布的需求
    
    [self createTableView];
}

#pragma mark - 切换列表选项
- (void)segmentBtnClickedAction:(UIButton *)button
{
    [self.receiveArray removeAllObjects];
    [self.issueArray removeAllObjects];
    [self.notiArray removeAllObjects];
    [_tbView reloadData];
    
    NSInteger index = button.tag - BTN_START_TAG;
    
    switch (button.tag) {
        case BTN_START_TAG: //发布的需求
        {
            _btnType = @"1";
            [_tbView.header beginRefreshing];
        }
            break;
        case (BTN_START_TAG+1): //收到的需求
        {
            _btnType = @"2";
            [_tbView.header beginRefreshing];
            
        }
            break;
        case (BTN_START_TAG+2): //通知
        {
            _btnType = @"3";
            [_tbView.header beginRefreshing];
            
        }
            break;
        default:
            break;
    }
    
    CGFloat buttonW = kViewWidth/3;
    
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = button;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = CGRectMake(10+buttonW*index, 40, buttonW-20, 2);
    }];
    
}

#pragma mark - 请求发布的需求列表数据
- (void)requestMineRequestsList
{
    [MovieHttpRequest createMineRequestListWithPage:_issuePage CallBack:^(id obj) {
        
        if (1 == _issuePage) {
            self.issueArray = [NSMutableArray arrayWithArray:obj];
        }else{
            [self.issueArray addObjectsFromArray:obj];
        }
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [_tbView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - 请求收到的需求列表数据
- (void)requestMineReciveList
{
    [MovieHttpRequest createMineReceivedNeedsWithLocationId:self.locationId andPage:_receivePage CallBack:^(id obj) {
        
        if (1 == _receivePage) {
            self.receiveArray = [NSMutableArray arrayWithArray:obj];
        }
        else{
            [self.receiveArray addObjectsFromArray:obj];
        }
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [_tbView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
        [_tbView reloadData];
    }];
}


#pragma mark - 请求我的通知列表数据
- (void)requestMineNotificationList
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    HUD.labelText = @"加载完成";
    [HUD hide:YES];
    
    [_tbView.header endRefreshing];
    [_tbView.footer endRefreshing];
    
    [HUD hide:YES];
//    [DeliveryUtility showMessage:obj target:self];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_btnType isEqualToString:@"1"]) {
        return self.issueArray.count;
    }
    else if ([_btnType isEqualToString:@"2"]){
        return self.receiveArray.count;
    }
    else if ([_btnType isEqualToString:@"3"]){
        return self.notiArray.count;
    }
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"1"]) {
        return 130;
    }
    
    if ([_btnType isEqualToString:@"2"]) {
        return 180;
    }
    
    if([_btnType isEqualToString:@"3"])
    {
        return 113;
    }
    
    return 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"0"]) {
        static NSString *cellID = @"FriendsMesCell";
        FriendsMesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendsMesCell" owner:self options:nil]lastObject];
        }
        
        _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if([_btnType isEqualToString:@"1"])
    {
        //我发布的需求
        static NSString *cellID = @"PublishMesCellID";
        PublishMesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PublishMesCell" owner:self options:nil] lastObject];
        }
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MovieMineIssueNeedsModel *model = _issueArray [indexPath.section];
        cell.needModel = model;
        
        return cell;
        
    }else if ([_btnType isEqualToString:@"2"])
    {
        //我收到的需求
        static NSString *cellID = @"ReciveMesCell";
        ReciveMesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReciveMesCell" owner:self options:nil]lastObject];
        }
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.knockBtn.tag = 500 + indexPath.section;
        
        MovieMineReceiveNeedsModel *model = _receiveArray[indexPath.section];
        [cell setReceiveModel:model];
        
        /** 0:未抢单 1:抢单成功 2:抢单失效  */
        if (![model.status isEqualToString:@"1"]) {
            
            [cell.knockBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.knockBtn setTitle:@"立即抢单" forState:UIControlStateNormal];
            [cell.knockBtn addTarget:self action:@selector(rushMineReceiveOrder:) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            [cell.knockBtn setBackgroundColor:RGBColor(220, 220, 220, 1)];
            [cell.knockBtn setTitle:@"已抢过" forState:UIControlStateNormal];
        }
        
        return cell;
        
    }else if ([_btnType isEqualToString:@"3"])
    {
        static NSString *cellID = @"NotisMesCell";
        NotisMesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NotisMesCell" owner:self options:nil]lastObject];
        }
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 5)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"1"]) {
        
        MovieMineIssueNeedsModel *model = _issueArray [indexPath.section];
        
        MovieHistoryViewController *rushedListVC = [[MovieHistoryViewController alloc] init];
        rushedListVC.rentId = model.requestRentId;
        [self.navigationController pushViewController:rushedListVC animated:YES];
    }
}

//TableView的分割线处理
-(void)viewDidLayoutSubviews {
    
    if ([_tbView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tbView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tbView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tbView setLayoutMargins:UIEdgeInsetsZero];
    }
}



#pragma mark - 列表上下拉刷新
- (void)setTableViewRefrseh
{
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([_btnType isEqualToString:@"1"]) {
            
            _issuePage = 1;
            [self requestMineRequestsList];
        }
        else if ([_btnType isEqualToString:@"2"]){
            
            _receivePage = 1;
            [self requestMineReciveList];
        }
        else if ([_btnType isEqualToString:@"3"]){
            
            _notiPage = 1;
            [self requestMineNotificationList];
        }
        
    }];
    
    [_tbView.header beginRefreshing];
    
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if ([_btnType isEqualToString:@"1"]) {
            
            _issuePage++;
            [self requestMineRequestsList];
        }
        else if ([_btnType isEqualToString:@"2"]){
            
            _receivePage++;
            [self requestMineReciveList];
        }
        else if ([_btnType isEqualToString:@"3"]){
            
            _notiPage++;
            [self requestMineNotificationList];
        }
    }];
}



#pragma mark - 我收到的需求点击抢单按钮
- (void)rushMineReceiveOrder:(UIButton *)button
{
    NSLog(@"抢单按钮被点击");
    NSInteger index = button.tag - 500;
    MovieMineReceiveNeedsModel *model = _receiveArray[index];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = @"抢单中...";
    [HUD show:YES];
    
    [MovieHttpRequest createRushMineRecivedNeedsWith:model.receiveMsgId CallBack:^(id obj) {
        
        [HUD hide:YES];
//        [PromptLabel custemAlertPromAddView:self.view text:@"抢单成功"];
         [DeliveryUtility showMessage:@"抢单成功" target:nil];
        model.status = @"1";
        [_tbView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
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
