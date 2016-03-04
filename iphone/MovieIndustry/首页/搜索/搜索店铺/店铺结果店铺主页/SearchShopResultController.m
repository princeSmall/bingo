//
//  SearchShopResultController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#define btnWidth (kViewWidth-42)
#import "SearchShopResultController.h"
//#import "OurShopSearchController.h"
#import "SearchShopHeaderView.h"
#import "ShopDetailController.h"
#import "SearchCollectionCell.h"
#import "ShopGoodsCell.h"
#import "MovieGoodsInfoViewController.h"
#import "ShareView.h"
#import "MainTabBarController.h"
#import "ShopGoodsModel.h"
#import <ShareSDK/ShareSDK.h>

#import "ShopContentModel.h"

typedef void (^babyClassify)(void);
@interface SearchShopResultController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ShareViewDelegate>
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
//宝贝分类回调
@property (nonatomic,copy)babyClassify babyClassfyFn;
///分享UI
@property (nonatomic,strong) ShareView *shareView;
///头部的View
@property (nonatomic,strong) SearchShopHeaderView *searchHeaderView;

///collectionView
@property (nonatomic,strong)UICollectionView *collectView;
//当前页
@property (nonatomic,assign) int page;

///tableView数据源数组
@property (nonatomic,strong) NSMutableArray *dataArray;
//宝贝列表数据
@property (nonatomic,strong) NSMutableArray *listTypeArray;
///分类列表ID
@property (nonatomic,strong) NSMutableArray *listTypeIDArray;
///滚动视图View
@property (nonatomic,strong) UIPickerView *listTypePickView;

///滚动视图背景View
@property (nonatomic,strong) UIView *pickBgView;
///当期选中的宝贝分类数据id
@property (nonatomic,copy) NSString *baByType;

//尾部刷新
@property (nonatomic,assign) BOOL isFooterFresh;
//分享的Image
@property (nonatomic,strong) UIImage *shareImage;
//开店人的用户id
@property (nonatomic,copy) NSString *shop_user_id;
//最新排序
//@property (nonatomic,copy) NSString *theNewGoods;
//搜索字段
@property (nonatomic,copy) NSString *searchWords;
//搜索框
@property (nonatomic,strong) UITextField *searchTextField;
////店铺首页列表
//@property (nonatomic,strong)NSMutableArray *shopListArray;

//店铺的一级分类
@property(nonatomic,strong)NSMutableArray * categoryArr;

@property (nonatomic,assign)int selectNumber;
@end

@implementation SearchShopResultController


-(NSMutableArray *)categoryArr
{
    if(!_categoryArr)
    {
        _categoryArr = [NSMutableArray array];
        
    }
    return _categoryArr;
}
- (SearchShopHeaderView *)searchHeaderView
{
    if (!_searchHeaderView) {
        _searchHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"SearchShopHeaderView" owner:nil options:nil] lastObject];
        _searchHeaderView.frame = CGRectMake(0, 0, kViewWidth, 128);
        //[_searchHeaderView.shopDetailButton addTarget:self action:@selector(shopDetailButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_searchHeaderView.callPhoneButton addTarget:self action:@selector(callPhoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchHeaderView;
}

- (void)callPhoneButtonAction
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_searchHeaderView.shopPhoneLabel.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


- (UIView *)pickBgView
{
    if (!_pickBgView) {
        _pickBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 42+128+10, kViewWidth, kViewHeight-44-42-120-10)];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickBgViewAction:)];
        [_pickBgView addGestureRecognizer:tapGes];    }
    return _pickBgView;
}

- (void)pickBgViewAction:(UIGestureRecognizer *)g
{
    [g.view removeFromSuperview];
}

- (UIPickerView *)listTypePickView
{
    if (!_listTypePickView) {
        _listTypePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 120)];
        _listTypePickView.backgroundColor = [UIColor whiteColor];      _listTypePickView.delegate = self;
        _listTypePickView.dataSource = self;
        _listTypePickView.showsSelectionIndicator = YES;
    }
    return _listTypePickView;
}

