//
//  FamousTeacherController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/13.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "FamousTeacherController.h"
#import "RankingListHeader.h"
#import "CollectCourseCell.h"
#import "BestLikeRankingCell.h"
@interface FamousTeacherController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
}
@end

@implementation FamousTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"名师排行榜"];
    [self createTableView];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    RankingListHeader *tbHeader = [[[NSBundle mainBundle] loadNibNamed:@"RankingListHeader" owner:nil options:nil ] lastObject];
    tbHeader.rankingLabel.text = @"名师排行榜";
    tbHeader.oneLabel.text = @"咔么电影工业网为您推荐的, 最受欢";
    tbHeader.twoLabel.text = @"迎十大名师, 快来围观吧！";
    _tbView.tableHeaderView = tbHeader;
    ///设置头部View的大小
    //    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 142.00f)];
    
    
    [self.view addSubview:_tbView];
}

#pragma mark - tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"famousCellID";
    BestLikeRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BestLikeRankingCell" owner:self options:nil]lastObject];

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
