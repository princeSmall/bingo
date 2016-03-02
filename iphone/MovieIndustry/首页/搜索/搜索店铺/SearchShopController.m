//
//  SearchShopController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SearchShopController.h"
#import "SearchShopResultController.h"
#import "CollectShopCell1.h"
#import "SelectCertificationView.h"
#import "ChooseCityController.h"

@interface SearchShopController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,ChooseCityControllerDelegate>
{
    UIButton *_selectedBtn;
    UITableView *_tbView;
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表商品 1 代表商家 2 代表课程 3 代表fatie
    NSString *_btnType;
}
//销量排序
@property (nonatomic,copy) NSString *saleType;
@property (nonatomic,copy) NSString *authenType;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
///店铺名称搜索字段
//@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,strong) UIView *myBlackView;
@property (nonatomic,strong) SelectCertificationView *certifView;
///是否展开了这个View
@property (nonatomic,assign) BOOL isCertif;
//是否是尾部刷新
@property (nonatomic,assign) BOOL isFooterFresh;
//城市ID
@property (nonatomic,copy) NSString *city_id;
//类型
@property (nonatomic,copy) NSString *location_cate;
//类型的选择框
@property (nonatomic,strong) UIView *typeBlackView;
//选择类型
@property (nonatomic,strong) SelectCertificationView *typeView;
//搜索框
@property (nonatomic,strong) UITextField *searchTextField;
@end

@implementation SearchShopController

- (SelectCertificationView *)typeView
{
    if (!_typeView) {
        _typeView = [[SelectCertificationView alloc] init];
        _typeView.frame = CGRectMake(0, 42+64, kViewWidth, 150);
        [_typeView.isCertification addTarget:self action:@selector(goodsAction) forControlEvents:UIControlEventTouchUpInside];
        [_typeView.isCertification setTitle:@"商品" forState:UIControlStateNormal];
        
        [_typeView.noCertification addTarget:self action:@selector(personnelAction) forControlEvents:UIControlEventTouchUpInside];
        [_typeView.noCertification setTitle:@"人员" forState:UIControlStateNormal];
        
        [_typeView.ignore addTarget:self action:@selector(fieldAction) forControlEvents:UIControlEventTouchUpInside];
        [_typeView.ignore setTitle:@"场地" forState:UIControlStateNormal];
    }
    
    return _typeView;
}

- (UIView *)typeBlackView
{
    if (!_typeBlackView) {
        _typeBlackView = [WNController createViewFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _typeBlackView.backgroundColor = [UIColor clearColor];
        _typeBlackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeBlackViewAction:)];
        [_typeBlackView addGestureRecognizer:ges];
    }
    
    return _typeBlackView;
}


- (SelectCertificationView *)certifView
{
    if (!_certifView) {
        _certifView = [[SelectCertificationView alloc] init];
        _certifView.frame = CGRectMake(0, 42+64, kViewWidth, 150);
        [_certifView.isCertification addTarget:self action:@selector(isCertificationAction) forControlEvents:UIControlEventTouchUpInside];
        [_certifView.noCertification addTarget:self action:@selector(noCertificationAction) forControlEvents:UIControlEventTouchUpInside];
        [_certifView.ignore addTarget:self action:@selector(ignoreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _certifView;
}

- (UIView *)myBlackView
{
    if (!_myBlackView) {
        _myBlackView = [WNController createViewFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _myBlackView.backgroundColor = [UIColor clearColor];
        _myBlackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myBlackViewRemoveAction:)];
        [_myBlackView addGestureRecognizer:ges];
    }
    
    return _myBlackView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)typeBlackViewAction:(UIGestureRecognizer *)g
{
    [g.view removeFromSuperview];
}

- (void)myBlackViewRemoveAction:(UIGestureRecognizer *)g
{
    [g.view removeFromSuperview];
    self.isCertif = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackItem];
    [self setNavTabBar];
    [self createUI];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.saleType = @"0";
    self.page = 1;
    self.authenType = @"";
    ///没有选择是否认证
    self.isCertif = NO;
    self.isFooterFresh = NO;
    
    //城市，分类
    self.city_id = @"";
    self.location_cate = @"";
    
    [self loadData];
    [self createRefresh];
}

#pragma mark - 商品
- (void)goodsAction
{
    [self.typeBlackView removeFromSuperview];
    self.location_cate = @"1";
    
    _page = 1;
    [self loadData];
}

#pragma mark - 人员
- (void)personnelAction
{
    [self.typeBlackView removeFromSuperview];
    self.location_cate = @"2";
    
    _page = 1;
    [self loadData];
}

#pragma mark - 场地
- (void)fieldAction
{
    [self.typeBlackView removeFromSuperview];
    self.location_cate = @"3";
    _page = 1;
    [self loadData];
}

#pragma mark - 添加刷新
- (void)createRefresh
{
    //添加下拉刷新
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        _isFooterFresh = NO;
        [self loadData];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tbView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        _isFooterFresh = YES;
        [self loadData];
        
    }];
    _tbView.footer.automaticallyChangeAlpha = YES;
    
    
}