- (NSMutableArray *)listTypeIDArray
{
    if (!_listTypeIDArray) {
        _listTypeIDArray = [NSMutableArray array];
    }
    return _listTypeIDArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)listTypeArray
{
    if (!_listTypeArray) {
        _listTypeArray = [NSMutableArray array];
    }
    return _listTypeArray;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationItem.titleView endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackItem];
    [self setNavRightImage:@"search_more" rightAction:@selector(shareAction:)];
    [self setNavTabBar];
    self.baByType = @"0";
    self.page = 1;
    self.selectNumber =1;
    //搜搜
    self.searchWords = @"";
    //最新
//    self.theNewGoods = @"";
    
    [self createUI];
    
    ///进入店铺的数据
    [self loadData];
    [self loadGoodsList];
    
    
    
    [self createRefresh];
}

#pragma mark - 添加刷新
- (void)createRefresh
{
    //添加下拉刷新
    _tbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        _isFooterFresh = NO;
        [self judge];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tbView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _tbView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        _isFooterFresh = YES;
       // [self loadData];
        [self judge];
        
    }];
    _tbView.footer.automaticallyChangeAlpha = YES;
    
    
    _collectView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        _isFooterFresh = NO;
        [self judge];
       
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _collectView.header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    _collectView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        _isFooterFresh = YES;
        [self judge];
      
    }];
    _collectView.footer.automaticallyChangeAlpha = YES;
    
}

-(void)judge
{
    switch (self.selectNumber) {
        case 1:
            [self loadGoodsList];
            break;
            
        case 2:
            [self  loadTypeGoodsList:self.baByType];
            break;
            
        case 3:
            [self loadNeWGoods];
            break;
            
        default:
            break;
    }


}


#pragma mark - 弹出分享框
- (void)shareAction:(UIButton *)btn
{
    self.shareView =  [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
    self.shareView.delegate = self;
    
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
    MainTabBarController *tabControl = [[MainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabControl;
}


- (void)qqButtonAction
{
    [self removeCusShareView];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"咔么电影"
                                       defaultContent:@"咔么电影"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影网"
                                                  url:@"http://www.comfilm.com"
                                          description:@"咔么电影网"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent type:ShareTypeQQ authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSResponseStateSuccess)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
            [DeliveryUtility showMessage:@"分享成功" target:nil];
        }
        else if (state == SSResponseStateFail)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
        }
        
        
    }];
}



- (void)collectButtonAction
{
    [self removeCusShareView];
    [MovieHttpRequest createCollectMyFavourableStoreWithStoreId:self.shopId CallBack:^(id obj) {
        
        
//        [PromptLabel custemAlertPromAddView:self.view text:@"收藏成功"];
         [DeliveryUtility showMessage:@"收藏成功" target:nil];
        
        
    } andSCallBack:^(id obj) {
        
        
        NSString *infoDict = obj;
        //        HHNSLog(@"%@",infoDict);
        if([infoDict isEqualToString:@"thing_id has been in collection table"])
        {
//            [PromptLabel custemAlertPromAddView:self.view text:@"该店铺已被收藏"];
             [DeliveryUtility showMessage:@"该店铺已经被收藏" target:nil];
        }
        else
        {
//            [PromptLabel custemAlertPromAddView:self.view text:@"收藏失败"];
             [DeliveryUtility showMessage:@"收藏失败" target:nil];
        }

    }];
}

- (void)wechatButtonAction
{
    [self removeCusShareView];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"咔么电影"
                                       defaultContent:@"咔么电影"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影"
                                                  url:@"http://www.comfilm.com"
                                          description:@"咔么电影网"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent type:ShareTypeWeixiSession authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSResponseStateSuccess)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
            [DeliveryUtility showMessage:@"分享成功" target:nil];
        }
        else if (state == SSResponseStateFail)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
        }
        
        
    }];
}

- (void)timelineButtonAction
{
    [self removeCusShareView];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"咔么电影"
                                       defaultContent:@"咔么电影"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影"
                                                  url:@"http://www.comfilm.com"
                                          description:@"咔么电影网"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent type:ShareTypeWeixiTimeline authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSResponseStateSuccess)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
            [DeliveryUtility showMessage:@"分享成功" target:nil];
        }
        else if (state == SSResponseStateFail)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
        }
        
        
    }];
}

