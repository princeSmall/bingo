//
//  MyPhotosController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyPhotosController.h"
#import "MyPhotosCell.h"
#import "MyPhotosHeader.h"
#import "TodayCameraCell.h"

@interface MyPhotosController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tbView;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation MyPhotosController

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"我的相册"];
    [self setNavRightItem:@"编辑" rightAction:@selector(rightBarButtonAction)];
    
    //初始化数据
    [self loadData];
    [self createTableView];
    
    
}

//加载数据
- (void)loadData
{
    for (int i = 0; i<3; i++) {
        if (i==1) {
            NSMutableArray *rowArray = [NSMutableArray array];
            for (int j = 0; j<3; j++) {
                MyPhotosModel *model = [[MyPhotosModel alloc] init];
                model.day = @"07";
                model.month = @"九月";
                model.image = @"dog";
                model.titles = @"意美捷/EMAGEG3D三脚架";
                [rowArray addObject:model];
            }
            [self.dataArray addObject:rowArray];
        }else
        {
            NSMutableArray *rowArray = [NSMutableArray array];
            MyPhotosModel *model = [[MyPhotosModel alloc] init];
            model.day = @"07";
            model.month = @"九月";
            model.image = @"dog";
            model.titles = @"意美捷/EMAGEG3D三脚架";
            [rowArray addObject:model];
            
            [self.dataArray addObject:rowArray];
        }
    }
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-20) style:UITableViewStyleGrouped];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tbView];
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    MyPhotosHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyPhotosHeader" owner:self options:nil]lastObject];
    headerView.headerImageView.layer.borderWidth = 2;
    headerView.headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _tbView.tableHeaderView = headerView;
    _tbView.tableHeaderView.frame = CGRectMake(0, 0, kViewWidth, 205);
    
}

#pragma mark - 编辑相册
- (void)rightBarButtonAction
{
    
}

///返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count+1;
}

///返回每组数据里面的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else
    {
        return [[_dataArray objectAtIndex:section-1] count];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断是否是第一组第一行
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 85;
        }
    }
    
    return 55;
}

//头部和尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.dataArray.count) {
        return 50;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cellID = @"MyPhotosCell";
        TodayCameraCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TodayCameraCell" owner:self options:nil]lastObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        static NSString *cellID = @"MyPhotosCell";
        MyPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyPhotosCell" owner:self options:nil]lastObject];
        }
        
        [cell config:[[self.dataArray objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row]];
        if (indexPath.row >0) {
            cell.dayLabel.alpha = 0;
            cell.monthLabel.alpha = 0;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

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
