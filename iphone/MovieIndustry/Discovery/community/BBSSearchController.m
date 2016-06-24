//
//  BBSSearchController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/11.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "BBSSearchController.h"
#import "DiscoverPopView.h"
@interface BBSSearchController () <UITextFieldDelegate>
@property (nonatomic,strong) UILabel *navLabel;
///搜索文本框
@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,strong) DiscoverPopView *popView;
@property (nonatomic,strong) UIView *popBgView;
@property (nonatomic, weak) UIButton *selectBtn;
@end

@implementation BBSSearchController
- (UIView *)popBgView
{
    if (!_popBgView) {
        //覆盖的大View不让干其他地方点击
        _popBgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _popBgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePopView:)];
        [_popBgView addGestureRecognizer:tapGes1];
    }
    
    return _popBgView;
}

- (DiscoverPopView *)popView
{
    if (!_popView) {
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverPopView" owner:nil options:nil]lastObject];
        _popView.frame = CGRectMake((kViewWidth-(isScreen4?235:257))/2, 0, 132, 106);
        [_popView.forumButton setTitle:@"帖子" forState:UIControlStateNormal];
        [_popView.courseButton setTitle:@"说说" forState:UIControlStateNormal];
        [_popView.forumButton addTarget:self action:@selector(forumButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_popView.courseButton addTarget:self action:@selector(courseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@""];
    [self setNavTabBar];
    
}

- (void) setNavTabBar {
    UIView *view = [WNController createViewFrame:CGRectMake(0, 0, 257, 30)];
    if (isScreen4) {
        view.frame = CGRectMake(0, 0, 235, 30);
    }
    view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    view.layer.cornerRadius = 15;
    view.layer.masksToBounds = YES;
    
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(14, 1, 40, 30) Font:16 Text:@"宝贝" textAligment:NSTextAlignmentCenter];
    self.navLabel = navLabel;
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(53, 8, 14, 14) ImageName:@"15-07"];
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(74, 2, (isScreen4?146:168), 28) boreStyle:UITextBorderStyleNone font:15];
    textField.placeholder = @"你想找什么？";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    self.searchTextField = textField;
    
    UIButton *navBtn  = [WNController createButtonWithFrame:CGRectMake(0, 0, 70, 30) ImageName:@"" Target:self Action:@selector(searchTypeAction:) Title:@""];
    
    UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake((isScreen4?196:218), 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchAction)];
    
    
    [view addSubview:navLabel];
    [view addSubview:navImage];
    [view addSubview:textField];
    [view addSubview:navBtn];
    [view addSubview:searchArticleBtn];
    //设置头部的View
    self.navigationItem.titleView = view;
}
- (void)removePopView:(UITapGestureRecognizer *)g
{
    [g.view removeFromSuperview];
    [self.popView removeFromSuperview];
    self.selectBtn.selected = NO;
}
- (void)searchTypeAction:(UIButton *)btn
{
    self.selectBtn = btn;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.view addSubview:self.popBgView];
        [self.view addSubview:self.popView];
    }else
    {
        [self.popBgView removeFromSuperview];
        [self.popView removeFromSuperview];
    }
}
- (void) searchAction {
    
}
- (void) forumButtonAction:(UIButton *) btn{
    self.navLabel.text = @"帖子";
    self.selectBtn.selected = NO;
    [self.popBgView removeFromSuperview];
    [self.popView removeFromSuperview];
}
- (void) courseButtonAction:(UIButton *) btn {
    self.navLabel.text = @"说说";
    self.selectBtn.selected = NO;
    [self.popBgView removeFromSuperview];
    [self.popView removeFromSuperview];
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
