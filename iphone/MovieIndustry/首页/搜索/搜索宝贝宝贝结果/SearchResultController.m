//
//  SearchResultController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#define btnWidth (kViewWidth-42)
#import "SearchResultController.h"
#import "CollectGoodsCell1.h"
#import "SearchCollectionCell.h"
#import "MovieGoodsInfoViewController.h"
#import "SelectCertificationView.h"
#import "ChooseCityController.h"
#import "ShareView.h"
#import "BabySearchModel.h"

@interface SearchResultController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,ShareViewDelegate,ChooseCityControllerDelegate>
{
    ///选中的按钮
    UIButton *_selectedBtn;
    
    //
    UITableView *_tbView;
    
    //按钮下面的红线
    UIView *_btnLine;
    
    ///判断是哪一个按钮  0 代表销量 1 代表价格 2 代表类型 3 代表地区
    NSString *_btnType;
}

///分享UI
@property (nonatomic,strong) ShareView *shareView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UICollectionView *collectView;

@property (nonatomic,strong) UITextField *searchTextField;
///销量排序
@property (nonatomic,copy) NSString *saleType;
///价格拍讯
@property (nonatomic,copy) NSString *priceType;
///商品名称
@property (nonatomic,copy) NSString *goodsName;

@property (nonatomic,assign) NSUInteger page;

@property (nonatomic,assign) BOOL isFooterFresh;
///
@property (nonatomic,strong) UIView *myBlackView;
///商品人员场地
@property (nonatomic,strong) SelectCertificationView *certifView;
///商品人员场地
@property (nonatomic,copy) NSString *shop_cate_id;
//城市ID
@property (nonatomic,copy) NSString *city_id;

@property (nonatomic,strong) UIButton *priceButton;
@property (nonatomic,strong) UIButton *salesButton;
@end

@implementation SearchResultController

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

- (SelectCertificationView *)certifView
{
    if (!_certifView) {
        _certifView = [[SelectCertificationView alloc] init];
        _certifView.frame = CGRectMake(0, 42+64, kViewWidth, 150);
        [_certifView.isCertification addTarget:self action:@selector(goodsAction) forControlEvents:UIControlEventTouchUpInside];
        [_certifView.isCertification setTitle:@"商品" forState:UIControlStateNormal];
        
        [_certifView.noCertification addTarget:self action:@selector(personnelAction) forControlEvents:UIControlEventTouchUpInside];
        [_certifView.noCertification setTitle:@"人员" forState:UIControlStateNormal];
        
        [_certifView.ignore addTarget:self action:@selector(fieldAction) forControlEvents:UIControlEventTouchUpInside];
        [_certifView.ignore setTitle:@"场地" forState:UIControlStateNormal];
    }
    
    return _certifView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationItem.titleView endEditing:YES];
}
- (void)myBlackViewRemoveAction:(UIGestureRecognizer *)g
{
    [g.view removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackItem];
    [self setNavTabBar];
    
//    [self setNavRightImage:@"search_more" rightAction:@selector(shareAction:)];

    ///初始化数据
    self.saleType = @"0";
    self.priceType = @"0";
    self.goodsName = self.searchWords;
    
    self.shop_cate_id = @"";
    self.city_id = @"";

    
    [self createUI];
    
    self.isFooterFresh = NO;
    self.page = 1;
    [self  loadData];
    [self createRefresh];
}