#pragma mark -下载数据
- (void)loadData
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    ////这里城市可以不传递 ,@"city_id",@"全国"   shop_cate_id=1/2/3(对应 商品/人员/场地) city_id城市id(没有为空) sale=1/0是否按销量排序 name商品名称(没有为空) price=1/0是否按价钱排序 p分页数
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.authenType,@"is_type",self.saleType,@"is_sales",self.searchWords,@"name",[NSString stringWithFormat:@"%ld",self.page],@"p",self.city_id,@"city_id",self.location_cate,@"location_cate", nil];
    
    [HttpRequestServers requestBaseUrl:Shop_location_search withParams:userDict withRequestFinishBlock:^(id result) {
        
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        
        @try {
            if ([dict[@"status"] isEqualToString:@"f99"])
            {
                if (_page == 1) {
                    [self.dataArray removeAllObjects];
                }
                
                
                NSArray *listArray = dict[@"list"];
//                for (NSDictionary *infoDic in listArray) {
//                    ShopSearchModel *model = [[ShopSearchModel alloc] init];
//                    model.shopName = infoDic[@"name"];
//                    model.shopID = infoDic[@"id"];
//                    model.shopBrief = infoDic[@"brief"];
//                    model.shopPoints = infoDic[@"points"];
//                    model.shangpin = infoDic[@"shangpin"];
//                    model.goodszhekou = infoDic[@"zhekou"];
//                    model.shopImg = infoDic[@"preview"];
//                    [self.dataArray addObject:model];
//                }
                
                [_tbView reloadData];
                //结束刷新
                [_tbView.header endRefreshing];
                [_tbView.footer endRefreshing];
            }

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
        }];
        
    } withFieldBlock:^{
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
        }];
    }];
}

#pragma mark - 已认证按钮
- (void)isCertificationAction
{
    [self.myBlackView removeFromSuperview];
    self.isCertif = NO;
    self.authenType = @"1";
    
    self.page = 1;
    [self loadData];
}

#pragma mark - 没有认证
- (void)noCertificationAction
{
    [self.myBlackView removeFromSuperview];
    self.isCertif = NO;
    self.authenType = @"0";
    
    self.page = 1;
    [self loadData];
}

#pragma mark - 不限
- (void)ignoreAction
{
    [self.myBlackView removeFromSuperview];
    self.isCertif = NO;
    self.authenType = @"";
    self.page = 1;
    [self loadData];
}

- (void)setBackItem
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 42)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(10, 40, kViewWidth/4-20, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/4, 42) ImageName:@"screeningNone" Target:self Action:@selector(goodsAction:) Title:@"销量" fontSize:16];
    btn1.tag = 0;
    UIImage *imgArrow = [UIImage imageNamed:@"screeningNone"];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 32, 0, -32)];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgArrow.size.width, 0, imgArrow.size.width)];
    
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4, 0, kViewWidth/4, 42) ImageName:@"" Target:self Action:@selector(busniedssAction:) Title:@"认证" fontSize:16];
    [btnView addSubview:btn2];
    UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2, 0, kViewWidth/4, 42) ImageName:@"" Target:self Action:@selector(courseAction:) Title:@"类型" fontSize:16];
    [btnView addSubview:btn3];
    UIButton *btn4 = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4*3, 0, kViewWidth/4, 42) ImageName:@"" Target:self Action:@selector(postAction:) Title:@"地区" fontSize:16];
    [btnView addSubview:btn4];
    
    [self createTableView];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, kViewWidth, kViewHeight-44-42) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tbView.backgroundColor = kViewBackColor;
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 10.0f)];
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    [self.view addSubview:_tbView];
}

