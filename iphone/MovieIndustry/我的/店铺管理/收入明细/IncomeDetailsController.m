//
//  IncomeDetailsController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "IncomeDetailsController.h"
#import "MovieIncomeDetailCell.h"
#import "MovieIncomeDetailModel.h"


@interface IncomeDetailsController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *mainTableView;

/** 收入明细状态 1:收入  2:提现*/
@property (nonatomic,assign) BOOL isIncome;

/** 时间状态 1:昨天  2:本周  3:上月  4:全部 */
@property (nonatomic,copy) NSString *timeStatue;

@property (nonatomic,retain) UIButton *incomSelectedBtn;
@property (nonatomic,retain) UIButton *timeSelecteBtn;

/** 数据数组 */
@property (nonatomic,retain) NSMutableArray *incomeArray;


@end

@implementation IncomeDetailsController

- (NSMutableArray *)incomeArray
{
    if (nil == _incomeArray) {
        _incomeArray = [NSMutableArray new];
    }
    return _incomeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTabBar:@"收支明细"];
    [self createMineIncomeMainViews];
    [self requestMineIncomeDetailDatas];
}

- (void)createMineIncomeMainViews
{
    // 收入 -- 提现
    _isIncome = YES;
    
    UIView *segemetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40.0f)];
    segemetView.backgroundColor = [UIColor whiteColor];
    
    NSArray *segementTitleArray = @[@"收入",@"提现"];
    NSInteger segementCount = segementTitleArray.count;
    CGFloat buttonW = screenWidth/segementCount;
    
    for (int i = 0; i < segementCount;i++) {
        
        NSString *title = segementTitleArray[i];
        CGRect buttonFrame = CGRectMake(buttonW*i,0, buttonW, 38.0f);
        UIButton *segmentBtn = [self createSegmentButtonWithFrame:buttonFrame andTitle:title];
        segmentBtn.tag = 300 + i;
        
        if (0 == i) {
            segmentBtn.selected = YES;
            self.incomSelectedBtn = segmentBtn;
        }
        
        [segmentBtn addTarget:self action:@selector(switchInComeAndDrawMoney:) forControlEvents:UIControlEventTouchUpInside];
        [segemetView addSubview:segmentBtn];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20.0f,38.0f,buttonW-40.0f, 2.0f)];
    line.backgroundColor = [UIColor redColor];
    line.tag = 400;
    [segemetView addSubview:line];
    
    [self.view addSubview:segemetView];
    
    // 昨天 - 本周 - 本月 - 全部
    UIView *timeSegmentView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(segemetView.frame)+1, screenWidth, 40.0f)];
    timeSegmentView.backgroundColor = [UIColor whiteColor];
    
    NSArray *timeArray = @[@"昨天",@"本周",@"本月",@"全部"];
    NSInteger chooseCount = timeArray.count;
    CGFloat timeBtnW = screenWidth/chooseCount;
    for (int i =0; i < chooseCount; i++) {
        
        NSString *title = timeArray[i];
        CGRect btnFrame = CGRectMake(timeBtnW*i,0, timeBtnW, 38.0f);
        UIButton *timeChooseBtn = [self createSegmentButtonWithFrame:btnFrame andTitle:title];
        timeChooseBtn.tag = 600 + i;
        
        if (0 == i) {
            timeChooseBtn.selected = YES;
            self.timeSelecteBtn = timeChooseBtn;
            self.timeStatue = @"1";
        }
        
        [timeChooseBtn addTarget:self action:@selector(changeTimeChooseStatuesAction:) forControlEvents:UIControlEventTouchUpInside];
        [timeSegmentView addSubview:timeChooseBtn];
    }
    
    [self.view addSubview:timeSegmentView];
    
    [self createIncomeDetailTableView];
}

- (void)createIncomeDetailTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 82, screenWidth, screenHeight-82-64) style:UITableViewStylePlain];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview: self.mainTableView];
}

- (UIButton *)createSegmentButtonWithFrame:(CGRect)buttonFrame andTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = buttonFrame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    button.titleLabel.font = DefaultFont;
    return button;
}


#pragma mark - 切换时间选择
- (void)changeTimeChooseStatuesAction:(UIButton *)button
{
    self.timeSelecteBtn.selected = NO;
    button.selected = YES;
    self.timeSelecteBtn = button;
    
    [self.incomeArray removeAllObjects];
    [self.mainTableView reloadData];
    
     NSInteger index = button.tag - 600;
    HHNSLog(@"切换到 --> %zd",index);
    
    switch (index) {
        case 0:
        {
            self.timeStatue = @"1";
            [self requestMineIncomeDetailDatas];
        }
            break;
        case 1:
        {
            self.timeStatue = @"2";
            [self requestMineIncomeDetailDatas];
        }
            break;
        case 2:
        {
            self.timeStatue = @"3";
            [self requestMineIncomeDetailDatas];
        }
            break;
        case 3:
        {
            self.timeStatue = @"4";
            [self requestMineIncomeDetailDatas];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 切换收入/提现
- (void)switchInComeAndDrawMoney:(UIButton *)button
{
    self.incomSelectedBtn.selected = NO;
    button.selected = YES;
    self.incomSelectedBtn = button;
    
    [self.incomeArray removeAllObjects];
    [self.mainTableView reloadData];
    
    NSInteger index = button.tag - 300;
    UIView *line = [button.superview viewWithTag:400];
    
    CGFloat viewWidth = screenWidth/2;

    if (0 == index) {  //切换到收入
        _isIncome = YES;
        [UIView animateWithDuration:0.3 animations:^{
           
            CGRect lineFrame = line.frame;
            lineFrame.origin.x = 20;
            line.frame = lineFrame;
        }];
        [self requestMineIncomeDetailDatas];
    }
    else{
        _isIncome = NO;
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect lineFrame = line.frame;
            lineFrame.origin.x = viewWidth + 20;
            line.frame = lineFrame;
        }];
        [self requestMineIncomeDetailDatas];
    }
}


#pragma mark - 请求我的收入明细数据
- (void)requestMineIncomeDetailDatas
{
    NSString *segemetStatue = [NSString stringWithFormat:@"%zd",(_isIncome)?1:2]; //1:收入  2:提现
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createMineIncomeDetailWithTime:self.timeStatue andSegmentStatue:segemetStatue CallBack:^(id obj) {
        
        [HUD hide:YES];
        
        self.incomeArray = [NSMutableArray arrayWithArray:obj];
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
       
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.incomeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIdentifier";
    MovieIncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieIncomeDetailCell" owner:self options:nil] lastObject];
    }
    
    MovieIncomeDetailModel *model = _incomeArray[indexPath.row];
    [cell setIncomeModel:model];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    MovieManagerGoodsModel *model;
//    
//    if (0 == _chooseIndex) {
//        model = _allGoodsArray[indexPath.section];
//    }
//    else{
//        model = _rentGoodsArray[indexPath.section];
//    }
//    
//    MovieGoodsInfoViewController *goodInfoVC = [[MovieGoodsInfoViewController alloc] init];
//    goodInfoVC.shopID = model.locationId;
//    goodInfoVC.goodsId = model.goodId;
//    [self.navigationController pushViewController:goodInfoVC animated:YES];
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
