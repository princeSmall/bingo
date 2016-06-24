//
//  MovieCircle_PersonDetailController.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/8.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieCircle_PersonDetailController.h"
#import "MovieCircle_PersonDetailHead.h"
@interface MovieCircle_PersonDetailController () <UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView *tableView;
@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;

@property (nonatomic, weak) MovieCircle_PersonDetailHead *headV;




@end

@implementation MovieCircle_PersonDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.leftBtn removeFromSuperview];
    [self.rightBtn removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 1;
        self.navigationController.navigationBar.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBack];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBar.hidden = YES;
    }];
    
    ///设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) creatTableView {
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, -20, kViewWidth, kViewHeight+40);
    tableView.delegate = self;
    tableView.dataSource = self;
    
    MovieCircle_PersonDetailHead *headV = [MovieCircle_PersonDetailHead movieCircle_PersonDetailHead];
    self.headV = headV;
    ViewBorderRadius(headV.iconImagV, 40, 2, [UIColor whiteColor]);
    [headV.postBtn setTitle:[NSString stringWithFormat:@"他的说说\n    88"] forState:UIControlStateNormal];
    [headV.focusBtn setTitle:[NSString stringWithFormat:@"他的关注\n    88"] forState:UIControlStateNormal];
    [headV.fansBtn setTitle:[NSString stringWithFormat:@"他的粉丝\n    88"] forState:UIControlStateNormal];
    [headV.postBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headV.fansBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headV.focusBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
   tableView.tableHeaderView = headV;
}
- (void)setNavBack
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 35, 20, 18)];
    self.leftBtn = leftBtn;
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.alpha = 1;
    [window addSubview:leftBtn];
   
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kViewWidth-80, 30, 80, 40)];
    self.rightBtn = rightBtn;
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 6, 0, -6)];
    [rightBtn setTitle:@"+关注" forState:UIControlStateNormal];
    
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(attentionAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.alpha = 1;
    
    [window addSubview:rightBtn];
    
}
- (void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) attentionAction {
    
}
- (void) btnClicked:(UIButton *) btn {
    // 告诉self.view约束需要更新
    [self.headV.effectV setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.headV.effectV updateConstraintsIfNeeded];
    switch (btn.tag) {
        case 1:
            HHNSLog(@"说说");
            break;
        case 2: {
            HHNSLog(@"粉丝");
            [self.headV.btnLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.headV.effectV.mas_bottom);
                make.height.mas_equalTo(5);
                make.width.mas_equalTo(70);
                make.centerX.equalTo(self.headV.fansBtn.mas_centerX);
            }];
            [UIView animateWithDuration:0.5 animations:^{
               
                [self.headV.effectV layoutIfNeeded];
            }];
        }
            break;
        case 3: {
              HHNSLog(@"关注");
            [self.headV.btnLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.headV.effectV.mas_bottom);
                make.height.mas_equalTo(5);
                make.width.mas_equalTo(70);
                make.centerX.equalTo(self.headV.focusBtn.mas_centerX);
            }];
            [UIView animateWithDuration:0.5 animations:^{
             
                [self.headV.effectV layoutIfNeeded];
            }];
        }
          

            break;
        default:
            break;
    }
}
#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"123";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
