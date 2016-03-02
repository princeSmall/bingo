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
@interface DiscoverBBSController ()<UITableViewDelegate,UITableViewDataSource>
{
    ///选中的按钮
    UIButton *_selectedBtn;
    
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表好友消息 1 代表发布的需求 2 代表收到的需求 3 代表通知
    NSString *_btnType;
    
    // 标签容器
    UIView *_tagContentV;
    NSInteger msgType;
}
@end

@implementation DiscoverBBSController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"社区"];
    [self createUI];
}

- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 45)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(kViewWidth/5, 44, kViewWidth/5 + 40, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/2, 45) ImageName:@"" Target:self Action:@selector(myBBSAction:) Title:@"我的帖子" fontSize:15];
    
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _btnLine.center = CGPointMake(_selectedBtn.center.x, 45);
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2, 0, kViewWidth/2, 45) ImageName:@"" Target:self Action:@selector(myMesAction:) Title:@"我的消息" fontSize:15];
    [btnView addSubview:btn2];
    
    [self createTableView];
}

- (void)createTableView
{
    UIView *tagContentV = [[UIView alloc] init];
    _tagContentV = tagContentV;
    [self.view addSubview:tagContentV];
    [self addTagToConentV:tagContentV];
    tagContentV.backgroundColor = kViewBackColor;
    tagContentV.frame = CGRectMake(0, 45, kViewWidth, 80);
   
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, kViewWidth, kViewHeight-150-44) style:UITableViewStylePlain];
    _tbView.separatorColor = kViewBackColor;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    ///设置头部View的大小
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.00f)];
    
    [self.view addSubview:_tbView];
}

#pragma mark - 我的帖子
- (void)myBBSAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(0, 44, kViewWidth/5, 2)];
    [self.view addSubview:_tagContentV];
    _tbView.frame = CGRectMake(0, 150, kViewWidth, kViewHeight-150-44);
}

#pragma mark - 我的消息
- (void)myMesAction:(UIButton *)btn
{
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(0, 44, kViewWidth/5, 2)];
    [_tagContentV removeFromSuperview];
    _tbView.frame = CGRectMake(0, 45, kViewWidth, kViewHeight-45-44);
}
- (void) addTagToConentV:(UIView *) v{
    CGFloat margin = 10;
    CGFloat btnW = (kViewWidth - 4 *margin) / 3;
    CGFloat btnH = 40;
    CGFloat btnX;
    CGFloat btnY;
    NSArray *tagArray = [NSArray arrayWithObjects:@"摄影",@"科技",@"艺术",@"其他",@"其他",@"其他", nil];
    for (int i = 0; i < tagArray.count; i ++ ) {
        UIButton *tagbtn = [[UIButton alloc] init];
        [v addSubview:tagbtn];
        if (i < 3) {
            btnX = margin *(i + 1) + btnW * i;
            btnY = margin;
        } else {
            btnX = margin * (i%3 + 1) + btnW *(i%3);
            btnY = 2 * margin + btnH;
        }
        tagbtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tagbtn.backgroundColor = [UIColor whiteColor];
        [tagbtn setTitle:tagArray[i] forState:UIControlStateNormal];
        [tagbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagbtn.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:15];
        tagbtn.tag = i;
        [tagbtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void) tagBtnClicked:(UIButton *) btn {
    
}
///返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_btnType isEqualToString:@"1"]) {
        
        if (msgType == 0) {
            return 114;
        } else {
            return 132;
        }
        
    }
    
    return 68;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_btnType isEqualToString:@"0"]) {
        static NSString *cellID = @"CollectPostCellID";
        CollectPostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectPostCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([_btnType isEqualToString:@"1"]) // 消息
    {
        // 需区分是系统消息还是其他消息
        static NSString *cellID = @"NotisMesCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {

            if (indexPath.row %2 == 0) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NotisMesCell" owner:nil options:nil] lastObject];
                msgType = 0;
            } else {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendsMesCell" owner:nil options:nil] lastObject];
                msgType = 1;
            }
            
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString *cellID = @"teacherCellID";
    CollectPostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectPostCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}




/// 点击按钮执行的动画和参数的变化
- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
{
    _btnType = btnType;
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = selectedBtn;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.center = CGPointMake(_selectedBtn.center.x, 45);
    }];
    
    [_tbView reloadData];
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



@end