#pragma mark - 商品
- (void)goodsAction
{
    [self.myBlackView removeFromSuperview];
    self.shop_cate_id = @"";
    self.city_id = @"";
    self.saleType = @"";
    self.salesButton.tag = 0;
    [self.salesButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    self.priceType = @"";
    self.priceButton.tag = 0;
    [self.priceButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    self.shop_cate_id = @"1";
    [self initLoadData];
}

#pragma mark - 人员
- (void)personnelAction
{
    [self.myBlackView removeFromSuperview];
    
    self.shop_cate_id = @"";
    self.city_id = @"";
    self.saleType = @"";
    self.salesButton.tag = 0;
    [self.salesButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    self.priceType = @"";
    self.priceButton.tag = 0;
    [self.priceButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    
    self.shop_cate_id = @"2";
    [self initLoadData];
}

#pragma mark - 场地
- (void)fieldAction
{
    [self.myBlackView removeFromSuperview];
    self.shop_cate_id = @"";
    self.city_id = @"";
    self.saleType = @"";
    self.salesButton.tag = 0;
    [self.salesButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    self.priceType = @"";
    self.priceButton.tag = 0;
    [self.priceButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    self.shop_cate_id = @"3";
    [self initLoadData];
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
    
    _collectView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        _isFooterFresh = NO;
        [self loadData];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _collectView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _collectView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        _isFooterFresh = YES;
        [self loadData];
        
    }];
    _collectView.footer.automaticallyChangeAlpha = YES;
}

#pragma mark -下载数据
- (void)loadData
{

   MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    ////这里城市可以不传递 ,@"city_id",@"全国"   shop_cate_id=1/2/3(对应 商品/人员/场地) city_id城市id(没有为空) sale=1/0是否按销量排序 name商品名称(没有为空) price=1/0是否按价钱排序 p分页数
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.shop_cate_id,@"shop_cate_id",self.saleType,@"sales",self.goodsName,@"name",self.priceType,@"price",[NSString stringWithFormat:@"%ld",self.page],@"p",self.city_id,@"city_id", nil];
    
    [HttpRequestServers requestBaseUrl:Shop_search_deal withParams:userDict withRequestFinishBlock:^(id result) {
        
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        
        @try {
            if ([dict[@"status"] isEqualToString:@"f99"])
            {
                if (self.page == 1) {
                    [self.dataArray removeAllObjects];
                }
                
                
                NSArray *listArray = dict[@"list"];
                for (NSDictionary *infoDic in listArray) {
                    BabySearchModel *model = [[BabySearchModel alloc] init];
                    model.goodsName = [WNController nullString:infoDic[@"name"]];
                    model.goodsID = [WNController nullString:infoDic[@"id"]];
                    model.goodsImg = [WNController nullString:infoDic[@"img"]];
                    model.goodsCity = [WNController nullString:infoDic[@"city"]];
                    model.goodsCurrentPrice = [WNController nullString:infoDic[@"current_price"]];
                    model.goodsOriginPrice = [WNController nullString:infoDic[@"origin_price"]];
                    model.songhuo = [WNController nullString:infoDic[@"songhuo"]];
                    model.location_id = [WNController nullString:infoDic[@"location_id"]];
                    [self.dataArray addObject:model];
                }
                
                [_tbView reloadData];
                [_collectView reloadData];
                //结束刷新
                [_tbView.header endRefreshing];
                [_tbView.footer endRefreshing];
                
                [_collectView.header endRefreshing];
                [_collectView.footer endRefreshing];
            }

        }
        @catch (NSException *exception) {
            [MBHudManager removeHud:hud scallBack:^(id obj) {
                
            }];
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


- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 42)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(10, 40, btnWidth/4-20, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, btnWidth/4, 42) ImageName:@"screeningNone" Target:self Action:@selector(salesAction:) Title:@"销量" fontSize:15];
    btn1.tag = 0;
    UIImage *imgArrow = [UIImage imageNamed:@"screeningNone"];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 32, 0, -32)];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgArrow.size.width, 0, imgArrow.size.width)];
    
    self.salesButton = btn1;
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(btnWidth/4, 0, btnWidth/4, 42) ImageName:@"screeningNone" Target:self Action:@selector(priceAction:) Title:@"价格" fontSize:15];
    btn2.tag = 0;
    self.priceButton = btn2;
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 32, 0, -32)];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgArrow.size.width, 0, imgArrow.size.width)];
    
    [btnView addSubview:btn2];
    UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(btnWidth/2, 0, btnWidth/4, 42) ImageName:@"" Target:self Action:@selector(typeAction:) Title:@"类型" fontSize:15];
    [btnView addSubview:btn3];
    UIButton *btn4 = [WNController createButtonWithFrame:CGRectMake(btnWidth/4*3, 0, btnWidth/4, 42) ImageName:@"" Target:self Action:@selector(areaAction:) Title:@"地区" fontSize:15];
    [btnView addSubview:btn4];
    
    UIButton *switchViewBtn= [WNController createButtonWithFrame:CGRectMake(btnWidth, 0, 42, 42) ImageName:@"search_block" Target:self Action:@selector(switchViewAction:) Title:@""];
    [switchViewBtn setImage:[UIImage imageNamed:@"search_normal"] forState:UIControlStateSelected];
    [btnView addSubview:switchViewBtn];
    
    [self createTableView];
    [self createCollectionView];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, kViewWidth, kViewHeight-44-42) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    _tbView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.00f)];
    [self.view addSubview:_tbView];
}

