//
//  DiscoverBBSController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/13.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "DiscoverBBSController.h"
#import "MovieTalkToPersonViewController.h"
#import "CollectPostCell.h"
#import "NotisMesCell.h"
#import "ClassifyPostController.h"
#import "BBSFriendMsgCell.h"
#import "MyPostController.h"
#import "CreatingNewClassController.h"
#import "DiscoverPopView.h"
#import "CreatPostController.h"
#import "BBSSearchController.h"
@interface DiscoverBBSController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    ///选中的按钮
    UIButton *_selectedBtn;
    
    UITableView *_tbView;
    
    // 标签容器
    UIView *_tagContentV;
    
}
@property (nonatomic,strong) UILabel *navLabel;
///搜索文本框
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) DiscoverPopView *popView;
@property (nonatomic,strong) UIView *popBgView;
@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, weak) UIButton *relasePostBtn;



@end

@implementation DiscoverBBSController
- (UIView *)popBgView
{
    if (!_popBgView) {
        //覆盖的大View不让干其他地方点击
        _popBgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _popBgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePopView:)];
        [_popBgView addGestureRecognizer:tapGes1];
    }
    
    return _popBgView;
}

- (DiscoverPopView *)popView
{
    if (!_popView) {
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverPopView" owner:nil options:nil]lastObject];
        _popView.frame = CGRectMake(10, 30, 132, 106);
        [_popView.forumButton setTitle:@"帖子" forState:UIControlStateNormal];
        [_popView.courseButton setTitle:@"说说" forState:UIControlStateNormal];
        [_popView.forumButton addTarget:self action:@selector(forumButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_popView.courseButton addTarget:self action:@selector(courseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"社区"];
    [self setNavRightImage:@"icon_user" rightAction:@selector(navRightAction)];
    [self createSearchBarUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *relasePostBtn = [[UIButton alloc] init];
    self.relasePostBtn = relasePostBtn;
    [relasePostBtn setImage:[UIImage imageNamed:@"btn_relasePost"] forState:UIControlStateNormal];
    [relasePostBtn addTarget:self action:@selector(relasePostBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.relasePostBtn];
    CGFloat btnWH = 70;
    CGFloat margin = 10;
    relasePostBtn.frame = CGRectMake(kViewWidth - btnWH - margin, kViewHeight - btnWH , btnWH, btnWH);

}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.relasePostBtn removeFromSuperview];
}
- (void) relasePostBtnAction {
    CreatPostController *postVC = [[CreatPostController alloc] init];
    [self.navigationController pushViewController:postVC animated:YES];
}
- (void) navRightAction {
    
}
- (void)createSearchBarUI
{
    // 搜索栏
    UIView *searchV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 40)];
    searchV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchV];
    
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(15, 5, 40, 30) Font:16 Text:@"帖子" textAligment:NSTextAlignmentCenter];
    self.navLabel = navLabel;
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(53, 12, 14, 14) ImageName:@"15-07"];
    
    UIView *tfContentV = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(navImage.frame) + 10, 8, kViewWidth - CGRectGetMaxX(navImage.frame) - 8 - 20, 26)];
    tfContentV.layer.cornerRadius = 12;
    tfContentV.layer.masksToBounds = YES;
    [searchV addSubview:tfContentV];
    tfContentV.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(20, 0, tfContentV.width - 60, 26) boreStyle:UITextBorderStyleNone font:15];
    [tfContentV addSubview:textField];
    textField.placeholder = @"请输入关键字";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    self.searchTextField = textField;
    
    UIButton *navBtn  = [WNController createButtonWithFrame:CGRectMake(0, 0, 70, 30) ImageName:@"" Target:self Action:@selector(searchTypeAction:) Title:@""];
    
    UIButton *searchBtn = [DeliveryUtility createBtnFrame:CGRectMake(CGRectGetMaxX(textField.frame) + 5,2,20,20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchPostsAction)];
    [tfContentV addSubview:searchBtn];
    
    [searchV addSubview:navLabel];
    [searchV addSubview:navImage];
    [searchV addSubview:navBtn];

    
    [self createTableView];
}
#pragma mark - searchTypeAction 搜索栏标签
- (void)searchTypeAction:(UIButton *)btn
{
    self.selectBtn = btn;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.view addSubview:self.popBgView];
        [self.view addSubview:self.popView];
    }else
    {
        [self.popBgView removeFromSuperview];
        [self.popView removeFromSuperview];
    }
}
- (void) searchPostsAction{
    
}
- (void)removePopView:(UITapGestureRecognizer *)g
{
    [g.view removeFromSuperview];
    [self.popView removeFromSuperview];
    self.selectBtn.selected = NO;
}
- (void) forumButtonAction:(UIButton *) btn{
    self.navLabel.text = @"帖子";
    self.selectBtn.selected = NO;
    [self.popBgView removeFromSuperview];
    [self.popView removeFromSuperview];
}
- (void) courseButtonAction:(UIButton *) btn {
    self.navLabel.text = @"说说";
    self.selectBtn.selected = NO;
    [self.popBgView removeFromSuperview];
    [self.popView removeFromSuperview];
}
- (void)createTableView
{
    UIView *tagContentV = [[UIView alloc] init];
    _tagContentV = tagContentV;
    tagContentV.backgroundColor = [UIColor whiteColor];
    tagContentV.frame = CGRectMake(0, 45, kViewWidth, 155);
   
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kViewWidth, kViewHeight-50-44) style:UITableViewStylePlain];
    _tbView.separatorColor = kViewBackColor;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    ///设置头部View的大小
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.00f)];
    
    [self.view addSubview:_tbView];
    [self addTagToConentV:tagContentV];
    _tbView.tableHeaderView = tagContentV;
}

