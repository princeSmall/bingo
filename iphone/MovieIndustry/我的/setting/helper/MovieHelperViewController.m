//
//  MovieHelperViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/28.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieHelperViewController.h"
#import "MovieHelperListModel.h"
#import "MovieHelperDetailViewController.h"
#import "FeedbackViewController.h"

@interface MovieHelperViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITextField *searchField;
@property (nonatomic,retain) UITableView *mainTableView;

@property (nonatomic,assign) int page;

@property (nonatomic,retain) NSMutableArray *questionArray;


@end

@implementation MovieHelperViewController

- (NSMutableArray *)questionArray
{
    if (nil == _questionArray) {
        _questionArray = [NSMutableArray new];
    }
    return _questionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"帮助与反馈"];
    [self createHeplerView];
    [self setMainTableViewRefresh];
}

- (void)createHeplerView
{

    
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
//    UILabel *normalQuestionLab = [DeliveryUtility createLabelFrame:CGRectMake(10,5,80,21) title:@"常见问题" textAlignment:NSTextAlignmentLeft];
//    normalQuestionLab.font = [UIFont systemFontOfSize:15.0f];
//    normalQuestionLab.textColor = RGBColor(135, 135, 135, 1);
//    [headerView addSubview:normalQuestionLab];
    
    UIView *feedBackView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 45)];
    UILabel *feedBackLabel = [WNController createLabelWithFrame:CGRectMake(15, 7, 100, 30) Font:16 Text:@"意见反馈" textAligment:NSTextAlignmentLeft];
    UIView *line = [WNController createViewFrame:CGRectMake(0, 44, kViewWidth, 1)];
    line.backgroundColor = kViewBackColor;
    [feedBackView addSubview:line];
    
    [feedBackView addSubview:feedBackLabel];
    feedBackView.userInteractionEnabled = YES;
    
    UIButton *feedBackButton = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth, 45) ImageName:@"" Target:self Action:@selector(feedBackButtonAction) Title:@"" fontSize:10];
    [feedBackView addSubview:feedBackButton];
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mainTableView];
    
    self.view.backgroundColor = BGColor;
    self.mainTableView.backgroundColor = BGColor;
    //tableView头视图
    self.mainTableView.tableHeaderView = feedBackView;
}

#pragma mark - 意见反馈
- (void)feedBackButtonAction
{
    FeedbackViewController *feedBAckVc = [[FeedbackViewController alloc] init];
    [self.navigationController pushViewController:feedBAckVc animated:YES];
    
}


- (void)helperViewKeyboardDown
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
    [self.searchField resignFirstResponder];
}


#pragma mark - 请求常见问题数据
- (void)requestCommonQuestionListDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD hide:YES];
    
    [MovieHttpRequest createHelpNormalQuestionlistWithPage:_page andKeyword:@"" CallBack:^(id obj) {
        
        [HUD hide:YES];
        
        if (1 == _page) {
            self.questionArray = [NSMutableArray arrayWithArray:obj];
        }
        else{
            [self.questionArray addObjectsFromArray:obj];
        }
        
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"heplerCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    MovieHelperListModel *model = _questionArray[indexPath.row];
    cell.textLabel.text = model.title;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self helperViewKeyboardDown];
    
    MovieHelperListModel *model = _questionArray[indexPath.row];
    MovieHelperDetailViewController *detailVC = [[MovieHelperDetailViewController alloc] init];
    detailVC.heperId = model.helperId;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self helperViewKeyboardDown];
    return YES;
}



#pragma mark - 添加上下拉刷新
- (void)setMainTableViewRefresh
{
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self requestCommonQuestionListDatas];
    }];
    
    [self.mainTableView.header beginRefreshing];
    
    self.mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        [self requestCommonQuestionListDatas];
    }];
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