#pragma mark - 创建CollectionView
- (void)createCollectionView
{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(kViewWidth, 10.0f);
    
    self.collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 42, kViewWidth, kViewHeight-44-42) collectionViewLayout:flowLayout];
    self.collectView.dataSource=self;
    self.collectView.delegate=self;
    self.collectView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.collectView setBackgroundColor:kViewBackColor];
    
    //注册Cell，必须要有
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collectView registerNib:[UINib nibWithNibName:@"SearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"babYSearchCollectionCell"];
    
}

#pragma mark - 销量
- (void)salesAction:(UIButton *)btn
{
    self.city_id = @"";
    self.priceType = @"";
    self.priceButton.tag = 0;
    [self.priceButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(10, 40, btnWidth/4-20, 2)];
    
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
        [self initLoadData];
    }
    if (btn.tag == 1) {
        self.saleType = @"1";
        [btn setImage:[UIImage imageNamed:@"screeningUp"] forState:UIControlStateNormal];
        [self initLoadData];
    }
    
    if (btn.tag == 2) {
        
        self.saleType = @"2";
        [btn setImage:[UIImage imageNamed:@"screeningDown"] forState:UIControlStateNormal];
        [self initLoadData];
    }
    
    
}

- (void)initLoadData
{
    self.page = 1;
    self.isFooterFresh = NO;
    [self loadData];
}

#pragma mark - 价格排序
- (void)priceAction:(UIButton *)btn
{
    self.city_id = @"";
    self.saleType = @"";
    self.salesButton.tag = 0;
    [self.salesButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    self.shop_cate_id = @"";
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(btnWidth/4+10, 40, btnWidth/4-20, 2)];
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
        self.priceType = @"0";
        [btn setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
        [self initLoadData];
    }
    if (btn.tag == 1) {
        self.priceType = @"1";
        [btn setImage:[UIImage imageNamed:@"screeningUp"] forState:UIControlStateNormal];
        [self initLoadData];
    }
    
    if (btn.tag == 2) {
        
        self.priceType = @"2";
        [btn setImage:[UIImage imageNamed:@"screeningDown"] forState:UIControlStateNormal];
        [self initLoadData];
    }
    
}

#pragma mark - 类型
- (void)typeAction:(UIButton *)btn
{
    self.shop_cate_id = @"";
    [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(btnWidth/2+10, 40, btnWidth/4-20, 2)];
    
}

#pragma mark - 地区
- (void)areaAction:(UIButton *)btn
{
    self.shop_cate_id = @"";
    self.saleType = @"";
    self.salesButton.tag = 0;
    [self.salesButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    self.priceType = @"";
    self.priceButton.tag = 0;
    [self.priceButton setImage:[UIImage imageNamed:@"screeningNone"] forState:UIControlStateNormal];
    
    [self setBtnType:@"3" selectBtn:btn btnLineFrame:CGRectMake(btnWidth/4*3+10, 40, btnWidth/4-20, 2)];
    
    ChooseCityController *chooseCityVc = [[ChooseCityController alloc] init];
    UINavigationController *navCity = [[UINavigationController alloc] initWithRootViewController:chooseCityVc];
    navCity.navigationBar.translucent=NO;
    chooseCityVc.delegate = self;
    chooseCityVc.isDismis = @"1";
    [self presentViewController:navCity animated:YES completion:nil];
    ///tableView的头部视图
    
}

#pragma mark - 切换视图
- (void)switchViewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [self.view addSubview:_collectView];
        [_tbView removeFromSuperview];
        [self initLoadData];
    }else
    {
        [self.view addSubview:_tbView];
        [_collectView removeFromSuperview];
        [self initLoadData];
    }
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

- (void)setNavTabBar
{
    UIView *view = [WNController createViewFrame:CGRectMake(0, 0, 257, 30)];
    if (isScreen4) {
        view.frame = CGRectMake(0, 0, 235, 30);
    }
    view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    view.layer.cornerRadius = 15;
    view.layer.masksToBounds = YES;
    
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(14, 1, 40, 30) Font:16 Text:@"宝贝" textAligment:NSTextAlignmentCenter];
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(53, 8, 14, 14) ImageName:@"15-07"];
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(74, 2, (isScreen4?146:168), 28) boreStyle:UITextBorderStyleNone font:15];
    if (![self.goodsName isEqualToString:@""]) {
        textField.text = self.searchWords;
    }
    textField.placeholder = @"你想找什么？";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    self.searchTextField = textField;
    
