//
//  PassGrapViewController.m
//  MovieIndustry
//
//  Created by aaa on 16/1/28.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "PassGrapViewController.h"
#import "PassGrapTableViewCell.h"

@interface PassGrapViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation PassGrapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PassGrapTableViewCell * cell = [[PassGrapTableViewCell alloc]initWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 202;
}



@end
