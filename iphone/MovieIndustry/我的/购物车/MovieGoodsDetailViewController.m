//
//  MovieGoodsDetailViewController.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 1/26/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#define BTN_START_TAG 200
#import "MovieGoodsDetailViewController.h"
#import "MovieComfirmOrderViewController.h"
#import "ShopingCarSelectView.h"
#import "SearchShopResultController.h"
#import "LoginInController.h"
#import "ShareView.h"
#import "GoodsInfoHeaderView.h"
#import "GoodsDetailTableCell.h"
#import "GoodsCommentModel.h"
#import <ShareSDK/ShareSDK.h>

@interface MovieGoodsDetailViewController ()<ShareViewDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

///底部的View
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *selectBgView;
///购物车View
@property (nonatomic,strong) ShopingCarSelectView *shopingCarView;
///tableView头部滚动视图
@property (nonatomic,strong) GoodsInfoHeaderView *goodsTbHeaderView;
///tableView
@property (nonatomic,strong) UITableView *tbView;
///分享UI
@property (nonatomic,strong) ShareView *shareView;
///h5 web
@property (nonatomic,strong) UIWebView *webView;
////商品库存
@property (nonatomic,copy) NSString *goodsMaxBought;
///商品尺寸
@property (nonatomic,strong) NSMutableArray *goodsChicunArray;
///商品颜色
@property (nonatomic,strong) NSMutableArray *goodsColorsArray;
///当前选中的颜色按钮
@property (nonatomic,strong) UIButton *selectedColorBtn;
///当期选中的型号按钮
@property (nonatomic,strong) UIButton *selectedXinhaoBtn;
///当前的价格
@property (nonatomic,copy) NSString *curretPrice;
////滚动视图的图片数组
@property (nonatomic,strong) NSMutableArray *imgsArray;
//选择按钮
@property (nonatomic,strong) UIButton *selectedBtn;
///下划线
@property (nonatomic,strong) UIView *btnLine;
///状态 0 代表详情 1 代表评论
@property (nonatomic,copy)NSString * btnType;
////加入购物车图片
@property (nonatomic,copy) NSString * goodsCarImg;
///评论分页
@property (nonatomic,assign) NSUInteger page;
//评论数组
@property (nonatomic,strong) NSMutableArray *commentArray;
//分享的Image
@property (nonatomic,strong) UIImage *shareImage;

@property (nonatomic,copy) NSString *goodsDesc_Url;
@end

@implementation MovieGoodsDetailViewController

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (NSMutableArray *)imgsArray
{
    if (!_imgsArray) {
        _imgsArray = [NSMutableArray array];
    }
    return _imgsArray;
}

- (GoodsInfoHeaderView *)goodsTbHeaderView
{
    if (!_goodsTbHeaderView) {
        _goodsTbHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsInfoHeaderView" owner:self options:nil] lastObject];
        [_goodsTbHeaderView.xiangqingButton addTarget:self action:@selector(segmentBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        _goodsTbHeaderView.xiangqingButton.tag = BTN_START_TAG;
        [_goodsTbHeaderView.commentButton addTarget:self action:@selector(segmentBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        _goodsTbHeaderView.commentButton.tag = BTN_START_TAG+1;
        _btnLine = _goodsTbHeaderView.btnLine;
    }
    return _goodsTbHeaderView;
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, kViewWidth, kViewHeight+20-30) style:UITableViewStylePlain];
        _tbView.backgroundColor = kViewBackColor;
        _tbView.delegate = self;
        _tbView.dataSource = self;
    }
    return _tbView;
}

- (UIButton *)selectedColorBtn
{
    if (!_selectedColorBtn) {
        _selectedColorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedColorBtn setTitle:@"" forState:UIControlStateNormal];
    }
    return _selectedColorBtn;
}