- (void) addTagToConentV:(UIView *) v{
    CGFloat margin = 8;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, 18, 18)];
    [v addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"icon_bankuai"];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame) + 2, margin, 60, 18)];
    [v addSubview: lbl];
    lbl.text = @"子版块";
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont systemFontOfSize:20];

    CGFloat btnW = (kViewWidth - 4 *margin) / 3;
    CGFloat btnH = 50;
    CGFloat btnX;
    CGFloat btnY;
    NSArray *tagArray = [NSArray arrayWithObjects:@"摄影专区",@"科技专区",@"艺术专区",@"其他",@"其他",@"其他", nil];
    for (int i = 0; i < tagArray.count; i ++ ) {
        UIButton *tagbtn = [[UIButton alloc] init];
        [v addSubview:tagbtn];
        if (i < 3) {
            btnX = margin *(i + 1) + btnW * i;
            btnY = margin + 30;
        } else {
            btnX = margin * (i%3 + 1) + btnW *(i%3);
            btnY = 2 * margin + btnH + 30;
        }
        tagbtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tagbtn.backgroundColor = [UIColor lightGrayColor];
        [tagbtn setTitle:tagArray[i] forState:UIControlStateNormal];
        [tagbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tagbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tagbtn.tag = i;
        [tagbtn setBackgroundImage:[UIImage imageNamed:@"bankuaiImg"] forState:UIControlStateNormal];
        [tagbtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void) tagBtnClicked:(UIButton *) btn{
    
    switch (btn.tag) {
        case 0: {
            MyPostController *controller = [[MyPostController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
        case 1: {
            ClassifyPostController *controller = [[ClassifyPostController alloc] init];
            controller.navTitle = btn.titleLabel.text;
            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
        case 2: {
            CreatingNewClassController *controller = [[CreatingNewClassController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            
            break;
       
        default:
            break;
    }
    
}
///返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        static NSString *cellID = @"CollectPostCellID";
        CollectPostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectPostCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    
    UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kViewWidth, 30)];
    [headerView addSubview:contentV];
    contentV.backgroundColor = [UIColor whiteColor];
    UIImageView *imagV = [[UIImageView alloc] init];
    [contentV addSubview:imagV];
    imagV.frame = CGRectMake(10, 10, 15, 18);
    imagV.image = [UIImage imageNamed:@"movieSchool_fire"];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imagV.frame) + 2, 10, 80, 18)];
    [contentV addSubview:lbl];
    lbl.text = @"热门帖子";
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont systemFontOfSize:18];
    
}


/// 点击按钮执行的动画和参数的变化
//- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
//{
//    _btnType = btnType;
//    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _selectedBtn = selectedBtn;
//    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [UIView animateWithDuration:0.2 animations:^{
//        _btnLine.center = CGPointMake(_selectedBtn.center.x, 45);
//    }];
//    
//    [_tbView reloadData];
//}

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

#pragma mark textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.searchTextField becomeFirstResponder]) {
        BBSSearchController *searchVC = [[BBSSearchController alloc] init];
        [self.navigationController pushViewController:searchVC animated:YES];
        [self.searchTextField resignFirstResponder];
    }
}

@end
