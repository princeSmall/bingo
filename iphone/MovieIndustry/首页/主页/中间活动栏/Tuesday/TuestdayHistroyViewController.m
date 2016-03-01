//
//  TuestdayHistroyViewController.m
//  MovieIndustry
//
//  Created by aaa on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "TuestdayHistroyViewController.h"
#import "MyTableViewCell.h"
#import "MovieTuestdayHistroyListViewController.h"
#import "MyBuyViewController.h"

@interface TuestdayHistroyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation TuestdayHistroyViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyTableViewCell * cell = [[MyTableViewCell alloc]initWithTableView:tableView];
    [cell CreateCameLabelWithPrice:@"1"];
    [cell CreateCameLabelWithLine:@"22222"];
    [cell CreateCountLabel:@"5"];
    [cell CreateHowManyPeople:@"5"];
    [cell SetQishu:@"666" AndPeopleJoinCount:@"666" AndEndTime:@"2016-01-16 00:00" AndEndBlock:^(NSString *qs) {
        NSLog(@"%@",qs);
        MovieTuestdayHistroyListViewController * tuestday = [[MovieTuestdayHistroyListViewController alloc]init];
        tuestday.goodId = qs;
        [self.navigationController pushViewController:tuestday animated:YES];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 202;
}

- (void)RightActionBuy{
    
    MyBuyViewController * viewController = [[MyBuyViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)setNav1RightItem1:(NSString *)rightTitle rightAction:(SEL)rightAction
{
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 60, 25)];
        [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //添加点击事件
        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -12)];
    
        //设置TabBar左边的按钮
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItem:rightItem];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"往期回顾"];
    [self setNav1RightItem1:@"我的抢购" rightAction:@selector(RightActionBuy)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //这边加载更多事件处理
        [self.tableView.footer endRefreshing];
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