- (void)setNavTabBar
{
    UIView *view = [WNController createViewFrame:CGRectMake(0, 0, 257, 30)];
    if (isScreen4) {
        view.frame = CGRectMake(0, 0, 235, 30);
    }
    view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    view.layer.cornerRadius = 15;
    view.layer.masksToBounds = YES;
    
    
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(12, 2, (isScreen4?146:168), 28) boreStyle:UITextBorderStyleNone font:15];
    textField.placeholder = @"输入关键字";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    self.searchTextField = textField;
    
    UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake((isScreen4?196:218), 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchGoodsAction)];
    
    [view addSubview:textField];
    [view addSubview:searchArticleBtn];
    //设置头部的View
    self.navigationItem.titleView = view;
    
}
#pragma mark - searchGoodsAction
- (void)searchGoodsAction
{
    //收起键盘
    [self.searchTextField resignFirstResponder];
    
    self.searchWords = self.searchTextField.text;
    self.page = 1;
    [self loadData];
}


#pragma mark - 切换到销量
- (void)goodsAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(10, 40, kViewWidth/4-20, 2)];
    
    NSInteger btntag = btn.tag;
    if (btntag==2) {
        btntag = 0;
        btn.tag = btntag;
    }else
    {
        btntag++;
        btn.tag = btntag;
    }
    
    if (btn.tag == 0) {
        self.saleType = @"0";
        [btn setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
        self.page = 1;
        [self loadData];
    }
    if (btn.tag == 1) {
        self.saleType = @"1";
        [btn setImage:[UIImage imageNamed:@"screeningUp"] forState:UIControlStateNormal];
        self.page = 1;
        [self loadData];
    }
    
    if (btn.tag == 2) {
        
        self.saleType = @"2";
        [btn setImage:[UIImage imageNamed:@"screeningDown"] forState:UIControlStateNormal];
        self.page = 1;
        [self loadData];
    }
    
}

#pragma mark - 商家认证
- (void)busniedssAction:(UIButton *)btn
{
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/4+10, 40, kViewWidth/4-20, 2)];
    
    self.isCertif = !self.isCertif;
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    if (self.isCertif) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.myBlackView];
        [self.myBlackView addSubview:self.certifView];
    }else
    {
        [self.myBlackView removeFromSuperview];
    }
    
    
}

#pragma mark - 类型
- (void)courseAction:(UIButton *)btn
{
    [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/2+10, 40, kViewWidth/4-20, 2)];
}

#pragma mark - 地区
- (void)postAction:(UIButton *)btn
{ 
    [self setBtnType:@"3" selectBtn:btn btnLineFrame:CGRectMake(kViewWidth/4*3+10, 40, kViewWidth/4-20, 2)];
    
    ChooseCityController *chooseCityVc = [[ChooseCityController alloc] init];
    UINavigationController *navCity = [[UINavigationController alloc] initWithRootViewController:chooseCityVc];
    navCity.navigationBar.translucent=NO;
    chooseCityVc.delegate = self;
    chooseCityVc.isDismis = @"1";
    [self presentViewController:navCity animated:YES completion:nil];
    
}


/// 点击按钮执行的动画和参数的变化
- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
{
    _btnType = btnType;
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = selectedBtn;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = btnLineFrame;
    }];
    
    [self.navigationController.navigationBar endEditing:YES];
    
    
    if ([_btnType isEqualToString:@"2"]) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.typeBlackView];
        [self.typeBlackView addSubview:self.typeView];
    }else
    {
        [self.typeView removeFromSuperview];
    }
    
    
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"searchShopID";
    CollectShopCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectShopCell1" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    ShopSearchModel *model = self.dataArray[indexPath.row];
//    [cell config:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController.navigationBar endEditing:YES];
    //ShopSearchModel *model = self.dataArray[indexPath.row];
    SearchShopResultController *searchVc = [[SearchShopResultController alloc] init];
    //searchVc.shopId = model.shopID;
    [self.navigationController pushViewController:searchVc animated:YES];
}

////TableView的分割线处理
-(void)viewDidLayoutSubviews {
    
    if ([_tbView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tbView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tbView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tbView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


#pragma mark - 搜索按钮开始搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //收起键盘
    [textField resignFirstResponder];
    
    self.searchWords = textField.text;
    self.page = 1;
    [self loadData];
    
    return YES;
}


#pragma mark - CityChoose
- (void)cityName:(NSString *)CityName andCityId:(NSString *)cityId
{

    self.city_id = cityId;
    self.page = 1;
    [self loadData];
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
