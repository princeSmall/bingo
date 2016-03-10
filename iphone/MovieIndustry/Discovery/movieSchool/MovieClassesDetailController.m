//
//  MovieClassesDetailController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/10.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesDetailController.h"
#import "MovieClassesDetailHeadV.h"
#import "MovieClassesDetailCell.h"
@interface MovieClassesDetailController () <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, weak) MovieClassesDetailCell *cell;


@end

@implementation MovieClassesDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"课程详情"];
    [self creatTableView];

    self.array = [NSArray arrayWithObjects:@{@"title":@"第一课:时",@"content":@"阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了"},@{@"title":@"第二课时:",@"content":@"阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了阿斯顿回复看就阿红的设计费看哈开始的干活了"},@{@"title":@"第三课时:",@"content":@"阿斯顿回复看就阿红的设计费看哈开始的干活了"},@{@"title":@"第四课时:",@"content":@"阿斯顿回复看就阿红的设计费看哈开始的干活了"},@{@"title":@"第五课时:",@"content":@"阿斯顿回复看就阿红的设计费看哈开始的干活了"}, nil];
}

- (void) creatTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, -20, kViewWidth, kViewHeight);
    _tableView.delegate =  self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    MovieClassesDetailHeadV *detailHead = [[MovieClassesDetailHeadV  alloc] initMovieClassesDetailHeadV];
    
    detailHead.frame = CGRectMake(0, 0, kViewWidth, 374);
    
    _tableView.tableHeaderView = detailHead ;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.leftBtn removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 1;
        self.navigationController.navigationBar.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBack];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBar.hidden = YES;
    }];
    
    ///设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)setNavBack
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 35, 20, 18)];
    self.leftBtn = leftBtn;
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.alpha = 1;
    [window addSubview:leftBtn];

}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieClassesDetailCell *cell = [[MovieClassesDetailCell alloc] initWithTableView:tableView];
    self.cell = cell;
    cell.dic = self.array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MovieClassesDetailCell *cell = (MovieClassesDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    return self.cell.cellH ;
}
@end
