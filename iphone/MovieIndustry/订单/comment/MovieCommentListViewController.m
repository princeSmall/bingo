//
//  MovieCommentListViewController.m
//  MovieIndustry
//
//  Created by aaa on 16/3/30.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieCommentListViewController.h"
#import "FourTableViewCell.h"
#import "MovieCommentViewController.h"

@interface MovieCommentListViewController ()
@end


@implementation MovieCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"选择评价页面"];
    [self setBackAction];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)setBackAction{

    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.goodsArray.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     FourTableViewCell * cell = [[FourTableViewCell alloc]initWithTableView:tableView];
     NSDictionary * dict = self.goodsArray[indexPath.row];
     [cell.myIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,dict[@"img_path"]]]];
     cell.myLabel.text = dict[@"goods_name"];
     cell.myPrice.text = dict[@"goods_price"];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
 return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     OrderGoodsModel * model = self.goodsArray[indexPath.row];
    MovieCommentViewController * commView = [[MovieCommentViewController alloc]init];
    commView.goodsModel = model;
    [self.navigationController pushViewController:commView animated:YES];
}

@end
