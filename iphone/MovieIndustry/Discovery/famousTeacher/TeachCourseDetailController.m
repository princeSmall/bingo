//
//  TeachCourseDetailController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "TeachCourseDetailController.h"
#import "TeacherCoures_AboutArticleCell.h"
@interface TeachCourseDetailController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}
@property (weak, nonatomic) IBOutlet UIView *mediaPlayerContentV;
@property (nonatomic,strong) UIView *bottomView;


@end
//最后一行分隔线顶头显示
static void setLastCellSeperatorToLeft(UITableViewCell* cell)
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}
@implementation TeachCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMovie];
    [self setNavTabBar:@"名师课堂"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self createBottomInputeView];
    
}

- (void) creatTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.mediaPlayerContentV.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(50);
    }];
}


-(void)playMovie{
    
}
#pragma mark - 创建底部输入框
- (void)createBottomInputeView
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kViewHeight-50-44, kViewWidth, kViewHeight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth,1)];
    line.backgroundColor=RGBColor(212,212,212,0.5);
    [self.bottomView addSubview:line];
    
    //相机按钮
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(7,10,36,27);
    [cameraBtn setImage:[UIImage imageNamed:@"evaluation_camera"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(takePhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:cameraBtn];
    
    //输入框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50,10, kViewWidth-130, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.bottomView addSubview:textField];
    
    //发布按钮
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake(kViewWidth-70, 10, 60, 30);
    [publishBtn setTitle:@"267" forState:UIControlStateNormal];
    publishBtn.clipsToBounds = YES;
    publishBtn.layer.cornerRadius = 5.0f;
    publishBtn.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
    publishBtn.layer.borderWidth = 1.0f;
    [publishBtn setTitleColor:RGBColor(249, 111, 11, 1) forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [publishBtn addTarget:self action:@selector(artcleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:publishBtn];
    
    
    [self.view addSubview:self.bottomView];
}
#pragma mark - 拍照
- (void)takePhotoBtnClicked:(UIButton *)button
{
    NSLog(@"拍照按钮被点击");
}
- (void)artcleAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Id = @"aboutArticleCell";
    TeacherCoures_AboutArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherCoures_AboutArticleCell" owner:nil options:nil] lastObject];
    }
    setLastCellSeperatorToLeft(cell);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
        UIView *hView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 26)];
        hView.backgroundColor = kViewBackColor;
        UILabel *label = [WNController createLabelWithFrame:CGRectMake(6,3,128, 21) Font:15 Text:@"相关文章" textAligment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1];
        [hView addSubview:label];
        return hView;
 
    
}

@end
