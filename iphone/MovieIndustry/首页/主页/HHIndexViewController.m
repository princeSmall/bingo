//
//  HHIndexViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHIndexViewController.h"
#import "SDCycleScrollView.h"
#import "SearchIndexController.h"
#import "ChooseCityController.h"
#import "LightningRentController.h"
#import "IndexFirstCell.h"
#import "SearchView.h"
#import "IndexCell.h"
#import "IndexAdCell.h"
#import "IndexGoodsCollectionCell.h"
#import "MovieSpecialViewController.h"
#import "MovieTopicCenterViewController.h"
#import "MovieTalkToPersonViewController.h"
#import "MovieGoodsInfoViewController.h"
#import "LeftActivityImgController.h"
#import "LoginInController.h"
#import "SearchViewCell.h"
#import "MovieMainDisplayViewController.h"
#import "CollectionHeadView.h"
#import "DealDetailViewController.h"
#import "PayOrderController.h"



@interface HHIndexViewController ()<UITableViewDataSource,UITableViewDelegate,ChooseCityControllerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,MovieArticleDetailDelegate,SDCycleScrollViewDelegate>
{
    UITableView *_tbView;
    UILabel *_locationLabel;
}
//广告数组
@property (nonatomic,strong) NSMutableArray *adListArray;
////文章数组
@property (nonatomic,strong) NSMutableArray *articleArray;
/**
 *  每个分类的商品数组
 */
@property (nonatomic,strong) NSMutableArray *homeDealListArr;


@property (nonatomic,strong) NSMutableArray *dealListArr;



@property (nonatomic,strong) NSMutableArray *activityArray;
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic,strong) UICollectionView *collectView;
@property (nonatomic,assign) BOOL isShowSearch;

@property (nonatomic,copy) NSString *cityID;
@property (nonatomic,strong) NSMutableArray *classArray;

//分页
@property (nonatomic,assign) NSUInteger page;


@property (nonatomic,strong)NSMutableArray *goodsArray;

@property (nonatomic,strong)NSMutableDictionary *imageDic;


@property (nonatomic,strong)NSMutableArray *sortArray;


@end

@implementation HHIndexViewController

-(NSMutableArray *)sortArray
{
    if(!_sortArray)
    {
        _sortArray = [ NSMutableArray array];
    }
    return _sortArray;
}

-(NSMutableArray *)dealListArr
{
    if(!_dealListArr)
    {
        _dealListArr = [ NSMutableArray array];
    }
    return _dealListArr;
}

-(NSMutableArray *)homeDealListArr
{
    if(!_homeDealListArr)
    {
        _homeDealListArr = [NSMutableArray array];
    }
    return _homeDealListArr;
}

-(NSMutableDictionary *)imageDic
{
    if(!_imageDic)
    {
        _imageDic = [NSMutableDictionary dictionary];
        [_imageDic setObject:[UIImage imageNamed:@"icon_qicai"] forKey:@"器材"];
        [_imageDic setObject:[UIImage imageNamed:@"icon_changdi"] forKey:@"场地"];
        [_imageDic setObject:[UIImage imageNamed:@"icon_renyuan"] forKey:@"人员"];
        
    }
    return _imageDic;
}

