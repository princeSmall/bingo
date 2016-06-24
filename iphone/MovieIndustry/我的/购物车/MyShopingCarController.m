//
//  MyShopingCarController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyShopingCarController.h"

@interface MyShopingCarController ()

@end

@implementation MyShopingCarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加加载中View
    [self createLoadingView];
}

- (void)createLoadingView
{
    UIImageView *loadingImage = [WNController createImageViewWithFrame:CGRectMake(0, 120-64, 130, 130) ImageName:@"loading"];
    [self.view addSubview:loadingImage];
    
    loadingImage.center = CGPointMake(kViewWidth/2, loadingImage.center.y);
    
    UILabel *loadigLabel = [WNController createLabelWithFrame:CGRectMake(0, 275-64, 143, 21) Font:18 Text:@"加载中 ..." textAligment:NSTextAlignmentCenter];
    loadigLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1];
    [self.view addSubview:loadigLabel];
    loadigLabel.center = CGPointMake(kViewWidth/2, loadigLabel.center.y);
    
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
