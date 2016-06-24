//
//  PersonCertificationViewController.m
//  Identifier
//
//  Created by 童乐 Patrick on 1/20/16.
//  Copyright © 2016 @_@. All rights reserved.
//

#import "PersonCertificationViewController.h"
#import "CertificationScrollView.h"

@interface PersonCertificationViewController ()

@end

@implementation PersonCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    titleButton.frame = CGRectMake(0, 0, 40, 30);
//    [titleButton setBackgroundColor:[UIColor clearColor]];
//    [titleButton setTitle:@"个人认证" forState:UIControlStateNormal];
//    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.titleView = titleButton;
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    
//    self.view.backgroundColor = RGBColor(234, 234, 234, 1);
    [self setNavTabBar:@"个人认证"];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    lable.text = @"个人认证照片上传";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:15];
    lable.textColor =[UIColor  grayColor];
    [self.view addSubview:lable];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, lable.frame.size.height+lable.frame.origin.y, self.view.frame.size.width, 2)];
    lineView.backgroundColor = RGBColor(219, 0, 0, 1);
    [self.view addSubview:lineView];
    
    CertificationScrollView *scrollView = [[CertificationScrollView alloc]initWithFrame:CGRectMake(0, lineView.frame.size.height+lineView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-(lineView.frame.size.height+lineView.frame.origin.y)) title:@"个人认证"];
    [self.view addSubview:scrollView];

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