- (UICollectionView *)collectView
{
    if (!_collectView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //        flowLayout.headerReferenceSize = CGSizeMake(kViewWidth, 10.0f);
        
        _collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(4, 4, kViewWidth-8, 302 *3) collectionViewLayout:flowLayout];
        _collectView.dataSource=self;
        _collectView.delegate=self;
        [_collectView setBackgroundColor:[UIColor whiteColor]];
       
        //_collectView.scrollEnabled = NO;
        //注册Cell，必须要有
        //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
        [_collectView registerNib:[UINib nibWithNibName:@"IndexGoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"IndexGoodsCollectionCellID"];
        [_collectView registerClass:[CollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview"];
        [flowLayout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, 40)];
    }
    
    return _collectView;
}

- (NSMutableArray *)adListArray
{
    if (!_adListArray) {
        _adListArray = [NSMutableArray array];
    }
    
    return _adListArray;
}

- (NSMutableArray *)articleArray
{
    if (!_articleArray) {
        _articleArray = [NSMutableArray array];
    }
    
    return _articleArray;
}



- (NSMutableArray *)activityArray
{
    if (!_activityArray) {
        _activityArray = [NSMutableArray array];
    }
    
    return _activityArray;
}

-(NSMutableArray *)classArray
{
    if(!_classArray)
    {
        UIImage *imageqicai = [UIImage imageNamed:@"icon_qicai"];
        UIImage *imagerenyuan = [UIImage imageNamed:@"icon_renyuan"];
        UIImage *imagechangdi = [UIImage imageNamed:@"icon_changdi"];
        _classArray = [NSMutableArray arrayWithObjects:imagechangdi,imageqicai,imagerenyuan, nil];
    }
    return _classArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackColor;
    [self setNavTabBar];
    
    self.cityID =@"";
    
    //设置头部滚动视图
    self.page = 1;
    self.isShowSearch = NO;
    
    [self createTableView];
    
    
    [self loadAdvList];
    
    //加载首页文章列表
//    [self loadArticleList];
    
    //获得首页商品
    [self loadHomeGoodsData];
   
    //活动数据
//    [self loadActivityData];
    
    //添加刷新
    [self createRefresh];
    
}

#pragma mark - 添加刷新
- (void)createRefresh
{
    //添加下拉刷新
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        self.page = 1;
        //首页商品数据
        [self loadHomeGoodsData];
        
//        [self loadActivityData];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tbView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        
        self.page ++;
        //首页商品数据
        [self loadHomeGoodsData];
        
//        [self loadActivityData];
        
    }];
    _tbView.footer.automaticallyChangeAlpha = YES;
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-20-64-10) style:UITableViewStyleGrouped];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.backgroundColor = kViewBackColor;
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tbView];
    
    
    //设置头部View的大小
    UIView *tbHeaderView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, kViewWidth/2)];
    //
    UIImage * image1 = [UIImage imageNamed:@"zhouerqiang"];
    UIImage * image2 = [UIImage imageNamed:@"changdi"];
    UIImage * image3 = [UIImage imageNamed:@"dianpu"];
    UIImage * image4 = [UIImage imageNamed:@"qicai"];
    UIImage * image5 = [UIImage imageNamed:@"renyuan"];
    
    NSArray * imageArray = @[image1,image2,image3,image4,image5];
    SDCycleScrollView * bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kViewWidth, kViewWidth/2) imagesGroup:imageArray];
    bannerView.imageType = @"ds";
        bannerView.delegate = self;
    bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.bannerView = bannerView;
    
    //添加到头部视图
    [tbHeaderView addSubview:bannerView];
    
    //设置tableView的头部视图
    _tbView.tableHeaderView = tbHeaderView;
}


-(UIView *)customSnapshotFromView:(UIView *)inputView
{
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc]initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.1;
    snapshot.layer.shadowOffset = CGSizeMake(-5, 0);
    snapshot.layer.shadowRadius = 0.1;
    snapshot.layer.shadowOpacity = 0.4 ;
    return snapshot;
}

