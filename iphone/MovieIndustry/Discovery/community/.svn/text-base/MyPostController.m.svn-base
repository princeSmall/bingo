//
//  MyPostController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/3.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MyPostController.h"
#import "MyPostCell.h"
@interface MyPostController () <UITableViewDelegate,UITableViewDataSource> {
    ///选中的按钮
    UIButton *_selectedBtn;
    
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表我的帖子 1 代表我的评价
    
    NSString *_btnType;
}

@end

@implementation MyPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"我的帖子"];
    [self creatUI];
}

- (void) creatUI{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 45)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(kViewWidth/5, 43, kViewWidth/5  + 40, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/2, 45) ImageName:@"" Target:self Action:@selector(myBBSAction:) Title:@"我的帖子" fontSize:15];
    
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _btnLine.center = CGPointMake(_selectedBtn.center.x, 45);
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2, 0, kViewWidth/2, 45) ImageName:@"" Target:self Action:@selector(myEvaluateAction:) Title:@"我的评价" fontSize:15];
    [btnView addSubview:btn2];
    [self createTableView];
}
- (void)createTableView
{
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kViewWidth, kViewHeight-60-44) style:UITableViewStylePlain];
    _tbView.separatorColor = kViewBackColor;
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
  
    
    [self.view addSubview:_tbView];
}
#pragma mark - 我的帖子
- (void)myBBSAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(0, 44, kViewWidth/5, 2)];
  
}

#pragma mark - 我的消息
- (void)myEvaluateAction:(UIButton *)btn
{
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(0, 44, kViewWidth/5, 2)];
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
///返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    return 69;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"myPostCell";
    MyPostCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyPostCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
