//
//  MovieSpecialViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieSpecialViewController.h"
#import "MovieSepcialGoodsInfoCell.h"
#import "PictureCarouselView.h"
#import "MovieSpecialShowModel.h"
#import "MovieSpecialShowGoodIndoModel.h"
#import "MovieGoodsInfoViewController.h"
#import "MovieComfirmOrderViewController.h"

@interface MovieSpecialViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *mainTableView;

@property (nonatomic,strong) UIScrollView *headerScrollView;

@property (nonatomic,strong) NSArray *listArray;  //列表数据

@property (nonatomic,strong) NSArray *scrollArray;//轮播图数据

@property (nonatomic,retain) UILabel *timeLab;

@property (nonatomic,retain) NSTimer *activeTimer;

@property (nonatomic,retain) MovieSpecialShowModel *mainModel;

@end

@implementation MovieSpecialViewController

- (NSArray *)listArray
{
    if (nil == _listArray) {
        _listArray = [NSArray new];
    }
    return _listArray;
}

- (NSArray *)scrollArray
{
    if (nil == _scrollArray) {
        _scrollArray = [NSArray new];
    }
    return _scrollArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"专场商品"];
//    [self requestSpecialShowGoodsDatas];
}


#pragma mark -- 创建表格视图
- (void)createSpecialView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self createTableHeaderView];
}

- (void)createTableHeaderView
{
    CGFloat imgW = kViewWidth;
    CGFloat imgH = 210;
    
    CGRect frame=CGRectMake(0,0,imgW,imgH);
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    
    PictureCarouselView *bannerView = [PictureCarouselView pictureCarouselViewWithFrame:CGRectMake(0, 0,imgW,imgH)];
    
    //设置自动滚动和滚动的时间
    [bannerView isAutomaticDragging:YES withAnimation:YES withTimeInterval:3];
    
    CGFloat pageCtrlW = self.scrollArray.count*20;
    CGFloat pageCtrlH = 20.0f;
    CGFloat pageCtrlX = (kViewWidth/2)-(pageCtrlW/2);
    CGFloat pageCtrlY = imgH - pageCtrlH - 10;
    
    CGRect pageCtrlFrame = CGRectMake(pageCtrlX, pageCtrlY, pageCtrlW, pageCtrlH);
    
    //设置pageControl的属性
    [bannerView setPageControlWithFrame:pageCtrlFrame AlignmentMethod:AlignmentMethodCenter withCurrentColor:[UIColor redColor] withIndicatorColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    
    NSMutableArray *imageArray = [NSMutableArray new];
    for (MovieSpecialShowGoodIndoModel *model in self.scrollArray) {
        [imageArray addObject:model.img];
    }
    
    //设置滚动视图的滚动图片
        bannerView.pictures = imageArray;
    
//    self.bannerView = bannerView;
    
    //添加到头部视图
    [headerView addSubview:bannerView];
    
    self.mainTableView.tableHeaderView = headerView;
}

//返回上一层
- (void)backAction
{
    [self.activeTimer invalidate];
    self.activeTimer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 请求专场数据
- (void)requestSpecialShowGoodsDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createSpecialGoodsShowCallBack:^(id obj) {
        
        HUD.labelText = @"加载完成";
        [HUD hide:YES];
        
        self.mainModel = (MovieSpecialShowModel *)obj;
        self.listArray = [NSArray arrayWithArray:self.mainModel.sessionList];
        self.scrollArray = [NSArray arrayWithArray:self.mainModel.carrousel];
        
        [self createSpecialView];
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"goodCellIdentifier";
    MovieSepcialGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieSepcialGoodsInfoCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rentBtn.tag = indexPath.row;
    [cell.rentBtn addTarget:self action:@selector(rentCurrentChooeseGood:) forControlEvents:UIControlEventTouchUpInside];
    
    MovieSpecialShowGoodIndoModel *goodModel = _listArray[indexPath.row];
    [cell setGoodModel:goodModel];
    
    return cell;
}


#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 140, 0, 0)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 30)];
        headerView.backgroundColor = RGBColor(234, 234, 234, 1);
        
        //红线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0,2,30)];
        line.backgroundColor = [UIColor redColor];
        [headerView addSubview:line];
        
        UIFont *labFont = [UIFont systemFontOfSize:15.0f];
        UIColor *labColor=RGBColor(135,135,135,1);
        
        //标题
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 21)];
        titleLab.text = @"专场商品";
        titleLab.textColor = labColor;
        titleLab.font = labFont;
        [headerView addSubview:titleLab];
        
        //剩余时间
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(kViewWidth-200, 5, 190, 21)];
        self.timeLab.font = labFont;
        self.timeLab.textColor = labColor;
        self.timeLab.textAlignment = 2;
        [headerView addSubview:self.timeLab];
        
        [self judementActiveTime];
        
        return headerView;
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieSpecialShowGoodIndoModel *model = _listArray[indexPath.row];
    
    MovieGoodsInfoViewController *goodInfoVC = [[MovieGoodsInfoViewController alloc] init];
    goodInfoVC.shopID = model.shopId;
    goodInfoVC.goodsId = model.goodId;
    [self.navigationController pushViewController:goodInfoVC animated:YES];
}


