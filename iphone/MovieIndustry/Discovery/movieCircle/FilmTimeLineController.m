//
//  FilmTimeLineController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "FilmTimeLineController.h"
#import "PublishTimeLineController.h"
#import "FilmTimeLineCell.h"
#import "MyPhotosHeader.h"

@interface FilmTimeLineController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
}
@end

@implementation FilmTimeLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"电影圈"];
    [self setNavRightImage:@"timeLineCamera" rightAction:@selector(publishFilmAction)];
    
    [self createTableView];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-20-24) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    
    MyPhotosHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyPhotosHeader" owner:self options:nil]lastObject];
    headerView.headerImageView.layer.borderWidth = 2;
    headerView.headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _tbView.tableHeaderView = headerView;
    _tbView.tableHeaderView.frame = CGRectMake(0, 0, kViewWidth, 205);
    
    
    [self.view addSubview:_tbView];
}

#pragma mark - 发布电影圈
- (void)publishFilmAction
{
    PublishTimeLineController *pubVc = [[PublishTimeLineController alloc] init];
    [self.navigationController pushViewController:pubVc animated:YES];
}



#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FilmTimeLineCell";
    FilmTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FilmTimeLineCell" owner:nil options:nil]lastObject];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
