//
//  MovieClassesController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieClassesController.h"
#import "FlowMenu.h"
#import "BestCourse_Total_Controller.h"
#import "test1ViewController.h"
#import "test2ViewController.h"
#import "test3ViewController.h"
#import "test4ViewController.h"
@interface MovieClassesController ()

@end

@implementation MovieClassesController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"精品课程"];
    NSArray *viewControllers = @[@{@"全部":[[BestCourse_Total_Controller alloc] init]},@{@"分类1":[[test1ViewController alloc] init]},@{@"分类2":[[test2ViewController alloc] init]},@{@"分类3":[[test3ViewController alloc] init]},@{@"分类4":[[test4ViewController alloc] init ]}];
    
    FlowMenu * view = [[FlowMenu alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight) WithViewControllers:viewControllers];
    view.fatherController = self;
//    view.vcArray = viewControllers;
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];


}
@end
