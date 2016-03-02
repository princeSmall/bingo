//
//  MyPointsController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/8.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyPointsController.h"
#import "MyPointsHeader.h"
#import "MyPointsCell.h"
#import "MovieMinePointRecordModel.h"
#import "IncomeDetailsController.h"

@interface MyPointsController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tbView;
}

@property (nonatomic,strong) NSMutableArray *recordArray;


@end

@implementation MyPointsController

- (NSMutableArray *)recordArray
{
    if (nil == _recordArray) {
        _recordArray = [NSMutableArray new];
    }
    return _recordArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTabBar:@"我的积分"];
    [self createTableView];
    [self createMinePointRecordDatas];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    [self.view addSubview:_tbView];
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    //设置头部视图
    MyPointsHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyPointsHeader" owner:self options:nil]lastObject];
    headerView.allPointLab.text = self.allPoint;
    [headerView.pointRuleBtn addTarget:self action:@selector(pointRuleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.incomDetailBtn addTarget:self action:@selector(checkMineIncomeDetail:) forControlEvents:UIControlEventTouchUpInside];
    _tbView.tableHeaderView = headerView;
    
    _tbView.alpha = 0;
}


#pragma mark - 查看积分规则
- (void)pointRuleBtnClicked:(UIButton *)button
{
    
}


#pragma mark - 查看我的收入明细
- (void)checkMineIncomeDetail:(UIButton *)button
{
    IncomeDetailsController *detailVC = [[IncomeDetailsController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - 请求我的积分记录数据
- (void)createMinePointRecordDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    
    [MovieHttpRequest createMinePointRecordCallBack:^(id obj) {
        
        [HUD hide:YES];
        self.recordArray = [NSMutableArray arrayWithArray:obj];
        
        _tbView.alpha = 1;
        [_tbView reloadData];
        
    } andSCallBack:^(id obj) {
        
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"myPointsCellID";
    MyPointsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyPointsCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MovieMinePointRecordModel *model = _recordArray[indexPath.row];
    [cell setPointModel:model];
    
    return cell;
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
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
