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
#import "TeacherDetialMsgController.h"
#import "SDCycleScrollView.h"
#import "MovieCircle_PersonDetailController.h"
@interface FilmTimeLineController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    UITableView *_tbView;
}

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, weak) UIButton *relasePostBtn;
@end

@implementation FilmTimeLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"电影圈"];
    [self setNavRightImage:@"search_index" rightAction:@selector(searchBtnClicked:)];
    [self createTableView];

}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight- 64) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    [self.view addSubview:_tbView];
    
    //设置头部View的大小
    UIView *tbHeaderView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 148)];
    //
    UIImage * image1 = [UIImage imageNamed:@"yiyuanqiang.jpg"];
    UIImage * image2 = [UIImage imageNamed:@"banner1_750.jpg"];
    UIImage * image3 = [UIImage imageNamed:@"banner2_750.jpg"];
    NSArray * imageArray = @[image3,image2,image1];
    SDCycleScrollView * bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kViewWidth, kViewWidth/2) imagesGroup:imageArray];
    
    bannerView.delegate = self;
    bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.bannerView = bannerView;
    
    //添加到头部视图
    [tbHeaderView addSubview:bannerView];
    
    //设置tableView的头部视图
    _tbView.tableHeaderView = tbHeaderView;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *relasePostBtn = [[UIButton alloc] init];
    self.relasePostBtn = relasePostBtn;
    [relasePostBtn setImage:[UIImage imageNamed:@"btn_fabushuoshuo"] forState:UIControlStateNormal];
    [relasePostBtn addTarget:self action:@selector(publishFilmAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.relasePostBtn];
    CGFloat btnWH = 60;
    CGFloat margin = 10;
    relasePostBtn.frame = CGRectMake(kViewWidth - btnWH - margin, kViewHeight - btnWH , btnWH, btnWH);

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.relasePostBtn removeFromSuperview];
}
- (void) searchBtnClicked:(UIButton *) btn {
    
}
#pragma mark - 发布电影圈
- (void)publishFilmAction
{
    PublishTimeLineController *pubVc = [[PublishTimeLineController alloc] init];
    [self.navigationController pushViewController:pubVc animated:YES];
}



#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 168;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FilmTimeLineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FilmTimeLineCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCircle_PersonDetailController *controller = [[MovieCircle_PersonDetailController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headV = [[UIView alloc] init];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movieSchool_horn"]];
        imgV.frame = CGRectMake(10, 5, 10, 18);
        [headV addSubview:imgV];
        
        UILabel *lbl = [[UILabel alloc] init];
        lbl.textColor = [UIColor darkGrayColor];
        lbl.font = [UIFont systemFontOfSize:13];
        CGFloat lblX = CGRectGetMaxX(imgV.frame) + 5;
        lbl.frame = CGRectMake(lblX, 0, kViewWidth - lblX, 30);
        [headV addSubview:lbl];
        lbl.text = @"公告:显示公告";
        return headV;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma mark  SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}
@end