- (void)xinaButtonAction
{
    [self removeCusShareView];
    
    NSString *strUrl = @"http://www.comfilm.com";
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",@"咔么电影网",strUrl]
                                       defaultContent:@"咔么电影网"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影网"
                                                  url:@"http://www.comfilm.com"
                                          description:@"咔么电影网"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent type:ShareTypeSinaWeibo authOptions:nil shareOptions:nil statusBarTips:YES result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        if (state == SSResponseStateSuccess)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
            [DeliveryUtility showMessage:@"分享成功" target:nil];
        }
        else if (state == SSResponseStateFail)
        {
            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
        }
        
        
    }];
}




#pragma mark - 宝贝分类
- (void)loadType :(NSString *)parent_id judge:(int)judgement
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [userDict setValue:parent_id forKey:@"parent_id"];
    
    [HttpRequestServers requestBaseUrl:TIPublish_Categories withParams:userDict withRequestFinishBlock:^(id result) {
        
        NSDictionary *dict = result;
        if(judgement==0)
        {
            self.listTypeArray = [NSMutableArray array];
            self.listTypeIDArray = [NSMutableArray array];
        }
        HHNSLog(@"loadTypeList -----%@",dict);
        
        @try {
            if ([dict[@"code"] intValue] ==0) {
                for (NSDictionary *listDict in dict[@"data"]) {
                    [self.listTypeArray addObject:listDict[@"category_name"]];
                    [self.listTypeIDArray addObject:listDict[@"category_id"]];
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        [_tbView reloadData];
        [_collectView reloadData];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
        [_collectView.header endRefreshing];
        [_collectView.footer endRefreshing];
        _babyClassfyFn();
        
    } withFieldBlock:^{
        
    }];
}

#pragma mark -下载店铺数据
- (void)loadData
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    ////location_id店铺ID ， p分页数  location_deal_type_id宝贝分类 pan，最新上架  like查询
//    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.shopId,@"location_id",[NSString stringWithFormat:@"%ld",self.page],@"p",self.baByType,@"location_deal_type_id",self.searchWords,@"like",self.theNewGoods,@"pan", nil];
    
    NSMutableDictionary * userDict = [NSMutableDictionary dictionary];
    userDict[@"user_id"] = APP_DELEGATE.user_id;
    userDict[@"shop_id"] = self.shopId;
    
    
    [HttpRequestServers requestBaseUrl:TIShop_ShopDetail withParams:userDict withRequestFinishBlock:^(id result) {
        
        @try {
            
           
            NSDictionary *dict = result;
            HHNSLog(@"%@",dict);
            
            ///用户信息
            NSArray * dicArray = dict[@"data"];
            NSDictionary * shopDict = [dicArray firstObject];
            ShopContentModel * shopModel = [[ShopContentModel alloc]initWithDict:shopDict];
            NSLog(@"%@",shopModel);
            [self.searchHeaderView.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,[WNController nullString:shopModel.shop_logo]]]];
            
            self.searchHeaderView.shopNameLabel.text = shopModel.shop_name;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.searchHeaderView.shopNameLabel.frame)-50,self.searchHeaderView.shopNameLabel.frame.origin.y-10 , 30, 30)];
            imageView.image = [UIImage imageNamed:@"shop_03"];
