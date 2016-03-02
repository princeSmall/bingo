//
//  HHDiscoverController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHDiscoverController.h"
#import "FilmTimeLineController.h"
#import "RankingListController.h"
#import "DiscoverBBSController.h"
#import "TeacherCourseController.h"
#import "MovieTalkToPersonViewController.h"
#import "DiscoverNorCell.h"
#import "FilmBannerCell.h"
#import "IndexCell.h"
#import "DiscoverPopView.h"
#import "MovieDiscoveryArticleModel.h"

@interface HHDiscoverController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MovieArticleDetailDelegate>
{
    UITableView *_tbView;
    
    NSArray *_cellIconArray;
    NSArray *_cellTitleArray;
    
    DiscoverPopView *_popView;
    UIView *_popBgView;
    UIButton *_selectedBtn;
    
    UILabel *_navLabel;
}

//文章列表接口
@property (nonatomic,strong) NSMutableArray *listArray;

//展示的文章数据
@property (nonatomic,strong) NSMutableArray *displayArray;

//列表分页p
@property (nonatomic,assign) int page;

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,copy) NSString *keyword;


@end

@implementation HHDiscoverController

- (NSMutableArray *)listArray
{
    if (nil == _listArray) {
        _listArray = [NSMutableArray new];
    }
    return _listArray;
}

- (NSMutableArray *)displayArray
{
    if (nil == _displayArray) {
        _displayArray = [NSMutableArray new];
    }
    return _displayArray;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self requestDisplayArticleDatas];
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _selectedBtn.selected = NO;
    [_popBgView removeFromSuperview];
    [_popView removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    self.keyword = @"";
    
    [self setNavView];
    [self createTableView];
    [self requestDisplayArticleDatas];
    
    [self createRefresh];
}

#pragma mark - 加载文章展示数据
- (void)requestDisplayArticleDatas
{
    [MovieHttpRequest createDiscoverViewDisplayArticleCallBack:^(id obj) {
        
        self.displayArray = [NSMutableArray arrayWithArray:obj];
        [self requestArticleListDatas];
        
    } andSCallBack:^(id obj) {
        
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - 加载文章列表数据
- (void)requestArticleListDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createDiscoverArticleListWithPage:_page andKeyword:self.keyword CallBack:^(id obj) {
        
        HUD.labelText = @"加载完成";
        [HUD hide:YES];
        
        if (self.page == 1) {
            [self.listArray removeAllObjects];
        }
        [self.listArray addObjectsFromArray:obj];
        
        
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [_tbView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


- (void)createTableView
{
    
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-94) style:UITableViewStyleGrouped];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tag = 2;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    UIView *view2 = [[UIView alloc] init];
    _tbView.tableHeaderView = view2;
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 5.00f)];
    _tbView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tbView];
    
    self.view.backgroundColor = kViewBackColor;
    _tbView.backgroundColor = kViewBackColor;
}

- (void)setNavView
{
    UIView *view = [WNController createViewFrame:CGRectMake(0, 0, 257, 30)];
    view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    view.layer.cornerRadius = 15;
    view.layer.masksToBounds = YES;

    self.textField = [WNController createTextFieldWithFrame:CGRectMake(75, 2, 168, 28) boreStyle:UITextBorderStyleNone font:15];
    self.textField.placeholder = @"你想找的文章";
    self.textField.delegate = self;
    //添加监听变化
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.returnKeyType = UIReturnKeySearch;
    
    UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake(218, 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchMineKeyArticle:)];
    
//    UIImageView *searchImage = [WNController createImageViewWithFrame:CGRectMake(218, 5, 20, 20) ImageName:@"search_index"];
    [view addSubview:searchArticleBtn];
    
    [view addSubview:self.textField];
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(14, 1, 40, 30) Font:16 Text:@"论坛" textAligment:NSTextAlignmentCenter];
    _navLabel = navLabel;
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(53, 8, 14, 14) ImageName:@"15-07"];
    
    UIButton *navBtn  = [WNController createButtonWithFrame:CGRectMake(0, 0, 70, 30) ImageName:@"" Target:self Action:@selector(selectTypeAction:) Title:@""];
    
    
    
    [view addSubview:navLabel];
    [view addSubview:navImage];
    [view addSubview:self.textField];
    [view addSubview:navBtn];
    
    //设置头部的View
    self.navigationItem.titleView = view;
    
    _popView = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverPopView" owner:nil options:nil]lastObject];
    _popView.frame = CGRectMake((kViewWidth-257)/2, 0, 132, 106);
    
    [_popView.forumButton addTarget:self action:@selector(forumButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_popView.courseButton addTarget:self action:@selector(courseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //覆盖的大View不让干其他地方点击
    _popBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _popBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePopView:)];
    [_popBgView addGestureRecognizer:tapGes1];
    


    self.navigationItem.titleView = view;
}

#pragma mark - 添加刷新
- (void)createRefresh
{
    //添加下拉刷新
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [self requestDisplayArticleDatas];
        [self requestArticleListDatas];
        //加载首页文章列表
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tbView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        
        self.page ++;
        //加载首页文章列表
        [self requestDisplayArticleDatas];
        [self requestArticleListDatas];
    }];
    _tbView.footer.automaticallyChangeAlpha = YES;
}



#pragma mark - 搜索文章
- (void)searchMineKeyArticle:(UIButton *)button
{
    [self.textField resignFirstResponder];
    self.keyword = [self.textField.text asTrim];
    [self requestArticleListDatas];
}



#pragma mark 选择论坛
- (void)forumButtonAction:(UIButton *)btn
{
    _navLabel.text = @"论坛";
    _selectedBtn.selected = NO;
    [_popBgView removeFromSuperview];
    [_popView removeFromSuperview];

}

