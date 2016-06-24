//
//  MovieCommentListViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/30.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieCommentListViewController.h"
#import "FourTableViewCell.h"
#import "MovieCommentViewController.h"
#import "SysTool.h"


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
     OrderGoodsModel * model = [[OrderGoodsModel alloc] initWithDict:self.goodsArray[indexPath.row] ];
    MovieCommentViewController * commView = [[MovieCommentViewController alloc]init];
    commView.isList = @"1";
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"order_id"] = model.order_id;
    dict[@"shop_id"] = model.shop_id;
    dict[@"goods_id"] = model.goods_id;
    dict[@"goods_name"] = model.goods_name;
    dict[@"goods_number"] = model.goods_number;
    dict[@"goods_price"] = model.goods_price;
    dict[@"name_value_str"] = model.name_value_str;
    dict[@"img_path"] = model.img_path;
    dict[@"goods_deposit"] = model.goods_deposit;
    dict[@"is_deposit"] = model.is_deposit;
    dict[@"is_refund"] = model.is_refund;
    commView.goodsModel = dict;
    
    commView.block = ^(BOOL ok){
    
        if (ok) {
            NSMutableArray * arra = [NSMutableArray arrayWithArray:self.goodsArray];
            [arra removeObjectAtIndex:indexPath.row];
            self.goodsArray = arra;
            [self.tableView reloadData];
        };
    };
    
    [self.navigationController pushViewController:commView animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(self.goodsArray.count ==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