//    UIButton *navBtn  = [WNController createButtonWithFrame:CGRectMake(0, 0, 70, 30) ImageName:@"" Target:self Action:@selector(searchTypeAction:) Title:@""];
    UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake((isScreen4?196:218), 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchGoodsAction)];
    
    [view addSubview:navLabel];
    [view addSubview:navImage];
    [view addSubview:textField];
//    [view addSubview:navBtn];
    [view addSubview:searchArticleBtn];
    //设置头部的View
    self.navigationItem.titleView = view;
}
#pragma mark - searchGoodsAction
- (void)searchGoodsAction
{
    [self.searchTextField resignFirstResponder];
    self.goodsName = self.searchTextField.text;
    [self initLoadData];
}

#pragma mark - tableView
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
    static NSString *cellID = @"searchResultCellID";
    CollectGoodsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectGoodsCell1" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //BabySearchModel *model = self.dataArray[indexPath.row];
#warning 需赋值
#warning 需赋值
    //[cell config:model];
    
    return cell;
}

#pragma mark - 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BabySearchModel *model = self.dataArray[indexPath.row];
    MovieGoodsInfoViewController *goodsDescVc = [[MovieGoodsInfoViewController alloc] init];
    goodsDescVc.shopID = model.location_id;
    goodsDescVc.goodsId = model.goodsID;
    [self.navigationController pushViewController:goodsDescVc animated:YES];
}


#pragma mark - CollectionView代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"babYSearchCollectionCell";
    SearchCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ShopGoodsModel *model = self.dataArray[indexPath.row];
    //[cell config:model];
    return cell;
}

#pragma mark CollectionViewcell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BabySearchModel *model = self.dataArray[indexPath.row];
    MovieGoodsInfoViewController *goodsDescVc = [[MovieGoodsInfoViewController alloc] init];
    goodsDescVc.shopID = model.location_id;
    goodsDescVc.goodsId = model.goodsID;
    [self.navigationController pushViewController:goodsDescVc animated:YES];
}


#pragma mark UICollectionViewDelegateFlowLayout
//返回每一个的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kViewWidth-4)/2, 256);
}

//定义每个collectionView的间距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(2, 2, 2, 2);
//}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

#pragma mark - 搜索按钮开始搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //收起键盘
    [textField resignFirstResponder];
    
    self.goodsName = textField.text;
    [self initLoadData];
    
    return YES;
}

/// 点击按钮执行的动画和参数的变化
- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
{
    [self.navigationController.navigationBar endEditing:YES];
    
    _btnType = btnType;
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = selectedBtn;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = btnLineFrame;
    }];
    
    [self.view endEditing:YES];
    
    if ([_btnType isEqualToString:@"2"]) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.myBlackView];
        [self.myBlackView addSubview:self.certifView];
    }else
    {
        [self.myBlackView removeFromSuperview];
    }
    
    
}

#pragma mark - 弹出分享框
- (void)shareAction:(UIButton *)btn
{
    self.shareView =  [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
    self.shareView.delegate = self;
    self.shareView.collectButton.enabled = NO;
    
    [self.shareView show];
}
#pragma mark - 删除分享视图
- (void)removeCusShareView
{
    [self.shareView myRemove];
}



#pragma mark - 分享代理方法
- (void)backIndex
{
    [self.shareView myRemove];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)messButtonAction
{
    [self removeCusShareView];
}
- (void)qqButtonAction
{
    [self removeCusShareView];
}

- (void)qzoneButtonAction
{
    [self removeCusShareView];
}

- (void)collectButtonAction
{
    [self removeCusShareView];

}

- (void)wechatButtonAction
{
    [self removeCusShareView];
}

- (void)timelineButtonAction
{
    [self removeCusShareView];
}

- (void)xinaButtonAction
{
    [self removeCusShareView];
}

- (void)tencentButtonAction
{
    [self removeCusShareView];
}

#pragma mark - 选择城市
- (void)cityName:(NSString *)CityName andCityId:(NSString *)cityId
{
    self.city_id = cityId;
    [self initLoadData];
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
