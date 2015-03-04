//
//  LogisticsNumberController.m
//  Identifier
//
//  Created by Hopkins Patrick on 1/21/16.
//  Copyright © 2016 @_@. All rights reserved.
//

#import "LogisticsNumberController.h"
#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface LogisticsNumberController ()

@end

@implementation LogisticsNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"上传物流单号";
    self.view.backgroundColor = RGBColor(234, 234, 234, 1);
    
    [self setTopView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTopView
{
    UIView *topCell = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+self.navigationController.navigationBar.frame.origin.y+10, self.view.frame.size.width, 40)];
    topCell.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topCell];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 150, topCell.frame.size.height)];
    textField.placeholder = @"选择物流公司";
    textField.textAlignment =NSTextAlignmentLeft;
    [topCell addSubview:textField];
    textField.font = [UIFont systemFontOfSize:15];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, topCell.frame.size.width, topCell.frame.size.height)];
    [button setImage:[UIImage imageNamed:@"icon_rbt"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, self.view.frame.size.width-20, 5, 5)];
    [topCell addSubview:button];
      
    
    UIView *secondCell = [[UIView alloc]initWithFrame:CGRectMake(0, topCell.frame.size.height+topCell.frame.origin.y+1, self.view.frame.size.width, 40)];
    secondCell.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondCell];
    
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 150, topCell.frame.size.height)];
    textField1.placeholder = @"请输入单号";
    textField1.textAlignment =NSTextAlignmentLeft;
    textField1.font = [UIFont systemFontOfSize:15];
    [secondCell addSubview:textField1];

    UIButton *button1 =[[UIButton alloc]initWithFrame:CGRectMake(10, secondCell.frame.size.height+secondCell.frame.origin.y+30, self.view.frame.size.width-20, 45)];
    NSLog(@"%@",NSStringFromCGRect(button1.frame));
    [button1 setTitle:@"提交" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor whiteColor];
    button1.layer.cornerRadius=8;
    button1.layer.masksToBounds =YES;
    [self.view addSubview:button1];
    
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
