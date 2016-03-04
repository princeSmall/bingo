//
//  ClassifyPostDetailController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ClassifyPostDetailController.h"
#import "ClassifyPostDetailHeadCell.h"
#import "BottomInputView.h"
@interface ClassifyPostDetailController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}

@end

@implementation ClassifyPostDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"帖子详细"];
    [self creatUI];
    
}
- (void) creatUI {
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 0, kViewWidth, kViewHeight - 50);
    BottomInputView *bottomInputV = [[BottomInputView alloc] init];
    [self.view addSubview:bottomInputV];
}
#pragma mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ClassifyPostDetailHeadCell";
    ClassifyPostDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyPostDetailHeadCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}
@end