- (void)setNavTabBar
{
    
    UIButton *titleView = [WNController createButtonWithFrame:CGRectMake(0, 0, 140, 31) ImageName:@"cameFilm" Target:nil Action:nil Title:@""];
    titleView.userInteractionEnabled = NO;
    [titleView setContentEdgeInsets:UIEdgeInsetsMake(-4, 0, 4, 0)];
    self.navigationItem.titleView = titleView;
    
#warning 这边是城市选择（左），闪电租（右）按钮
    UIView *leftView = [WNController createViewFrame:CGRectMake(0, 0, 70, 30)];
    leftView.backgroundColor = kNavBarColor;
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(0, 1, 60, 30) Font:14 Text:@"上海" textAligment:NSTextAlignmentLeft];
    _locationLabel = navLabel;
    navLabel.textColor = [UIColor whiteColor];
    
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(50, 8, 18, 18) ImageName:@"index_03-03"];
    [leftView addSubview:navLabel];
    [leftView addSubview:navImage];
    //可以点击的按钮
    UIButton *navBtn  = [WNController createButtonWithFrame:CGRectMake(0, 0, 70, 30) ImageName:@"" Target:self Action:@selector(selectCityAction:) Title:@""];
    [leftView addSubview:navBtn];
    
    [navBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
//    闪电租
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 80, 25)];
    [rightBtn setTitle:@"闪电租" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"lightning"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    //添加点击事件
    [rightBtn addTarget:self action:@selector(lightningAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    /**
     *  这边没有调用闪电租按钮。
     */
    /**
     *  这边没有调用闪电租按钮。
     */
    /**
     *  这边没有调用闪电租按钮。
     */
//    [self.navigationItem setRightBarButtonItem:rightItem];

}

#pragma mark - lightning 闪电租
- (void)lightningAction
{
    if (!APP_DELEGATE.user_id) {
        LoginInController *loginVc = [[LoginInController alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:navC animated:YES completion:nil];
    }else
    {
        LightningRentController *lightingVc = [[LightningRentController alloc] init];
        [lightingVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:lightingVc animated:YES];
    }
    
}

#pragma mark - 搜索城市
- (void)selectCityAction:(UIButton *)btn
{
    ChooseCityController *chooseCityVc = [[ChooseCityController alloc] init];
    chooseCityVc.delegate = self;
    [chooseCityVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseCityVc animated:YES];
}

#pragma mark - 跳转到搜索栏
- (void)searchVcAction
{
    if (!APP_DELEGATE.user_id) {
        LoginInController *loginVc = [[LoginInController alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:navC animated:YES completion:nil];
    }else
    {
        SearchIndexController *searchVc = [[SearchIndexController alloc ] init];
        [searchVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:searchVc animated:YES];
    }
}


#pragma mark - 分组tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   return self.articleArray.count+3;
//    return 6;
}

#pragma mark 头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    ///第一行是搜索栏
    if (section == 0) {
        return 0.01f;
    }
    if (section == 3) {
        
        return 30;
    }
    
    if (section >=3) {
        return 1.0f;
    }
    
    if (section==1) {
        ///展示商品的高度
        if (self.homeDealListArr.count<1) {
            return 0.1f;
        }else
        {
            return 1;
        }
    }
    
    
    return 1;
}
//尾部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

//每组返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.isShowSearch) {
            return 1;
        }else
        {
            return 0;
        }
        
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    return 1;
}
#pragma mark 每组每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
//        return 163;
        /**
         *  这边关掉了，周二抢等一系列功能。
         *
         *  @param indexPath.section <#indexPath.section description#>
         *
         *  @return <#return value description#>
         */
        return 0;
    }
    
    
    if (indexPath.section == 0) {
//       return 45;
        /**
         *  这边关掉了搜索栏。
         */
        /**
         *  这边关掉了搜索栏。
         */
        /**
         *  这边关掉了搜索栏。
         */
        return 0;
    }
    if (indexPath.section == 1 )
        {
            
            int row1 = 0;
            int row2 = 0;

            for(int i =0 ;i<self.homeDealListArr.count;i++)
            {
                NSArray * arr = self.homeDealListArr[i];
                if(i!=2)
                {
                
                    row1+=arr.count/2;
                    if(arr.count%2>0)
                    {
                        row1++;
                    }
                }
                else
                {
                    row2+=arr.count/3;
                    if(arr.count%3>0)
                    {
                        row2++;
                    }
                }
            }

            if(row1>5)
            {
                row1=5;
            }
            if(row2>2)
            {
                row2=2;
            }
            return (kViewWidth-15)/2*147/119 *row1  +147*row2 +40*3 +30;
        }

    else
    {
//            return 87;
        /**
         *  这边关掉了下面的资讯等功能。
         *
         *  @param  <# description#>
         *
         *  @return <#return value description#>
         */
        return 0;
    }
}

