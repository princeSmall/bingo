//
//  MoviePrivacyViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/30.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MoviePrivacyViewController.h"
#import "MovieReportViewController.h"


@interface MoviePrivacyViewController ()

@end

@implementation MoviePrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"隐私"];
    [self initPrivacyView];
}

- (void)initPrivacyView
{
    self.view.backgroundColor = BGColor;
    self.tableView.backgroundColor = BGColor;
}


#pragma mark - 是否允许陌生人查看相册
- (IBAction)allowStrangerVisitMyAlbum:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        //允许访问
        HHNSLog(@"允许陌生人访问");
    }
    else{
        //不允许访问
        HHNSLog(@"不允许陌生人访问");
    }
}

#pragma mark - UITableViewCellDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth,10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (3 == indexPath.section) {
        MovieReportViewController *reportVC = [[MovieReportViewController alloc] init];
        [self.navigationController pushViewController:reportVC animated:YES];
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