#pragma mark - 选择课程
- (void)courseButtonAction:(UIButton *)btn
{
    _navLabel.text = @"课程";
    _selectedBtn.selected = NO;
    [_popBgView removeFromSuperview];
    [_popView removeFromSuperview];

}

- (void)removePopView:(UITapGestureRecognizer *)g
{
    [g.view removeFromSuperview];
    [_popView removeFromSuperview];
    _selectedBtn.selected = NO;
    
}

#pragma mark - 选择不同的分类
- (void)selectTypeAction:(UIButton *)btn
{
    _selectedBtn = btn;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.view addSubview:_popBgView];
        [self.view addSubview:_popView];
    }else
    {
        [_popBgView removeFromSuperview];
        [_popView removeFromSuperview];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    
    if (section == 3) {
        return self.listArray.count+1;
    }
    
    return 1;
    
//    return self.listArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if (0 == indexPath.row) {
            return 140;
        }
        return 87;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section <3) {
            static NSString *cellID = @"DiscoverNormalCell";
            DiscoverNorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverNorCell" owner:self options:nil] lastObject];
    
    //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            //第一组
            if (indexPath.section == 0) {
                cell.setImageView.image = [UIImage imageNamed:@"discover_06"];
                cell.typeLabel.text = @"电影圈";
    
    
            }
    
            _cellIconArray = @[@"discover_06",];
            _cellTitleArray = @[@"电影圈",];
    
            //第二组
            if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    cell.setImageView.image = [UIImage imageNamed:@"discover_09"];
                    cell.typeLabel.text = @"社区论坛";
    
//                    if (indexPath.row == 0) {
//    
//                        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kViewWidth, 1)];
//                        line.backgroundColor = kViewBackColor;
//                        [cell.contentView addSubview:line];
//                    }
                }
    
    
                if (indexPath.row == 1) {
                    cell.setImageView.image = [UIImage imageNamed:@"discover_12"];
                    cell.typeLabel.text = @"名师讲堂";
                }
    
            }
            //第三组
            if (indexPath.section == 2) {
                cell.setImageView.image = [UIImage imageNamed:@"discover_14"];
                cell.typeLabel.text = @"排行榜";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    
        }if (indexPath.row == 0) {
        static NSString *cellID = @"FilmBannerCellID";
        FilmBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FilmBannerCell" owner:nil options:nil] lastObject];
            
            [cell.leftImageBtn addTarget:self action:@selector(leftImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightImageBtn addTarget:self action:@selector(rightImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
            
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataArray:self.displayArray];
        
        return cell;
    }else
    {
        static NSString *cellID = @"DiscoverIndexCell";
        IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"IndexCell" owner:self options:nil] lastObject];
        }
        
        
        MovieDiscoveryArticleModel *model = _listArray[indexPath.row-1];
        [cell setArticleModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
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
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section<3) {
        return 5;
    }
    
    if (section == 3) {
        return 26;
    }
    
    return 1;
    
//    return 26.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.1f;
    }
    return 5.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *hView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 26)];
        hView.backgroundColor = kViewBackColor;
        UILabel *label = [WNController createLabelWithFrame:CGRectMake(6,3,128, 21) Font:15 Text:@"趣味电影" textAligment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1];
        [hView addSubview:label];
        return hView;
    }
    return  nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        FilmTimeLineController *filmVc = [[FilmTimeLineController alloc] init];
        [filmVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:filmVc animated:YES];
    }
    
    if (indexPath.section == 2) {
        RankingListController *rankListVc = [[RankingListController alloc] init];
        [rankListVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:rankListVc animated:YES];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            DiscoverBBSController *bbsVc = [[DiscoverBBSController alloc] init];
            [bbsVc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:bbsVc animated:YES];
        }
        
        
        if (indexPath.row == 1) {
            TeacherCourseController *tcourseVc = [[TeacherCourseController alloc] init];
            [tcourseVc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:tcourseVc animated:YES];
        }
        
    }
   
    
    if (indexPath.section == 3) {
        [self.textField resignFirstResponder];
        
        MovieTalkToPersonViewController *talkVc = [[MovieTalkToPersonViewController alloc] init];
        MovieDiscoveryArticleModel *model = _listArray[indexPath.row-1];
        talkVc.articleId = model.articleId;
        talkVc.delegate = self;
        [talkVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:talkVc animated:YES];
    }
    
    
}

#pragma mark - 趣味电影图片点击事件
- (void)leftImageBtnAction
{
    MovieTalkToPersonViewController *talkVc = [[MovieTalkToPersonViewController alloc] init];
    MovieDiscoveryArticleModel *model = [_displayArray lastObject];
    talkVc.articleId = model.articleId;
    [talkVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:talkVc animated:YES];
}

#pragma mark - 趣味电影右边的图片
- (void)rightImageBtnAction
{
    MovieTalkToPersonViewController *talkVc = [[MovieTalkToPersonViewController alloc] init];
    MovieDiscoveryArticleModel *model = [_displayArray firstObject];
    talkVc.articleId = model.articleId;
    [talkVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:talkVc animated:YES];
}

#pragma mark - 点击return  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.keyword = [textField.text asTrim];
    [self requestArticleListDatas];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text isEqualToString:@""]) {
        self.keyword = @"";
        [self requestArticleListDatas];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.keyword = @"";
        [self requestArticleListDatas];
    }
}


#pragma mark - 判断输入时的变化
- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        [self.textField resignFirstResponder];
        self.keyword = @"";
        [self requestArticleListDatas];
    }
}


#pragma mark - 文章详情评论成功代理(刷新界面)
- (void)commentArticleSuccess:(BOOL)isSuccess
{
    if (isSuccess) {
        [self requestDisplayArticleDatas];
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
