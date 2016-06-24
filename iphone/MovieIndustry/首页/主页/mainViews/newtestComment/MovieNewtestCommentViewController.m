//
//  MovieNewtestCommentViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieNewtestCommentViewController.h"
#import "MovieNewCommentCell.h"
#import "ModelArticleCommentModel.h"

@interface MovieNewtestCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *mainTableView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,retain) NSMutableArray *dataArray;

@property (nonatomic,assign) int page;




@end

@implementation MovieNewtestCommentViewController

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"最新评论"];
    [self createNetestCommentView];
    [self setupCommentListRefresh];
}

- (void)createNetestCommentView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44-50) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    [self createBottomInputeView];
}


#pragma mark - 创建底部输入框
- (void)createBottomInputeView
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kViewHeight-50-44, kViewWidth, kViewHeight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth,1)];
    line.backgroundColor=RGBColor(212,212,212,0.5);
    [self.bottomView addSubview:line];
    
    //相机按钮
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(7,10,36,27);
    [cameraBtn setImage:[UIImage imageNamed:@"evaluation_camera"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(takePhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:cameraBtn];
    
    //输入框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50,10, kViewWidth-130, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.bottomView addSubview:textField];
    
    //发布按钮
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake(kViewWidth-70, 10, 60, 30);
    [publishBtn setTitle:@"原文" forState:UIControlStateNormal];
    publishBtn.clipsToBounds = YES;
    publishBtn.layer.cornerRadius = 5.0f;
    publishBtn.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
    publishBtn.layer.borderWidth = 1.0f;
    [publishBtn setTitleColor:RGBColor(249, 111, 11, 1) forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [publishBtn addTarget:self action:@selector(artcleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:publishBtn];
    
    
    [self.view addSubview:self.bottomView];
}

- (void)artcleAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyBoardDown
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
}


#pragma mark - 拍照
- (void)takePhotoBtnClicked:(UIButton *)button
{
    NSLog(@"拍照按钮被点击");
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"goodCellIdentifier";
    MovieNewCommentCell *infoCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (infoCell == nil) {
        infoCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieNewCommentCell" owner:self options:nil] lastObject];
    }
    
    ModelArticleCommentModel *commentModel = _dataArray[indexPath.row];
    [infoCell setCommentModel:commentModel];
    
    infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return infoCell;
}


#pragma mark -- UITableViewDelegate
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

#pragma mark - 添加上下拉刷新
- (void)setupCommentListRefresh
{
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        _page = 1;
        [self requestArticleCommentlistInfo];
    }];
    
    [self.mainTableView.header beginRefreshing];
    
    self.mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        _page++;
        [self requestArticleCommentlistInfo];
    }];
}


- (void)requestArticleCommentlistInfo
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    self.articleId = @"8";
    
    [MovieHttpRequest createArticleCommentListWithArticleId:self.articleId andPage:_page CallBack:^(id obj) {
        
        HUD.labelText = @"加载成功";
        [HUD hide:YES];
        
        if (1 == _page) {
            self.dataArray = [NSMutableArray arrayWithArray:obj];
            
        }else{
            [self.dataArray addObjectsFromArray:obj];
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