- (UIButton *)selectedXinhaoBtn
{
    if (!_selectedXinhaoBtn) {
        _selectedXinhaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedXinhaoBtn setTitle:@"" forState:UIControlStateNormal];
    }
    return _selectedXinhaoBtn;
}

- (NSMutableArray *)goodsChicunArray
{
    if (!_goodsChicunArray) {
        _goodsChicunArray = [NSMutableArray array];
    }
    return _goodsChicunArray;
}

- (NSMutableArray *)goodsColorsArray
{
    if (!_goodsColorsArray) {
        _goodsColorsArray = [NSMutableArray array];
    }
    return _goodsColorsArray;
}


- (ShopingCarSelectView *)shopingCarView
{
    if (!_shopingCarView) {
        
    }
    return _shopingCarView;
}

- (UIView *)selectBgView
{
    if (!_selectBgView) {
        _selectBgView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _selectBgView.backgroundColor = [UIColor blackColor];
        _selectBgView.alpha = 0.0;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTapGesView)];
        [_selectBgView addGestureRecognizer:tapGes];
    }
    return _selectBgView;
}

- (void)removeTapGesView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _selectBgView.alpha = 0;
        self.shopingCarView.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 439);
    }];
    
    [self performSelector:@selector(removeCarView) withObject:nil afterDelay:0.5];
}


- (void)removeCarView
{
    [self.shopingCarView removeFromSuperview];
    [_selectBgView removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    self.navigationController.navigationBar.barTintColor=kNavBarColor;
    //    self.navigationController.navigationBar.translucent=NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 1;
        self.navigationController.navigationBar.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBar.hidden = YES;
    }];
    
    ///设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setNavTabBar:@""];
    
    [self createTableView];
    
    self.goodsMaxBought = @"";
    self.btnType = @"0";
    self.page = 1;
    self.shareImage = [UIImage imageNamed:@"index_logo_03"];
    //    index_logo_03
    
    //    NSString *urlStr = [NSString stringWithFormat:@"http://kamefilm.uj345.net/dian.php/Home/Shequ/xiang?deal_id=%@",self.goodsId];
    self.goodsDesc_Url = [NSString stringWithFormat:@"%@&deal_id=%@",Goods_xiangqing_url,self.goodsId];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,kViewWidth-1,1)];
    [self.webView setScalesPageToFit:YES];
    //    self.webView.scrollView.pagingEnabled = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.goodsDesc_Url]]];
    
    ///掉商品详情接口
    [self loadGoodsData];
    
    ////初始化商品分类选择信息
    [self loadGoodsAttribute];
    
}

- (void)createTableView
{
    [self.view addSubview:self.tbView];
    
    self.tbView.tableHeaderView.frame = CGRectMake(0, 0, kViewWidth, 527);
    self.tbView.tableHeaderView = self.goodsTbHeaderView;
    self.tbView.tableFooterView = [[UIView alloc] init];
    
}