//            
           [self.searchHeaderView addSubview:imageView];
            
            self.searchHeaderView.shopAddressLabel.text = shopModel.shop_addr_detail;
            self.searchHeaderView.shopPhoneLabel.text = shopModel.shop_tel;
            StarView *startView = [[StarView alloc] initWithFrame:CGRectMake(kViewWidth-90, 20, 80, 20) score:0 canscore:@"0"];
        
            if ([[WNController nullString:shopModel.status] isEqualToString:@""]) {
                [self.searchHeaderView addSubview:startView];
            }else
            {
//                    NSInteger startCount = [shopModel.status integerValue];
//                    [startView createStartView:startCount];
                [self.searchHeaderView addSubview:startView];
            }
                
            self.shop_user_id = shopModel.user_id;
            NSArray * array;
            if(shopModel.category_id.length>1)
            {
                 array = [shopModel.category_id componentsSeparatedByString:@"3"];
               
                [self.categoryArr removeLastObject];
                
            }
            else
            {
                self.categoryArr = [NSMutableArray arrayWithObjects:shopModel.category_id, nil];
            }
            for(int i=0;i<array.count;i++)
            {
                NSString *str = array[i];
                if([str isEqualToString:@"1"])
                {
                    NSString *strg = [NSString stringWithFormat:@"%d",i+1];
                    
                    [self.categoryArr addObject:strg];
                }
            }
            
            
           
      
     
            [_tbView reloadData];
            [_collectView reloadData];
            //结束刷新
            [_tbView.header endRefreshing];
            [_tbView.footer endRefreshing];
                
            [_collectView.header endRefreshing];
            [_collectView.footer endRefreshing];
            //加载宝贝分类接口
            __block  int n = 0;
            __weak typeof(self) weakSelf = self;
            [self loadType:self.categoryArr[n] judge:n ];
            _babyClassfyFn = ^{
                n++;
                if (n<weakSelf.categoryArr.count)
                {
                    [weakSelf loadType:weakSelf.categoryArr[n] judge:n];
                }
                
            };
            

            
        }

        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            ///scallBack 不能写nil
        }];
        
    } withFieldBlock:^{
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
        }];
    }];
    
}

- (void)createUI
{
    [self.view addSubview:self.searchHeaderView];
    
    
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, 128+10, kViewWidth, 42)];
    [self.view addSubview:btnView];
    _btnLine = [[UIView alloc] initWithFrame:CGRectMake(10, 40, btnWidth/3-20, 2)];
    _btnLine.backgroundColor = [UIColor redColor];
    [btnView addSubview:_btnLine];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, btnWidth/3, 42) ImageName:@"" Target:self Action:@selector(salesAction:) Title:@"店铺首页" fontSize:15];
    btn1.tag =1;
    
    _btnType = @"0";
    _selectedBtn = btn1;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btnView addSubview:btn1];
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(btnWidth/3, 0, btnWidth/3, 42) ImageName:@"" Target:self Action:@selector(priceAction:) Title:@"宝贝分类" fontSize:15];
    [btnView addSubview:btn2];
    btn2.tag=2;
    
    UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(btnWidth/3*2, 0, btnWidth/3, 42) ImageName:@"" Target:self Action:@selector(typeAction:) Title:@"最新上架" fontSize:15];
    [btnView addSubview:btn3];
    btn3.tag=3;
    
    UIButton *switchViewBtn= [WNController createButtonWithFrame:CGRectMake(btnWidth, 0, 42, 42) ImageName:@"search_block" Target:self Action:@selector(switchViewAction:) Title:@""];
    [switchViewBtn setImage:[UIImage imageNamed:@"search_normal"] forState:UIControlStateSelected];
    [btnView addSubview:switchViewBtn];
    
    [self createTableView];
    [self createCollectionView];
}

#pragma mark - 点击图片进入商铺详情
- (void)shopDetailButtonAction
{
    ShopDetailController *descVc = [[ShopDetailController alloc] init];
    descVc.shopID = self.shopId;
    [self.navigationController pushViewController:descVc animated:YES];
}

- (void)createTableView
{
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 42+128+10, kViewWidth, kViewHeight-44-42-128-10) style:UITableViewStylePlain];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tbView.backgroundColor = kViewBackColor;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *view = [[UIView alloc] init];
    _tbView.tableFooterView = view;
    
    _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tbView.bounds.size.width, 1.0f)];
    [self.view addSubview:_tbView];
    
}

#pragma mark - 创建CollectionView
- (void)createCollectionView
{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(kViewWidth, 1.0f);
    
    self.collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 42+128+10, kViewWidth, kViewHeight-44-42-128-10) collectionViewLayout:flowLayout];
    self.collectView.dataSource=self;
    self.collectView.delegate=self;
    self.collectView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.collectView setBackgroundColor:kViewBackColor];
    
    //注册Cell，必须要有
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collectView registerNib:[UINib nibWithNibName:@"SearchCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"shopSearchCollectionCell"];
    
}

#pragma mark - 店铺宝贝
- (void)salesAction:(UIButton *)btn
{
    [self setBtnType:@"0" selectBtn:btn btnLineFrame:CGRectMake(10, 40, btnWidth/3-20, 2)];
    
    [self loadGoodsList];
    
}

