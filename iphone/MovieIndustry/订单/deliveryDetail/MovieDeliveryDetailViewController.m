
//
//  MovieDeliveryDetailViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieDeliveryDetailViewController.h"
#import "MovieDeliveryTableViewCell.h"
#import "MovieGoodsInfoCell.h"
#import "MovieOrderDeliveyMainModel.h"
#import "MovieDeliveyRelatedGoodModel.h"

@interface MovieDeliveryDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *mainTableView;


/** 是否有商品详情 */
@property (nonatomic,assign) BOOL isHaveRecorder;

@property (nonatomic,retain) MovieOrderDeliveyMainModel *mainModel;

@property (nonatomic,retain) NSArray *goodsArray;

@end


@implementation MovieDeliveryDetailViewController


- (NSArray *)goodsArray
{
    if (nil == _goodsArray) {
        _goodsArray = [NSArray new];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _isHaveRecorder = YES;
    [self setNavTabBar:@"物流详情"];
    [self requestDeliveyDetailDatas];
    [self createOrderDeliveryDetailView];
}

- (void)createOrderDeliveryDetailView
{
    //创建列表
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
//    UIColor *bgColor = RGBColor(234, 234, 234, 234);
//    self.view.backgroundColor = bgColor;
    self.mainTableView.backgroundColor = kViewBackColor;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.mainTableView.showsVerticalScrollIndicator = NO;
}


#pragma mark - 请求快递物流
- (void)requestDeliveyDetailDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:self];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    NSString *requestOrderId;
    if (self.orderId) {
        requestOrderId = self.orderId;
    }else{
        requestOrderId = @"";
    }
    
    [MovieHttpRequest createCheckDeliveyDetailWithOrderId:requestOrderId CallBack:^(id obj) {
        
        [HUD hide:YES];
        
        self.mainModel = (MovieOrderDeliveyMainModel *)obj;
        self.goodsArray = self.mainModel.goods;
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section==0) ? 1 : self.goodsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    
        //物流详情
        MovieDeliveryTableViewCell *deliveryCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieDeliveryTableViewCell" owner:self options:nil] lastObject];
        
        [deliveryCell setDeliveryModel:self.mainModel];
        
        return deliveryCell;
    }
    else if (1 == indexPath.section){
        
        //商品详情
        NSString *cellID = @"goodCellID";
        MovieGoodsInfoCell *goodCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == goodCell) {
            goodCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieGoodsInfoCell" owner:self options:nil] lastObject];
        }
        
        MovieDeliveyRelatedGoodModel *model = _goodsArray[indexPath.row];
        [goodCell setGoodsModel:model];
        
        return goodCell;
    }
    
    
    return nil;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (0 == indexPath.section)?80:100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (1 == section)?25:0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (1 == section && self.goodsArray.count) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth,25)];
        UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake(10,2, 100,21)];
        headerLab.font=[UIFont systemFontOfSize:16.0f];
        headerLab.textColor = RGBColor(134,134,134,1);
        headerLab.text = @"商品详情";
        [headerView addSubview:headerLab];
        return headerView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
