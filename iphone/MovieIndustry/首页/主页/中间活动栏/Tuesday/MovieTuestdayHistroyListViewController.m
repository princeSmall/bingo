//
//  MovieTuestdayHistroyListViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/12/7.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTuestdayHistroyListViewController.h"
#import "MovieTuesdayHistoryContentCell.h"
#import "MovieTuesdayHistoryTitleCell.h"
#import "MovieTuesdayRushHistoryModel.h"
#import "MovieTuesdayRushedPersonModel.h"

@interface MovieTuestdayHistroyListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mainTableView;

@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation MovieTuestdayHistroyListViewController

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"抢购记录"];
    [self requestTusedayHistoryListDatas];
}

- (void)createTuesdayHistoryView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    UIColor *bgColor = RGBColor(234,234,234,1);
    self.view.backgroundColor = bgColor;
    self.mainTableView.backgroundColor = bgColor;
}

#pragma mark - 请求抢购记录数据
- (void)requestTusedayHistoryListDatas
{    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createTuesdayActivityHistoryListWithGoodId:self.goodId CallBack:^(id obj) {
        
        [HUD hide:YES];
        self.dataArray = [NSMutableArray arrayWithArray:obj];
        [self createTuesdayHistoryView];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MovieTuesdayRushHistoryModel *model = _dataArray[section];
    NSArray *rushArray = model.goods;
    return rushArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        static NSString *cellID = @"shopTitleIndentifier";
        MovieTuesdayHistoryTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == titleCell) {
            titleCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieTuesdayHistoryTitleCell" owner:self options:nil] lastObject];
        }
        
        MovieTuesdayRushHistoryModel *model = _dataArray[indexPath.section];
        [titleCell setTitleModel:model];
        
        return titleCell;
    }
    else
    {
        static NSString *cellID = @"cellIdentifier";
        MovieTuesdayHistoryContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == contentCell) {
            contentCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieTuesdayHistoryContentCell" owner:self options:nil] lastObject];
        }
        
        MovieTuesdayRushHistoryModel *model = _dataArray[indexPath.section];
        NSArray *detailArray = model.goods;
        MovieTuesdayRushedPersonModel *infoModel = detailArray[indexPath.row-1];
        
        [contentCell setInfoModel:infoModel];
        
        return contentCell;
    }
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
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0==indexPath.row)?65:70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
