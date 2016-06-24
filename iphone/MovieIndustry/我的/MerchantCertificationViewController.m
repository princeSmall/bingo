//
//  MerchantCertificationViewController.m
//  Identifier
//
//  Created by 童乐 Patrick on 1/20/16.
//  Copyright © 2016 @_@. All rights reserved.
//

#import "MerchantCertificationViewController.h"
#import "CompanyCertificationViewController.h"
#import "PersonCertificationViewController.h"

#define RGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface MerchantCertificationViewController ()

@end

@implementation MerchantCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"商家认证"];
    //self.navigationItem.title = @"商家认证";
    //不需要
//    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    titleButton.frame = CGRectMake(0, 0, 40, 30);
//    [titleButton setBackgroundColor:[UIColor clearColor]];
//    [titleButton setTitle:@"商家认证" forState:UIControlStateNormal];
//    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.titleView = titleButton;
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    
    self.view.backgroundColor = RGBColor(234, 234, 234, 1);
    UIButton *buttonPerson = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 110)];
    [buttonPerson setBackgroundImage:[UIImage imageNamed:@"btn_grrz"] forState:UIControlStateNormal];
    [self.view addSubview:buttonPerson];
    [buttonPerson addTarget:self action:@selector(actionPerson) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonCompany = [[UIButton alloc]initWithFrame:CGRectMake(0, 15+buttonPerson.frame.size.height+buttonPerson.frame.origin.y, self.view.frame.size.width, 110)];
    [buttonCompany setBackgroundImage:[UIImage imageNamed:@"btn_gsrz"] forState:UIControlStateNormal];
    [self.view addSubview:buttonCompany];
    [buttonCompany addTarget:self action:@selector(actionCompany) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)actionPerson
{
    PersonCertificationViewController *perVC = [[PersonCertificationViewController alloc]init];
    [self.navigationController pushViewController:perVC animated:YES];
    }

-(void)actionCompany
{
     CompanyCertificationViewController *comVC=     [[CompanyCertificationViewController alloc]init];
    [self.navigationController pushViewController:comVC animated:YES];

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
