//
//  PushSuccessViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/1/28.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "PushSuccessViewController.h"

@interface PushSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIView *successView;


@end

@implementation PushSuccessViewController
- (IBAction)successBtnClick:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.successView.layer.cornerRadius = 5;
    self.successView.layer.masksToBounds = YES;
    
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