/**
 *  宝贝分类按钮
 *
 *  @param btn 按钮
 */
- (void)priceAction:(UIButton *)btn
{
    [self setBtnType:@"1" selectBtn:btn btnLineFrame:CGRectMake(btnWidth/3+10, 40, btnWidth/3-20, 2)];
    NSInteger count = self.listTypeArray.count;
    if (count>0) {
        [self.listTypePickView selectRow:4 inComponent:0 animated:NO];
        self.listTypePickView.frame = CGRectMake(0, 0, kViewWidth, 120);
        [self.pickBgView addSubview:self.listTypePickView];
        ///滚动视图
        [self.view addSubview:self.pickBgView];
    }else
    {
        [self.pickBgView removeFromSuperview];
    }
}

- (void)typeAction:(UIButton *)btn
{
    [self setBtnType:@"2" selectBtn:btn btnLineFrame:CGRectMake(btnWidth/3*2+10, 40, btnWidth/3-20, 2)];
    [self loadNeWGoods];
 
}

//最新上架
-(void)loadNeWGoods
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [userDict setValue:self.shopId forKey:@"shop_id"];
    [userDict setValue:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    
    [HttpRequestServers requestBaseUrl:TIShop_newGoodsList withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        if([dict[@"code"] intValue]==0)
        {
            id arr = dict[@"data"];
            if(self.page==1)
            {
                self.dataArray = [NSMutableArray array];
            }
            if(![[arr class] isSubclassOfClass:[NSArray class]])
            {
            
            }
            else
            {
                for(NSDictionary *dic in arr)
                {
                    ShopGoodsModel *model =[[ShopGoodsModel alloc]initWithDict:dic];
                    [self.dataArray addObject:model];
                }
            }
        }
        [_tbView reloadData];
        [_collectView reloadData];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
    
        [_collectView.header endRefreshing];
        [_collectView.footer endRefreshing];

        
    } withFieldBlock:^{
        
    }];
   

}

#pragma mark - 切换视图
- (void)switchViewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        [self.view addSubview:_collectView];
        [_tbView removeFromSuperview];

        self.page = 1;
        [self judge];
        
        
    }else
    {
        [self.view addSubview:_tbView];
        [_collectView removeFromSuperview];

        self.page = 1;
        [self judge];
        
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
    [self.navigationController popViewControllerAnimated:YES];
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
    
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(14, 1, 40, 30) Font:16 Text:@"本店" textAligment:NSTextAlignmentCenter];
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(53, 8, 14, 14) ImageName:@"15-07"];
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(74, 2, (isScreen4?146:168), 28) boreStyle:UITextBorderStyleNone font:15];
    textField.placeholder = @"你想找什么？";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    self.searchTextField = textField;
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

     UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake((isScreen4?196:218), 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchShopAction)];
    
    [view addSubview:navLabel];
    [view addSubview:navImage];
    [view addSubview:textField];
    [view addSubview:searchArticleBtn];
    //设置头部的View
#warning 搜索暂时隐藏
    self.navigationItem.titleView = view;
}

#pragma mark - 搜索店铺内的宝贝
- (void)searchShopAction
{
    //收起键盘
    [self.searchTextField resignFirstResponder];
    
    self.page = 1;
    self.baByType = @"0";
//    self.theNewGoods = @"";
    self.searchWords = self.searchTextField.text;
    [self loadData];
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
    ShopGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopGoodsCell" owner:nil options:nil] lastObject];
    }
   
    ShopGoodsModel *model = self.dataArray[indexPath.row];
    [cell config:model];
    return cell;
}

#pragma mark - 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGoodsModel *model = self.dataArray[indexPath.row];
    

    
    MovieGoodsInfoViewController *goodsDescVc = [[MovieGoodsInfoViewController alloc] init];
    
    if (!self.isShop) {
        goodsDescVc.isShop = @"ture";

    }
    goodsDescVc.shopID = self.shopId;
    goodsDescVc.goodsId = model.goods_id;
    [self.navigationController pushViewController:goodsDescVc animated:YES];
}



