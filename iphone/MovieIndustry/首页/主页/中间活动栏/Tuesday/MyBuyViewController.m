//
//  MyBuyViewController.m
//  MovieIndustry
//
//  Created by aaa on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MyBuyViewController.h"
#import "MyBuyTableViewCell.h"

@interface MyBuyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation MyBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"我的抢购"];
    //创建tableView
    [self createTableView];
    // Do any additional setup after loading the view.
}
//创建tableView
- (void)createTableView{
    CGFloat tableX = 0;
    CGFloat tableY = 0;
    CGFloat tableW = screenWidth;
    CGFloat tableH = screenHeight - 64;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableX, tableY, tableW, tableH)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //这边需要加入上拉刷新的事件
        [self.tableView.footer endRefreshing];
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 157;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyBuyTableViewCell * cell = [[MyBuyTableViewCell alloc]initWithTableView:tableView];
    //这边要给cell赋值
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
