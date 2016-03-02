//
//  OurShopSearchController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//
#define btnWidth (kViewWidth-42)
#import "OurShopSearchController.h"
#import "CollectGoodsCell.h"

@interface OurShopSearchController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
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

@property (nonatomic,strong)UICollectionView *collectView;
@end

@implementation OurShopSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@""];
    [self setNavTabBar];
    [self createUI];
}

- (void)createUI
{
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 42)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(40, 40, btnWidth/2-80, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, btnWidth/2, 42) ImageName:@"" Target:self Action:@selector(salesAction:) Title:@"类型" fontSize:15];
    
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(btnWidth/2, 0, btnWidth/2, 42) ImageName:@"" Target:self Action:@selector(priceAction:) Title:@"价格" fontSize:15];
    [btnView addSubview:btn2];
    
    UIButton *switchViewBtn= [WNController createButtonWithFrame:CGRectMake(btnWidth, 0, 42, 42) ImageName:@"search_block" Target:self Action:@selector(switchViewAction:) Title:@""];
    [switchViewBtn setImage:[UIImage imageNamed:@"search_normal"] forState:UIControlStateSelected];
    [btnView addSubview:switchViewBtn];
    
    [self createTableView];
    [self createCollectionView];
}


//#pragma mark - 添加刷新
//- (void)createRefresh
//{
//    //添加下拉刷新
//    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _page = 1;
//        _isFooterFresh = NO;
//        [self loadData];
//    }];
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    _tbView.header.automaticallyChangeAlpha = YES;
//    
//    //上拉加载
//    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        _page++;
//        _isFooterFresh = YES;
//        [self loadData];
//        
//    }];
//    _tbView.footer.automaticallyChangeAlpha = YES;
//}

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
    textField.placeholder = @"店铺内查找";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    
    UIImageView *searchImage = [WNController createImageViewWithFrame:CGRectMake((isScreen4?196:218), 5, 20, 20) ImageName:@"search_index"];
    
    [view addSubview:textField];
    [view addSubview:searchImage];
    //设置头部的View
    self.navigationItem.titleView = view;
    
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, kViewWidth, kViewHeight-44-42) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 10.0f)];
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
    [self.collectView setBackgroundColor:kViewBackColor];
    
    //注册Cell，必须要有
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collectView registerNib:[UINib nibWithNibName:@"SearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
}

- (void)salesAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(40, 40, btnWidth/2-80, 2)];
}

- (void)priceAction:(UIButton *)btn
{
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(btnWidth/2+40, 40, btnWidth/2-80, 2)];
}


#pragma mark - 切换视图
- (void)switchViewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [self.view addSubview:_collectView];
        [_tbView removeFromSuperview];
        [_collectView reloadData];
    }else
    {
        [self.view addSubview:_tbView];
        [_collectView removeFromSuperview];
        [_tbView reloadData];
    }
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"searchResultCellID";
    CollectGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectGoodsCell" owner:nil options:nil] lastObject];
    }
    return cell;
}




#pragma mark - CollectionView代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark CollectionViewcell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
    
    [_tbView reloadData];
}

#pragma MARK - 文本框代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