#pragma mark - 判断活动是否开始
- (void)judementActiveTime
{
    NSString *activeStatue = self.mainModel.lefttimes;
    
    if ([activeStatue isEqualToString:@"0"]) {
        self.timeLab.text = [NSString stringWithFormat:@"活动即将开始"];
    }
    else if ([activeStatue isEqualToString:@"1"]){
        self.activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(caculateActiveLeaveTime) userInfo:nil repeats:YES];
        [self.activeTimer fire];
    }
    else if ([activeStatue isEqualToString:@"2"]){
        
        self.timeLab.text = [NSString stringWithFormat:@"本场活动已结束"];
    }
}

- (void)caculateActiveLeaveTime
{
    NSDate *dateNow = [NSDate date];
    NSTimeInterval nowInterval = [dateNow timeIntervalSince1970];
    
    NSString *nowStr = [NSString stringWithFormat:@"%.0f",nowInterval];
    NSString *activeTime = self.mainModel.countdown;
    
    if ([activeTime isEqualToString:nowStr])
    {
        
        self.timeLab.text = @"倒计时: 00:00:00";
        [self.activeTimer invalidate];
        self.activeTimer = nil;
        return;
    }
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:(([activeTime doubleValue])-nowInterval-28800)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:timeDate];
    
    self.timeLab.text = [NSString stringWithFormat:@"倒计时:%@",timeStr];
//    HHNSLog(@"倒计时剩余时间 --> %f,%@",nowInterval-28800-([self.mainModel.countdown doubleValue]),timeStr);
}

#pragma mark - 租用当前商品(立即租)
- (void)rentCurrentChooeseGood:(UIButton *)button
{
    NSInteger index = button.tag;
    
    MovieSpecialShowGoodIndoModel *model = _listArray[index];
    
//    MovieGoodsInfoViewController *goodInfoVC = [[MovieGoodsInfoViewController alloc] init];
//    goodInfoVC.shopID = model.shopId;
//    goodInfoVC.goodsId = model.goodId;
//    [self.navigationController pushViewController:goodInfoVC animated:YES];
    
    NSString *goodId = model.goodId;//商品Id
    NSString *goodNum = @"1";   //商品数量
    NSString *shopId = model.shopId;//店铺Id
    NSString *goodColor = @"商家随机"; //商品颜色
    NSString *goodSize = @"商家随机";  //商品型号
    
    NSMutableArray *infoArray = [NSMutableArray new];
    [infoArray addObject:goodId];
    [infoArray addObject:goodNum];
    [infoArray addObject:shopId];
    [infoArray addObject:goodColor];
    [infoArray addObject:goodSize];
    
    NSArray *infoA = [NSArray arrayWithObjects:[infoArray componentsJoinedByString:@","],nil];
    
    
    MovieComfirmOrderViewController *comfirmOrderVC = [[MovieComfirmOrderViewController alloc] init];
    comfirmOrderVC.goodsInfoArray = infoA;
    [self.navigationController pushViewController:comfirmOrderVC animated:YES];
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
