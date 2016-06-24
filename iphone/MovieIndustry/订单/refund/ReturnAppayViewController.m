//
//  ReturnAppayViewController.m
//  Identifier
//
//  Created by 童乐 Patrick on 1/20/16.
//  Copyright © 2016 @_@. All rights reserved.
//

#import "ReturnAppayViewController.h"
#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ReturnAppayViewController ()

@end

@implementation ReturnAppayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTabBar:@"退款申请"];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, self.navigationController.navigationBar.frame.size.height+self.navigationController.navigationBar.frame.origin.y+30, self.view.frame.size.width-40, 60)];
    [self.view addSubview:label];
    label.numberOfLines=0;
    label.text =@"    您的退款申请已经提交成功,我们会尽快为您处理...";
    label.textColor = [UIColor lightGrayColor];
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(10, label.frame.size.height+label.frame.origin.y+30, self.view.frame.size.width-20, 45)];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius=8;
    button.layer.masksToBounds =YES;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(actionConfirm) forControlEvents:UIControlEventTouchUpInside];
  
    
    
}

-(void)actionConfirm
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
