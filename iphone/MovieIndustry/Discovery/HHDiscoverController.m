//
//  HHDiscoverController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHDiscoverController.h"
#import "FilmTimeLineController.h"
#import "RankingListController.h"
#import "DiscoverBBSController.h"
#import "TeacherCourseController.h"
#import "DiscoverPopView.h"
#import "HHDiscoverCell.h"
#import "MovieSchoolController.h"
@interface HHDiscoverController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
    
    DiscoverPopView *_popView;
    UIView *_popBgView;
    UIButton *_selectedBtn;
    
    UILabel *_navLabel;
}


//列表分页p
@property (nonatomic,assign) int page;

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,copy) NSString *keyword;


@end

@implementation HHDiscoverController



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
}

- (void)createTableView
{
    
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-94) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tag = 2;
   
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
    self.textField.placeholder = @"你想找什么?";
    self.textField.delegate = self;
    //添加监听变化
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.returnKeyType = UIReturnKeySearch;
    
    UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake(218, 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchMineKeyArticle:)];

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




#pragma mark - 搜索文章
- (void)searchMineKeyArticle:(UIButton *)button
{
    [self.textField resignFirstResponder];
    self.keyword = [self.textField.text asTrim];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 170;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHDiscoverCell *cell = [HHDiscoverCell HHDiscoverCellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.imageV.image = [UIImage imageNamed:@"found_movieCircle"];
    } else if (indexPath.section == 1){
        cell.imageV.image = [UIImage imageNamed:@"movieSchool"];
    } else {
        cell.imageV.image = [UIImage imageNamed:@"communityBBS"];
    }
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // 电影圈
    if (indexPath.section == 0) {
        FilmTimeLineController *filmVc = [[FilmTimeLineController alloc] init];
        [filmVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:filmVc animated:YES];
    }
    // 社区论坛
    if (indexPath.section == 2) {
        DiscoverBBSController *BBSVC = [[DiscoverBBSController alloc] init];
        [BBSVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:BBSVC animated:YES];
    }
    // 电影学院
    if (indexPath.section == 1) {
        MovieSchoolController *movieSchoolVC = [[MovieSchoolController alloc] init];
        [movieSchoolVC setHidesBottomBarWhenPushed:YES];

        [self.navigationController pushViewController:movieSchoolVC animated:YES];
    }
   
    
    
}


#pragma mark - 点击return  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.keyword = [textField.text asTrim];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text isEqualToString:@""]) {
        self.keyword = @"";
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        self.keyword = @"";
    }
}


#pragma mark - 判断输入时的变化
- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        [self.textField resignFirstResponder];
        self.keyword = @"";
    }
}




@end
