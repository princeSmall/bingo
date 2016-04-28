//
//  RankingListController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/13.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "RankingListController.h"
#import "BestLikeRankingController.h"
#import "YearRankingController.h"
#import "FamousTeacherController.h"

@interface RankingListController ()

@end

@implementation RankingListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"排行榜"];
    [self createUI];
}

- (void)createUI
{
    ///10 是当前留下的空隙
    CGFloat myViewH = kViewHeight-44-10;
    NSArray *imageArr = @[@"rankingList_02",@"rankingList_04",@"rankingList_06"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [WNController createButtonWithFrame:CGRectMake(0, i*myViewH/3+i*5, kViewWidth, myViewH/3) ImageName:imageArr[i] Target:self Action:@selector(rankingListAction:) Title:@""];
        btn.tag = 100+i;
        
//        if (btn.tag == 100) {
//            btn.frame = CGRectMake(0, i*myViewH/3, kViewWidth, myViewH/3);
//        }
        
        
        [self.view addSubview:btn];
    }
}

#pragma mark - 排行榜点击
- (void)rankingListAction:(UIButton *)btn
{
    ///年度排行榜
    if (btn.tag == 100) {
        YearRankingController *yearRanVc = [[YearRankingController alloc] init];
        [self.navigationController pushViewController:yearRanVc animated:YES];
    }
    //最受欢迎 Top10
    if (btn.tag == 101) {
        BestLikeRankingController *bestVc = [[BestLikeRankingController alloc] init];
        [self.navigationController pushViewController:bestVc animated:YES];
    }
    
    //名师排行榜
    if (btn.tag == 102) {
        FamousTeacherController *famousVc = [[FamousTeacherController alloc] init];
        [self.navigationController pushViewController:famousVc animated:YES];
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
