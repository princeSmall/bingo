//
//  TeacherDetialMsgController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "TeacherDetialMsgController.h"
#import "CollectCourseCell.h"
@interface TeacherDetialMsgController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *privaBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *msgContentV;


@end

@implementation TeacherDetialMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"王佳佳"];
    
    ViewBorderRadius(self.iconV, 35, 2, [UIColor whiteColor]);
    ViewBorderRadius(self.levelBtn, 9, 0, [UIColor whiteColor]);
    ViewBorderRadius(self.attentionBtn, 5, 1, [UIColor whiteColor]);
    ViewBorderRadius(self.privaBtn, 5, 1, [UIColor whiteColor]);
    [self creatTableView];
}

- (void) creatTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.msgContentV.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(50);
    }];
}
#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"detailMsgCell";
    CollectCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectCourseCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *hView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 26)];
    hView.backgroundColor = kViewBackColor;
    UILabel *label = [WNController createLabelWithFrame:CGRectMake(6,3,128, 21) Font:15 Text:@"相关课程" textAligment:NSTextAlignmentLeft];
    label.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1];
    [hView addSubview:label];
    return hView;
    
    
}
@end
