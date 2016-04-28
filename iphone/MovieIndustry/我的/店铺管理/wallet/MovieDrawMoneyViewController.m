//
//  MovieDrawMoneyViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieDrawMoneyViewController.h"

@interface MovieDrawMoneyViewController ()

@end

@implementation MovieDrawMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"提现"];
}




#pragma mark - 申请提现
- (IBAction)applyDrawMineMoneyAction:(UIButton *)sender {
    
    NSLog(@"申请提现");
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