#pragma mark - 头部的View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UILabel *label = [WNController createLabelWithFrame:CGRectMake(0, 0, kViewWidth, 30) Font:14 Text:@" 电影资讯" textAligment:NSTextAlignmentLeft];
        label.backgroundColor = kViewBackColor;
        label.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
        return label;
    }else
    {
        UIView *view = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 10)];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        SearchViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchViewCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, kViewWidth, 45);
        [btn addTarget:self action:@selector(searchVcAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        cell.contentView.hidden = YES;
        return cell;
        
    }else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"indexFirsrtCellID"];
        cell.backgroundColor = [UIColor whiteColor];
        int row1 = 0;
        int row2 = 0;
        
        for(int i =0 ;i<self.homeDealListArr.count;i++)
        {
            NSArray * arr = self.homeDealListArr[i];
            if(i!=2)
            {
                
                row1+=arr.count/2;
                if(arr.count%2>0)
                {
                    row1++;
                }
            }
            else
            {
                row2+=arr.count/3;
                if(arr.count%3>0)
                {
                    row2++;
                }
            }
          
        }
        if(row1>5)
        {
            row1=5;
          
        }
        if(row2>2)
        {
            row2=2;
        }
        self.collectView.frame = CGRectMake(6, 6, kViewWidth-12, (kViewWidth-15)/2*147/119 *row1  +147*row2 +40*3 +30);
        
        
        //添加collectionView
        [cell.contentView addSubview:self.collectView];
        
        
        return cell;
        
    }else if(indexPath.section == 2)
    {
        static NSString *cellID = @"IndexAdCell";
        IndexAdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"IndexAdCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ///给cell上面的按钮添加点击事件
            [cell.leftImageView addTarget:self action:@selector(leftImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
            ///摄影器材展览
            [cell.topImageView addTarget:self action:@selector(topImageViewAction) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.leftBottomView addTarget:self action:@selector(leftBottomViewAction) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.rightBottomView addTarget:self action:@selector(rightBottomViewAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
//        if (self.activityArray.count>=4) {
//            IndexAdModel *model1 = self.activityArray[0];
//            IndexAdModel *model2 = self.activityArray[1];
//            IndexAdModel *model3 = self.activityArray[2];
//            IndexAdModel *model4 = self.activityArray[3];
//            //左边的image
//            [cell.leftImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,model1.goodsImages]] forState:UIControlStateNormal];
//            
//            [cell.topImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,model2.goodsImages]] forState:UIControlStateNormal];
//            
//            [cell.leftBottomView sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,model3.goodsImages]] forState:UIControlStateNormal];
//            //            cell.leftBottomLabel.text = model3.goodsContent;
//            
//            [cell.rightBottomView sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,model4.goodsImages]] forState:UIControlStateNormal];
//            //            cell.rightBottomLabel.text = model4.goodsContent;
//            
        
//        }
        cell.contentView.layer.masksToBounds = YES;
        return cell;
    }else
    {
        static NSString *cellID = @"indexCellID";
        IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"IndexCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        IndexModel *model = self.articleArray[indexPath.section-3];
       [cell config:model];
        return cell;
    }
    
}


#pragma mark - 点击每行可以看到文章详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>=3) {
        if (!APP_DELEGATE.user_id) {
            
            LoginInController *loginVc = [[LoginInController alloc] init];
            UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
            [self presentViewController:navC animated:YES completion:nil];
        }else
        {
            MovieTalkToPersonViewController *talkVc = [[MovieTalkToPersonViewController alloc] init];
//            IndexModel *model = self.articleArray[indexPath.section-3];
//            talkVc.articleId = model.articleID;
//            talkVc.delegate = self;
            [talkVc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:talkVc animated:YES];
        }
    }
}

#pragma mark - 活动页展示图片 左边 周二抢
- (void)leftImageButtonAction
{
    if (!APP_DELEGATE.user_id) {
        
        LoginInController *loginVc = [[LoginInController alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:navC animated:YES completion:nil];
    }else
    {
        LeftActivityImgController *leftVc = [[LeftActivityImgController alloc] init];
        [leftVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:leftVc animated:YES];
    }
    
}

#pragma mark - 活动页展示图片 右上角
- (void)topImageViewAction
{
    MovieMainDisplayViewController *artileDetailVC = [[MovieMainDisplayViewController alloc] init];
    [artileDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:artileDetailVC animated:YES];
}

#pragma mark - 活动页展示图片 中间左下角
- (void)leftBottomViewAction
{
    MovieSpecialViewController *leftVc = [[MovieSpecialViewController alloc] init];
    [leftVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:leftVc animated:YES];
}

#pragma mark - 活动页展示图片 右下角
- (void)rightBottomViewAction
{
    MovieTalkToPersonViewController *leftVc = [[MovieTalkToPersonViewController alloc] init];
    [leftVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:leftVc animated:YES];
}

#pragma mark - CollectionView代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"IndexGoodsCollectionCellID";
    IndexGoodsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    IndexHomeDealModel *model = self.homeDealListArr[indexPath.section][indexPath.row];
    
    [cell config:model];
    
    return cell;
}

#pragma mark CollectionViewcell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr =self.homeDealListArr[section];
    if(section==0)
    {
        if(arr.count>6)
        {
            return 6;
         
        }
        else
        {
            return arr.count;
        }
    }
    if(section==1)
    {
        if(arr.count>4)
        {
            return 4;
        }
        else
        {
        
            return arr.count;
        }
    }
    if(section==2)
    {
        if(arr.count>6)
        {
            return 6;
        }
        else
        {
            return arr.count;
        }
    }
    return 0;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.homeDealListArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        MovieGoodsInfoViewController *movieGoodsVc = [[MovieGoodsInfoViewController alloc] init];

        IndexHomeDealModel *model = self.homeDealListArr[indexPath.section][indexPath.row];
        movieGoodsVc.goodsId = model.goods_id;
        ///店铺ID传值
        movieGoodsVc.shopID = model.shop_id;
        [movieGoodsVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:movieGoodsVc animated:YES];

}