#pragma mark - CollectionView代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"shopSearchCollectionCell";
    SearchCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ShopGoodsModel *model = self.dataArray[indexPath.row];
    [cell config:model];
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
    ShopGoodsModel *model = self.dataArray[indexPath.row];
    MovieGoodsInfoViewController *goodsDescVc = [[MovieGoodsInfoViewController alloc] init];
    goodsDescVc.shopID = self.shopId;
    goodsDescVc.goodsId = model.goods_id;
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
    
    self.page = 1;
    self.baByType = @"0";
//    self.theNewGoods = @"";
    self.searchWords = textField.text;
    [self loadData];
    
    return YES;
}

/// 点击按钮执行的动画和参数的变化
- (void)setBtnType:(NSString *)btnType selectBtn:(UIButton *)selectedBtn btnLineFrame:(CGRect)btnLineFrame
{
    [self.pickBgView removeFromSuperview];
    _btnType = btnType;
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = selectedBtn;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = btnLineFrame;
        
        
    }];
    self.selectNumber = (int)selectedBtn.tag;
    self.page=1;
    //[self judge];
//    if ([_btnType isEqualToString:@"0"]) {
//        //店铺首页数据
//        self.page =1;
//        self.searchWords = @"";
//        self.baByType = @"0";
//        self.theNewGoods = @"0";
////        [self loadGoodsList];
////        [self loadData];
//    }
//    if ([_btnType isEqualToString:@"2"]) {
//        //最新上架数据
//        self.page = 1;
//        self.searchWords = @"";
//        self.baByType = @"0";
//        self.theNewGoods = @"1";
 //       [self loadData];
//    }
}

#pragma mark Picker Date Source Methods 
//只要一组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
///每组有多少
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  self.listTypeArray.count;
}

#pragma mark Picker Delegate Methods 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.listTypeArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

///取到当期行的地址
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //移除弹出框
    [self.pickBgView removeFromSuperview];
    self.baByType = self.listTypeIDArray[row];
    
    
    self.page = 1;
//    self.theNewGoods = @"0";
    //掉数据
    [self loadTypeGoodsList:self.baByType];
    
}

/**
 *  店铺宝贝分类商品列表
 */
-(void)loadTypeGoodsList:(NSString *)goods_category_id
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [userDict setValue:self.shopId forKey:@"shop_id"];
    [userDict setValue:goods_category_id forKey:@"goods_category_id"];
    [userDict setValue:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    
    [HttpRequestServers requestBaseUrl:TIShop_cateGoodsList withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        if([dict[@"code"] intValue]==0)
        {
            id arr = dict[@"data"];
            
            if(self.page==1)
            {
                self.dataArray = [NSMutableArray array];
            }
            if(![[arr class]isSubclassOfClass:[NSArray class]])
            {
               
            }
            else
            {
                for(NSDictionary *dic in arr)
                {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc]initWithDict:dic];
                    [self.dataArray addObject:model];
                }
            }
            
        }
        
        [_tbView reloadData];
        [_collectView reloadData];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
        [_collectView.header endRefreshing];
        [_collectView.footer endRefreshing];
        
        
    } withFieldBlock:^{
        
    }];
    
    
}

#pragma mark - 判断输入时的变化
- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        
        self.page = 1;
        self.baByType = @"0";
//        self.theNewGoods = @"0";
        self.searchWords = textField.text;
        [self loadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载店铺首页列表
-(void)loadGoodsList
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id", nil];
    [userDict setValue:self.shopId forKey:@"shop_id"];
    [userDict setValue:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    NSLog(@"%@",TIShop_goodsList);
    [HttpRequestServers requestBaseUrl:TIShop_goodsList withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        if([dict[@"code"] intValue]==0)
        {
            id arr = dict[@"data"];
            if(self.page==1)
            {
                _dataArray = [NSMutableArray array];
            }
            if(![[arr class] isSubclassOfClass:[NSArray class]])
            {
                
            }
            else
            {
                for(NSDictionary *dic in arr)
                {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc]initWithDict:dic];
                    [self.dataArray addObject:model];
                }
            }
            
          
        }
        [_tbView reloadData];
        [_collectView reloadData];
        [_tbView.header endRefreshing];
        [_tbView.footer endRefreshing];
        
        [_collectView.header endRefreshing];
        [_collectView.footer endRefreshing];
        
    } withFieldBlock:^{
        
    }];

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