#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.btnType isEqualToString:@"1"]) {
        return self.commentArray.count;
    }
    if ([self.btnType isEqualToString:@"0"]) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.btnType isEqualToString:@"0"]) {
        return  self.webView.frame.size.height;
    }
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.btnType isEqualToString:@"0"])
    {
        static NSString *webCellID = @"goodsWebCellID";
        UITableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:webCellID];
        if (!webCell) {
            webCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:webCellID];
            [webCell.contentView addSubview:self.webView];
        }
        webCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tbView.scrollsToTop = YES;
        return webCell;
        
    }else if ([self.btnType isEqualToString:@"1"]) {
        
        static NSString *cellID = @"goodsDetailCellID";
        GoodsDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailTableCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        GoodsCommentModel *goodsModel = self.commentArray[indexPath.row];
        [cell config:goodsModel];
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//TableView的分割线处理
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


#pragma mark - 点击按钮切换列表选项
- (void)segmentBtnClickedAction:(UIButton *)button
{
    NSInteger index = button.tag - BTN_START_TAG;
    CGFloat buttonW = kViewWidth/2;
    
    if (index == 0) {
        self.btnType = @"0";
        [self.tbView reloadData];
    }
    if (index == 1) {
        self.btnType = @"1";
        ///加载评论信息
        [self loadCommentMessage];
        
        
    }
    
    [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectedBtn = button;
    [_selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        _btnLine.frame = CGRectMake(20+buttonW*index, 40, buttonW-40, 2);
    }];
    
}


- (void)createUI
{
    [self createGoodsInfoBottomView];
}

#pragma mark - 分享
- (void)shareAction
{
    self.shareView =  [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
    self.shareView.delegate = self;
    //取消第三方授权
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
    [ShareSDK cancelAuthWithType:ShareTypeQQ];
    
    [self.shareView show];
    
}

#pragma mark - 删除分享视图
- (void)removeCusShareView
{
    [self.shareView myRemove];
}

- (void)backIndex
{
    [self removeCusShareView];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)qqButtonAction
{
    [self removeCusShareView];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"咔么电影"
                                       defaultContent:@"咔么电影"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影网"
                                                  url:self.goodsDesc_Url
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
    [MovieHttpRequest createCollectMyFavourableGoodWithGoodId:self.goodsId CallBack:^(id obj) {
        
//        [PromptLabel custemAlertPromAddView:self.view text:@"收藏成功"];
          [DeliveryUtility showMessage:@"收藏成功！" target:nil];
        
    } andSCallBack:^(id obj) {
        NSString *infoDict = obj;
        //        HHNSLog(@"%@",infoDict);
        if([infoDict isEqualToString:@"thing_id has been in collection table"])
        {
//            [PromptLabel custemAlertPromAddView:self.view text:@"该商品已被收藏"];
              [DeliveryUtility showMessage:@"该商品已经被收藏" target:nil];
        }
        else
        {
//            [PromptLabel custemAlertPromAddView:self.view text:@"收藏失败"];
              [DeliveryUtility showMessage:@"收藏失败！" target:nil];
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
                                                  url:self.goodsDesc_Url
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
                                                  url:self.goodsDesc_Url
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
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",@"咔么电影网",self.goodsDesc_Url]
                                       defaultContent:@"咔么电影网"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影网"
                                                  url:self.goodsDesc_Url
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


- (void)setNavBack
{
    UIImageView *myImage = [WNController createImageViewWithFrame:CGRectMake(8, 35, 20, 20) ImageName:@"goodInfo_back"];
    [self.view addSubview:myImage];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 35, 40, 30)];
    //[leftBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.alpha = 1;
    [self.view addSubview:leftBtn];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kViewWidth-50, 30, 40, 40)];
    //    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 6, 0, -6)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"point_info"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.alpha =1;
    if ([self.goodsMaxBought isEqualToString:@""]) {
        rightBtn.enabled = NO;
    }
    
    [self.view addSubview:rightBtn];
}

#pragma mark - 商品分类选择信息
- (void)loadGoodsAttribute
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.goodsId,@"goods_id",APP_DELEGATE.user_id,@"user_id" ,nil];
    [HttpRequestServers requestBaseUrl:TIGoods_GoodsAttributes withParams:userDict withRequestFinishBlock:^(id result) {
        
        @try {
            
            NSDictionary *dict = result;
            HHNSLog(@"presece------>%@",dict);
            if ([dict[@"code"] intValue] == 0) {
                
                for (NSDictionary *infoDict in dict[@"list"]) {
                    for (NSString *chicunString in [WNController nullString:infoDict[@"chicun"]]) {
                        if (![chicunString isEqualToString:@""]) {
                            [self.goodsChicunArray addObject:chicunString];
                        }
                    }
                    
                    for (NSString *yanseString in [WNController nullString:infoDict[@"yanse"]]) {
                        if (![yanseString isEqualToString:@""]) {
                            [self.goodsColorsArray addObject:yanseString];
                        }
                    }
                    
                    self.curretPrice = [WNController nullString:infoDict[@"current_price"]];
                    self.goodsMaxBought = [WNController nullString:infoDict[@"max_bought"]];
                    self.goodsCarImg = [WNController nullString:infoDict[@"img"]];
                }
                
               
                [self setNavBack];
                hud.labelText = @"加载成功";
                [MBHudManager removeHud:hud scallBack:^(id obj) {
                    
                }];
            }
            else
            {
                [self setNavBack];
                [MBHudManager removeHud:hud scallBack:^(id obj) {
                    
                }];
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
        [self setNavBack];
        hud.labelText = kNetWork_ERROR;
        [MBHudManager removeHud:hud scallBack:^(id obj) {
            
        }];
    }];
    
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createGoodsInfoBottomView
{
    UIView *lineView = [WNController createViewFrame:CGRectMake(0, kViewHeight-51+20, kViewWidth, 1)];
    lineView.backgroundColor = kViewBackColor;
    [self.view addSubview:lineView];
    self.bottomView = [WNController createViewFrame:CGRectMake(0, kViewHeight-50+20, kViewWidth, 50)];
    //    UIButton *btn1  = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/4, 50) ImageName:@"goodInfo_message" Target:self Action:@selector(sendMessageToCustomerService:) Title:@""];
    //    [self.bottomView addSubview:btn1];
    UIButton *btn2  = [WNController createButtonWithFrame:CGRectMake(40, 0, 50, 50) ImageName:@"goodInfo_shop" Target:self Action:@selector(enterGoodMainShop:) Title:@""];
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [self.bottomView addSubview:btn2];
    
#warning 这个跳转过来是有问题的，
    
//    UIButton *btn3  = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2, 0, kViewWidth/4, 50) ImageName:@"" Target:self Action:@selector(addGoodInMineShopCar:) Title:@"加入购物车" fontSize:(kViewWidth<375?14:16)];
//    
//    btn3.backgroundColor = [UIColor colorWithRed:0.98 green:0.6 blue:0.04 alpha:1];
//    [self.bottomView addSubview:btn3];
//    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *btn4  = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4*3, 0, kViewWidth/4, 50) ImageName:@"" Target:self Action:@selector(rentGoodRightNow:) Title:@"立即租" fontSize:(kViewWidth<375?14:16)];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomView addSubview:btn4];
    
    [self.view addSubview:self.bottomView];
}


#pragma mark - 进入咨询客服界面
- (void)sendMessageToCustomerService:(id)sender
{
    NSLog(@"咨询客服界面被点击");
}

#pragma mark - 进入商品所在店铺
- (void)enterGoodMainShop:(id)sender
{
    SearchShopResultController *shopVc = [[SearchShopResultController alloc] init];
    shopVc.shopId = self.shopID;
    shopVc.isShop = @"ture";
    [self.navigationController pushViewController:shopVc animated:YES];
    NSLog(@"商品所在店铺被点击");
}

#pragma mark - 添加商品到我的购物车
- (void)addGoodInMineShopCar:(id)sender
{
    
    if ([self.goodsMaxBought isEqualToString:@"0"]) {
//        [PromptLabel custemAlertPromAddView:self.view text:@"亲，没有库存啦"];
          [DeliveryUtility showMessage:@"亲，没有库存啦！" target:nil];
    }else
    {
        [self showSelectGoodsAttr:@"0"];
    }
    
    
    NSLog(@"添加商品到我的购物车被点击");
}

#pragma mark 弹出选择商品属性框
- (void)showSelectGoodsAttr:(NSString *)type
{
    self.shopingCarView = [[[NSBundle mainBundle] loadNibNamed:@"ShopingCarSelectView" owner:nil options:nil] lastObject];
    self.shopingCarView.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 439);
    [self.shopingCarView.cancelBtn addTarget:self action:@selector(removeTapGesView) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.selectBgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.shopingCarView];
    ///库存
    self.shopingCarView.InventoryLabel.text = [NSString stringWithFormat:@"库存%@件",self.goodsMaxBought];
    
    [self.shopingCarView.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.goodsCarImg]]];
    
    CGFloat currenPri = [self.curretPrice floatValue];
    self.shopingCarView.pricelabel.text = [NSString stringWithFormat:@"￥%.2f",currenPri];
    
    if (self.goodsColorsArray.count<1) {
        CGFloat btnX = 12;
        UIButton *btn = [WNController createButtonWithFrame:CGRectMake(btnX, 12, 66, 30) ImageName:@"" Target:self Action:@selector(chooseColosAction:) Title:@"默认" fontSize:15];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
        [self.shopingCarView.colorScrollView addSubview:btn];
        self.shopingCarView.colorScrollView.contentSize = CGSizeMake(btnX+66+12, 0);
    }else
    {
        for (int i=0; i<self.goodsColorsArray.count; i++) {
            CGFloat btnX = 12+12*i+66*i;
            UIButton *btn = [WNController createButtonWithFrame:CGRectMake(btnX, 12, 66, 30) ImageName:@"" Target:self Action:@selector(chooseColosAction:) Title:self.goodsColorsArray[i] fontSize:15];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
            [self.shopingCarView.colorScrollView addSubview:btn];
            self.shopingCarView.colorScrollView.contentSize = CGSizeMake(btnX+66+12, 0);
            
        }
    }
    
    if (self.goodsChicunArray.count<1)
    {
        CGFloat btnX = 12;
        UIButton *btn = [WNController createButtonWithFrame:CGRectMake(btnX, 12, 66, 30) ImageName:@"" Target:self Action:@selector(chooseXinhaoAction:) Title:@"默认" fontSize:15];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
        [self.shopingCarView.xinhaoScrollView addSubview:btn];
        self.shopingCarView.xinhaoScrollView.contentSize = CGSizeMake(btnX+66+12, 0);
    }else
    {
        for (int i = 0; i<self.goodsChicunArray.count; i++) {
            CGFloat btnX = 12+12*i+66*i;
            UIButton *btn = [WNController createButtonWithFrame:CGRectMake(btnX, 12, 66, 30) ImageName:@"" Target:self Action:@selector(chooseXinhaoAction:) Title:self.goodsChicunArray[i] fontSize:15];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
            [self.shopingCarView.xinhaoScrollView addSubview:btn];
            self.shopingCarView.xinhaoScrollView.contentSize = CGSizeMake(btnX+66+12, 0);
        }
    }
    
    
    
    ///减少
    [self.shopingCarView.subBtn addTarget:self action:@selector(subBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    [self.shopingCarView.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    ////动画
    [UIView animateWithDuration:0.5 animations:^{
        self.selectBgView.alpha = 0.5;
        self.shopingCarView.frame = CGRectMake(0, kViewHeight+20 - 439, kViewWidth, 439);
    }];
    
    ///初始化按钮
    [self.selectedColorBtn setTitle:@"" forState:UIControlStateNormal];
    [self.selectedXinhaoBtn setTitle:@"" forState:UIControlStateNormal];
//    
    if ([type isEqualToString:@"0"]) {
//        ///点击确认按钮 加入购物车
       [self.shopingCarView.comfirmButton addTarget:self action:@selector(addBuyCars) forControlEvents:UIControlEventTouchUpInside];
   }
//    
    if ([type isEqualToString:@"1"]) {
        ///跳转到下一页
        [self.shopingCarView.comfirmButton addTarget:self action:@selector(nextRentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark - 选择颜色
- (void)chooseColosAction:(UIButton *)btn
{
    self.selectedColorBtn.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
    [self.selectedColorBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.selectedColorBtn = btn;
    
    self.selectedColorBtn.backgroundColor = [UIColor colorWithRed:0.92 green:0.08 blue:0 alpha:1];
    [self.selectedColorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([[self.selectedXinhaoBtn titleForState:UIControlStateNormal] isEqualToString:@""]) {
        self.shopingCarView.chooseLabel.text = [NSString stringWithFormat:@"已选：\"%@\"",[self.selectedColorBtn titleForState:UIControlStateNormal]];
    }else
    {
        self.shopingCarView.chooseLabel.text = [NSString stringWithFormat:@"已选：\"%@\" \"%@\"",[self.selectedColorBtn titleForState:UIControlStateNormal],[self.selectedXinhaoBtn titleForState:UIControlStateNormal]];
    }
    
    
    
}
#pragma mark - 选择型号
- (void)chooseXinhaoAction:(UIButton *)btn
{
    self.selectedXinhaoBtn.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1];
    [self.selectedXinhaoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.selectedXinhaoBtn = btn;
    
    self.selectedXinhaoBtn.backgroundColor = [UIColor colorWithRed:0.92 green:0.08 blue:0 alpha:1];
    [self.selectedXinhaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if ([[self.selectedColorBtn titleForState:UIControlStateNormal] isEqualToString:@""]) {
        self.shopingCarView.chooseLabel.text = [NSString stringWithFormat:@"已选：\"%@\"",[self.selectedXinhaoBtn titleForState:UIControlStateNormal]];
    }else
    {
        self.shopingCarView.chooseLabel.text = [NSString stringWithFormat:@"已选：\"%@\" \"%@\"",[self.selectedColorBtn titleForState:UIControlStateNormal],[self.selectedXinhaoBtn titleForState:UIControlStateNormal]];
    }
    
    
    
}

- (void)subBtnAction:(UIButton *)btn
{
    NSInteger count = [[self.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal] integerValue];
    if (count<=1) {
        count = 1;
        [self.shopingCarView.goodsCountLabel setTitle:@"1" forState:UIControlStateNormal];
    }else
    {
        count--;
        [self.shopingCarView.goodsCountLabel setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    }
}

- (void)addButtonAction:(UIButton *)btn
{
    NSInteger maxCount = [self.goodsMaxBought integerValue];
    NSInteger count = [[self.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal] integerValue];
    
    if (count<maxCount) {
        count++;
        [self.shopingCarView.goodsCountLabel setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    }else
    {
//        [PromptLabel custemAlertPromAddView:self.shopingCarView  text:@"不能再加了"];
          [DeliveryUtility showMessage:@"不能再加了" target:nil];
    }
}

#pragma mark - 立即租用此商品
- (void)rentGoodRightNow:(id)sender
{
    HHNSLog(@"立即租用此商品被点击");
    //显示选择分类
    
    if ([self.goodsMaxBought isEqualToString:@"0"])
    {
    [DeliveryUtility showMessage:@"亲，没有库存啦" target:nil];
    }else
    {
    [self showSelectGoodsAttr:@"1"];
    }
    
}
///选择之后立即租 生成订单
- (void)nextRentAction
{
    if ([[self.selectedColorBtn titleForState:UIControlStateNormal] isEqualToString:@""]) {
//        [PromptLabel custemAlertPromAddView:self.shopingCarView text:@"请选择颜色"];
          [DeliveryUtility showMessage:@"请选择颜色" target:nil];
        
    }else
    {
        if ([[self.selectedXinhaoBtn titleForState:UIControlStateNormal] isEqualToString:@""]) {
//            [PromptLabel custemAlertPromAddView:self.shopingCarView text:@"请选择型号"];
              [DeliveryUtility showMessage:@"请选择型号" target:nil];
        }else
        {
            
            [self removeCarView];
            MovieComfirmOrderViewController *confirmVc = [[MovieComfirmOrderViewController alloc] init];
            
            NSString *goodsString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.goodsId,[self.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal],self.shopID,[self.selectedColorBtn titleForState:UIControlStateNormal],[self.selectedXinhaoBtn titleForState:UIControlStateNormal]];
            
            NSArray *array = [NSArray arrayWithObjects:goodsString, nil];
            
            confirmVc.goodsID = self.goodsId;
            confirmVc.shopID = self.shopID;
            confirmVc.goodsInfoArray = array;
            
            [self.navigationController pushViewController:confirmVc animated:YES];
        }
    }
    
    
}

#pragma mark - 提交
- (void)removeTapGesViewConfirm
{
    
    [UIView animateWithDuration:0.5 animations:^{
        _selectBgView.alpha = 0;
        self.shopingCarView.frame = CGRectMake(0, kViewHeight+20, kViewWidth, 439);
    }];
    
    [self performSelector:@selector(removeCarView) withObject:nil afterDelay:0.5];
}



#pragma mark - 请求商品数据
- (void)loadGoodsData
{
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.goodsId,@"goods_id", nil];
    [userDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [HttpRequestServers requestBaseUrl:TIGoods_Details withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"------->%@,%@",TIGoods_Details,dict);
        @try {
            NSDictionary *dic = dict[@"data"];
            self.goodsTbHeaderView.goodsNameLabel.text = [WNController nullString:dic[@"goods_name"]];
            self.goodsTbHeaderView.goodsLocationLabel.text = [WNController nullString:dic[@"goods_city_name"]];
 //      //缺失送货方式字段      self.goodsTbHeaderView.businessPostTypeLabel.text = [WNController nullString:dic[@"delivery"]];
            self.goodsTbHeaderView.currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"goods_price"]floatValue]];
            self.goodsTbHeaderView.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"goods_deposit"]floatValue]];
            ///设置下划线
            NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[[WNController nullString:dic[@"market_price"]] floatValue]];
            NSUInteger length = [oldPrice length];
            
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
            [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
            [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
            self.goodsTbHeaderView.oldPriceLabel.attributedText = attri;
            
            
            NSArray *imgsArr = dic[@"imgs"];
            for (NSString *img in imgsArr) {
                ///添加到图片数组里面
                [self.imgsArray addObject:img];
            }
            
            if (self.imgsArray.count>0) {
                self.goodsTbHeaderView.goodsScrollView.localizationImagesGroup = self.imgsArray;
            }
//             [self createUI];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    } withFieldBlock:^{
        
        
        
    }];
    
}

#pragma mark - 加载评论数据
- (void)loadCommentMessage
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.goodsId,@"deal_id",[NSString stringWithFormat:@"%ld",self.page],@"p", nil];
    [HttpRequestServers requestBaseUrl:Shop_deal_message withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"dict %@,%@",Shop_deal_message,dict);
        @try {
            if ([dict[@"status"] isEqualToString:Status_Success])
            {
                if (self.page == 1) {
                    [self.commentArray removeAllObjects];
                }
                
                for (NSDictionary *listDict in dict[@"list"]) {
                    GoodsCommentModel *model = [[GoodsCommentModel alloc] init];
                    model.content = [WNController nullString:listDict[@"content"]];
                    model.create_time = [WNController nullString:listDict[@"create_time"]];
                    model.user_name = [WNController nullString:listDict[@"user_name"]];
                    model.icon_img = [WNController nullString:listDict[@"icon_img"]];
                    [self.commentArray addObject:model];
                    
                }
                
                [_tbView reloadData];
                [self.tbView reloadData];
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    } withFieldBlock:^{
        
    }];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect webFrame = self.webView.frame;
    webFrame.size.height = webHeight;
    self.webView.frame = webFrame;
    
    [self.tbView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //    [[SDImageCache sharedImageCache] clearMemory];
    self.shopingCarView = nil;
    self.webView =nil;
}


- (void)dealloc
{
    self.shopingCarView = nil;
    self.webView =nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
