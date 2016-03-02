//
//  PublishTimeLineController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/12.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PublishTimeLineController.h"

@interface PublishTimeLineController ()

@end

@implementation PublishTimeLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"发布"];
    [self setNavRightItem:@"发送" rightAction:@selector(sendFilmAction)];
}

- (void)sendFilmAction
{
    
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
