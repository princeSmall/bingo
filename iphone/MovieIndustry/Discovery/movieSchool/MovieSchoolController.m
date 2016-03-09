//
//  MovieSchoolController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieSchoolController.h"
#import "SDCycleScrollView.h"
#import "MovieSchoolCell.h"
#import "MovieNewsController.h"
#import "MovieClassesController.h"
@interface MovieSchoolController () <UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,MovieSchoolCellDelegate>
@property (weak,nonatomic) UITableView *tableView;
@end

@implementation MovieSchoolController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"电影学院"];
    [self creatTableView];
}
- (void) creatTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //设置头部View的大小
    UIView *tbHeaderView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 158)];
    //
    UIImage * image1 = [UIImage imageNamed:@"zhouerqiang"];
    UIImage * image2 = [UIImage imageNamed:@"changdi"];
    UIImage * image3 = [UIImage imageNamed:@"dianpu"];
   
    
    NSArray * imageArray = @[image1,image2,image3];
    SDCycleScrollView * bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kViewWidth, 158) imagesGroup:imageArray];
    
    bannerView.delegate = self;
    bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    //添加到头部视图
    [tbHeaderView addSubview:bannerView];
    
    //设置tableView的头部视图
    tableView.tableHeaderView = tbHeaderView;

}
#pragma mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 1;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 136;
    }
    return 102;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 0) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieSchoolCell" owner:nil options:nil] lastObject];
        MovieSchoolCell *schoolCell = (MovieSchoolCell *) cell;
        schoolCell.delegate = self;
    } else if (indexPath.section == 1){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieSchool_NewsCell" owner:nil options:nil] lastObject];
    } else {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieSchool_ClassesCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headV = [[UIView alloc] init];
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movieSchool_horn"]];
        imgV.frame = CGRectMake(10, 5, 10, 18);
        [headV addSubview:imgV];
        headV.backgroundColor = kViewBackColor;
        UILabel *lbl = [[UILabel alloc] init];
        lbl.textColor = [UIColor darkGrayColor];
        lbl.font = [UIFont systemFontOfSize:13];
        CGFloat lblX = CGRectGetMaxX(imgV.frame) + 5;
        lbl.frame = CGRectMake(lblX, 0, kViewWidth - lblX, 30);
        [headV addSubview:lbl];
        lbl.text = @"公告:显示公告";
        return headV;
    } else {
        UIView *headV = [[UIView alloc] init];
        headV.backgroundColor = kViewBackColor;
        UIButton *btn = [[UIButton alloc] init];
        CGFloat btnW  = 150;
        CGFloat btnH = 30;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.frame = CGRectMake(kViewWidth * 0.5 - 75, 0, btnW, btnH);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [headV addSubview:btn];
        if (section == 1) {
            [btn setTitle:@"精品课程TOP10" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"movieSchool_fire"] forState:UIControlStateNormal];
        } else {
            [btn setTitle:@"电影资讯TOP10" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"fire_black"] forState:UIControlStateNormal];
        }
        return headV;
    }
    return nil;
}
#pragma mark schoolCellDelegate
- (void)MovieNewsCell:(MovieSchoolCell *)cell movieClassBtn:(UIButton *)btn {
    MovieClassesController *classVC = [[MovieClassesController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
}
- (void)MovieNewsCell:(MovieSchoolCell *)cell movieNewsBtn:(UIButton *)btn {
    MovieNewsController *newsVC = [[MovieNewsController alloc] init];
    [self.navigationController pushViewController:newsVC animated:YES];
}
@end