#pragma mark UICollectionViewDelegateFlowLayout
//返回每一个的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 || indexPath.section==1)
    {
        return CGSizeMake((kViewWidth-15)/2, (kViewWidth-15)/2*147/119);
        
    }
    
    if(indexPath.section==2)
    {
        return CGSizeMake((kViewWidth-14)/3, 147);
    }
    
    
    
    return CGSizeMake(0, 0);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    if(kind == UICollectionElementKindSectionHeader)
    {
        CollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview" forIndexPath:indexPath];
       

        NSString * category =[self.sortArray objectAtIndex:indexPath.section];;
        
        [headerView.button setImage:[self.imageDic valueForKey:category] forState:UIControlStateNormal];
//        [headerView.button addTarget:self action:@selector(actionClass:) forControlEvents:UIControlEventTouchUpInside];
        reusableView = headerView;
    }
    return reusableView;
}



//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==2)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}


#pragma mark - 选择城市的代理方法
- (void)cityName:(NSString *)CityName andCityId:(NSString *)cityId
{
    _locationLabel.text = CityName;
    self.cityID = cityId;
    
    //加载展示也得数据
    [self loadHomeGoodsData];
    
}




#pragma mark - 头部滚动广告
- (void)loadAdvList
{
    
    
//    [HttpRequestServers requestBaseUrl:Adv_list withParams:nil withRequestFinishBlock:^(id result) {
//        
//        NSDictionary *dict = result;
//        //        HHNSLog(@"%@",dict);
//        @try {
//            if ([dict[@"status"] isEqualToString:@"f99"])
//            {
//                [self.adListArray removeAllObjects];
//                
//                NSArray *listArray = dict[@"list"];
//                for (NSDictionary *infoDic in listArray) {
//                    [self.adListArray addObject:infoDic[@"img"]];
//                }
//                
//                self.bannerView.pictures = self.adListArray;
//            }
//        }
//        @catch (NSException *exception) {
//            
//        }
//        @finally {
//            
//        }
//        
//    } withFieldBlock:^{
//        
//    }];
}


