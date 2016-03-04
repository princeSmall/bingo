//
//  ClassifyPostController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "ClassifyPostController.h"
#import "ClassifyHeadCell.h"
#import "ClassifyPostCell.h"
#import "CreatPostController.h"
#import "ClassifyPostDetailController.h"
@interface ClassifyPostController () <ClassifyHeadCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation ClassifyPostController
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++ ) {
            [_imageArray addObject:@"dog.png"];
        }
    }
    return _imageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackColor;
    [self setNavTabBar:self.navTitle];
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void) creatUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ClassifyHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyHeadCell" owner:nil options:nil] lastObject];
            cell.delegate = self;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        ClassifyPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyPostCell" owner:nil options:nil] lastObject];
            cell.imageArray =  self.imageArray;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 99;
    }
    return 277;
}
#pragma headCellDelegate
- (void) ClassifyHeadCell:(ClassifyHeadCell *)cell postingBtn:(UIButton *)btn {
    CreatPostController *controller = [[CreatPostController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyPostDetailController *controller = [[ClassifyPostDetailController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
