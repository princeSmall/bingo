//
//  MovieReportViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/30.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieReportViewController.h"
#import "MovieReportReasonModel.h"

@interface MovieReportViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong) UITableView *mainTableView;

@property (nonatomic,strong) NSArray *reasonArray;

@end

@implementation MovieReportViewController

- (NSArray *)reasonArray
{
    if (nil == _reasonArray) {
        _reasonArray = [NSArray new];
    }
    return _reasonArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavTabBar:@"举报"];
    [self createTableViews];
    [self requestReportReasonDatas];
}

- (void)createTableViews
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.scrollEnabled = NO;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    UIButton *reportBtn = [DeliveryUtility createBtnFrame:CGRectMake(20,30,kViewWidth-40, 40) title:@"确认举报" andFont:[UIFont systemFontOfSize:17.0f] target:self action:@selector(comfirmRequestToReport)];
    [reportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reportBtn.backgroundColor = [UIColor whiteColor];
    reportBtn.clipsToBounds = YES;
    reportBtn.layer.cornerRadius = 8;
    [footerView addSubview:reportBtn];
    self.mainTableView.tableFooterView = footerView;
    
    //举报须知
    UIButton *notiBtn = [DeliveryUtility createBtnFrame:CGRectMake(20,kViewHeight-100,kViewWidth-40, 40) title:@"举报须知" andFont:[UIFont systemFontOfSize:14.0f] target:self action:@selector(comfirmRequestToReport)];
    notiBtn.titleLabel.textAlignment = 3;
    [notiBtn setTitleColor:RGBColor(44, 85,235, 1) forState:UIControlStateNormal];
    [self.view addSubview:notiBtn];
}

#pragma mark - 请求举报内容列表数据
- (void)requestReportReasonDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createGetReportReasonsCallBack:^(id obj) {
        
        HUD.labelText = @"正在加载";
        [HUD hide:YES];
        
        self.reasonArray = [NSArray arrayWithArray:obj];
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - 确定举报
- (void)comfirmRequestToReport
{
    NSLog(@"确认举报");
//    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.labelText = @"正在发布";
//    [HUD show:YES];
//    
//    [MovieHttpRequest createComfirmSendReportWithReportedId:@"1" andContent:@"" CallBack:^(id obj) {
//        
//        HUD.labelText = @"发布成功";
//        [HUD hide:YES];
//        
//    } andSCallBack:^(id obj) {
//        
//        [HUD hide:YES];
//        [DeliveryUtility showMessage:obj target:self];
//    }];
}

#pragma mark - 举报须知
- (void)ruleOfReporterNeedsKonw
{
    NSLog(@"举报须知");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reasonArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.font = DefaultFont;
    cell.textLabel.textColor = RGBColor(38, 38, 38, 1);
    
    MovieReportReasonModel *model = _reasonArray[indexPath.row];
    cell.textLabel.text = model.value;
    
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
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 30)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [DeliveryUtility createLabelFrame:CGRectMake(10, 5, 200, 21) title:@"请选择举报原因" textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = RGBColor(134, 134, 134, 1);
    [footerView addSubview:label];
    return footerView;
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