#pragma mark - 首页活动内容
- (void)loadActivityData
{
    [HttpRequestServers requestBaseUrl:Shop_activity_img withParams:nil withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        //        HHNSLog(@"%@",dict);
        @try {
            if ([dict[@"status"] isEqualToString:@"f99"])
            {
                [self.activityArray removeAllObjects];
                
                
                NSArray *listArray = dict[@"list"];
                for (NSDictionary *infoDic in listArray) {
                    
                    IndexAdModel *model = [[IndexAdModel alloc] init];
                    model.goodsImages = infoDic[@"images"];
                    model.goodsContent = infoDic[@"content"];
                    model.goodsName = infoDic[@"name"];
                    [self.activityArray addObject:model];
                }
                
                //刷新collectionView的数据
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
        
    } withFieldBlock:^{
        
        
    }];
}


#pragma mark - 加载首页展览物品的数据 产品展示
- (void)loadHomeGoodsData

{
    __weak typeof(self) weakSelf = self;
   
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    
    
    
    
    [HttpRequestServers requestBaseUrl:TIGoods_List withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"---->%@",dict);

            if ([dict[@"code"] intValue]==0)
            {
                [weakSelf.dealListArr removeAllObjects];
                [weakSelf.homeDealListArr removeAllObjects];
                id listArray = dict[@"data"];
                if(![[listArray class] isSubclassOfClass:[NSArray class]])
                {
                    [weakSelf.homeDealListArr addObject:weakSelf.dealListArr];
                }
                else
                {
                    self.dealListArr = [NSMutableArray array];
                    for (NSDictionary *infoDic in listArray)
                    {
                        weakSelf.dealListArr = [NSMutableArray array];
                        HHNSLog(@"%@",infoDic[@"shop_goods"]);
                        NSArray *goodsArray = infoDic[@"shop_goods"];
                        [self.sortArray addObject:infoDic[@"category_name"]];
                        for(NSDictionary *goodDic in goodsArray)
                        {
                            IndexHomeDealModel *model = [[IndexHomeDealModel alloc] initWithDic:goodDic];
                            [weakSelf.dealListArr addObject:model];
                        }
                        NSMutableArray *arr = [weakSelf.dealListArr mutableCopy];
                        [weakSelf.homeDealListArr addObject:arr];

                    }
                    
                    //刷新collectionView的数据
                    
               
                    [_tbView reloadData];
               
                    [self.collectView reloadData];
                    HHNSLog(@"homeDealListArr---%@",weakSelf.homeDealListArr);
                    //结束刷新
                    [_tbView.header endRefreshing];
                    [_tbView.footer endRefreshing];
                }
            }
    } withFieldBlock:^{
        
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isShowSearch == NO) {
        self.isShowSearch = YES;
        NSIndexSet *indexSet1 = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)];
        [_tbView reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationFade];
    }
}



#pragma mark - 文章详情评论成功代理(刷新界面)
//- (void)commentArticleSuccess:(BOOL)isSuccess
//{
//    if (isSuccess) {
//        self.page = 1;
//        [self loadArticleList];
//    }
//}

#pragma mark - 切换文章
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (index == 1) {
        MovieTalkToPersonViewController *talkVc = [[MovieTalkToPersonViewController alloc] init];
        talkVc.articleId = @"13";
        talkVc.delegate = self;
        [talkVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:talkVc animated:YES];
    }
    
    if (index==2) {
        MovieTalkToPersonViewController *talkVc = [[MovieTalkToPersonViewController alloc] init];
        talkVc.articleId = @"14";
        talkVc.delegate = self;
        [talkVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:talkVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)actionClass:(UIButton *)sender
{
    DealDetailViewController *detailVc = [[DealDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];

}
@end
