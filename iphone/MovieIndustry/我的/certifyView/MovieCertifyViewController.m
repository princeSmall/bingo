//
//  MovieCertifyViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/30.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieCertifyViewController.h"

@interface MovieCertifyViewController ()

/** 网址 */
@property (nonatomic,copy) NSString *networkPath;

@end

@implementation MovieCertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.viewTitle) {
        [self setNavTabBar:self.viewTitle];
    }
    else{
        [self setNavTabBar:@"认证"];
    }
    
    [self createWarnGotoVerifyView];
}


- (void)createWarnGotoVerifyView
{
    self.networkPath = @"www.comefile.com";
    NSString *warnStr = [NSString stringWithFormat:@"   请您到电影工业官网(%@)提交资料进行认证",self.networkPath];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:warnStr];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:6.0f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, warnStr.length)];
    
    CGFloat viewX = 20;
    CGFloat width = (kViewWidth - 40);
    
    UILabel *warnLab = [DeliveryUtility createLabelFrame:CGRectMake(viewX,20, kViewWidth-40,50) title:warnStr textAlignment:0];
    warnLab.textColor = RGBColor(135, 135, 135, 1);
    warnLab.font = DefaultFont;
    warnLab.numberOfLines = 0;
    warnLab.attributedText = attrStr;
    [self.view addSubview:warnLab];
    
    UIButton *certainBtn = [DeliveryUtility createBtnFrame:CGRectMake(viewX, CGRectGetMaxY(warnLab.frame)+20, width, 40) title:@"确认" andFont:[UIFont systemFontOfSize:18.0f] target:self action:@selector(certainBtnClickedAction)];
    certainBtn.backgroundColor = [UIColor whiteColor];
    [certainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    certainBtn.clipsToBounds = YES;
    certainBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:certainBtn];
    
}


- (void)certainBtnClickedAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
