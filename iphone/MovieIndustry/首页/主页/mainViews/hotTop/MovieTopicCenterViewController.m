//
//  MovieTopicCenterViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#define ARTICLE_URL @"http://kamefilm.uj345.net/dian.php/Home/Faxian/jingtou"
#import "MovieTopicCenterViewController.h"
#import "MovieTopicTitleCell.h"
#import "MovieUserTopicDetailCell.h"

@interface MovieTopicCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *mainTableView;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation MovieTopicCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"摄影展"];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,kViewWidth-1,1)];
    [self.webView setScalesPageToFit:YES];
    //    self.webView.scrollView.pagingEnabled = NO;
    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kamefilm.uj345.net/dian.php/Home/Faxian/jingtou"]]];
    
    [self.view addSubview:self.webView];
}


#pragma mark -- 创建表格视图
- (void)createTopicView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MovieTopicTitleCell *titleCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieTopicTitleCell" owner:self options:nil] lastObject];
        return titleCell;
    }
    else
    {
        static NSString *cellID = @"goodCellIdentifier";
        MovieUserTopicDetailCell *infoCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (infoCell == nil) {
            infoCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieUserTopicDetailCell" owner:self options:nil] lastObject];
        }
        
        return infoCell;
    }
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
    return (indexPath.section==0)?90:260;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
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
