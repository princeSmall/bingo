//
//  CreatingNewClassController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/4.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "CreatingNewClassController.h"

@interface CreatingNewClassController ()
@property (weak, nonatomic) IBOutlet UIButton *classPostBtn;
@property (weak, nonatomic) IBOutlet UIButton *classClassifyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *classClasssifyVHCT;
@property (nonatomic, assign) BOOL isClassifyBtnClicked;
@property (weak, nonatomic) IBOutlet UIView *classClassifyContentV;

@end

@implementation CreatingNewClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewBorderRadius(self.classPostBtn, 5, 0, [UIColor whiteColor]);
    [self setNavTabBar:@"我要开课"];
    self.isClassifyBtnClicked = NO;
    [self classClassifyBtnClicked:self.classClassifyBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)classPostBtnClicked:(UIButton *)sender {
}
- (IBAction)classClassifyBtnClicked:(UIButton *)sender {
    if (!self.isClassifyBtnClicked) {
        self.isClassifyBtnClicked = !self.isClassifyBtnClicked;
        [UIView animateWithDuration:0.5 animations:^{
            self.classClasssifyVHCT.constant = 0;
            [self.classClassifyContentV layoutIfNeeded];
        }];
    } else {
        self.isClassifyBtnClicked = !self.isClassifyBtnClicked;
        [UIView animateWithDuration:0.5 animations:^{            
            self.classClasssifyVHCT.constant = 81;
            [self.classClassifyContentV layoutIfNeeded];
        }];
       
    }
}


@end
