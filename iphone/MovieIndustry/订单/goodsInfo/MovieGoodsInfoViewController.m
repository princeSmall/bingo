//
//  MovieGoodsInfoViewController.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.123
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//
#define BTN_START_TAG 200
#import "MovieGoodsInfoViewController.h"
#import "MovieComfirmOrderViewController.h"
#import "ShopingCarSelectView.h"
#import "SearchShopResultController.h"
#import "LoginInController.h"
#import "ShareView.h"
#import "GoodsInfoHeaderView.h"
#import "GoodsDetailTableCell.h"
#import "GoodsCommentModel.h"
#import "RongYunViewController.h"
#import "RongYunViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "YourTestChatViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "LoginInController.h"


#import "GoodDesModel.h"
#import "GoodCommitFrame.h"

@interface MovieGoodsInfoViewController ()<ShareViewDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>
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
////加入租物车图片
@property (nonatomic,copy) NSString * goodsCarImg;
///评论分页
@property (nonatomic,assign) NSUInteger page;
//评论数组
@property (nonatomic,strong) NSMutableArray *commentArray;
//分享的Image
@property (nonatomic,strong) UIImage *shareImage;

@property (nonatomic,copy) NSString *goodsDesc_Url;

@property (nonatomic,strong)GoodDesModel * model;
@property (nonatomic,strong)NSString * dataStr;

@property (nonatomic,strong)NSString * goodsDes;
@property (nonatomic,strong)UILabel * labelDes;
@property (nonatomic,strong)RCConversationViewController * chat;

@property (nonatomic,strong)NSString *user_id;
@end

@implementation MovieGoodsInfoViewController

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

#pragma mark - 加入租物车
- (void)joinGoodsCars
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
            
            ///数量
            NSString *goodsCount = [self.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal];
            
            NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.goodsId,@"goods_id",goodsCount,@"goods_number", nil];
            NSMutableDictionary * attributesDic = [NSMutableDictionary dictionary];
            attributesDic[@"attribute_name_id"] = @"1";
            attributesDic[@"attribute_name"] = @"默认";
            attributesDic[@"attribute_value_id"] = @"2";
            attributesDic[@"attribute_value"] = @"默认";
            userDict[@"attributes"] = attributesDic;
            [HttpRequestServers requestBaseUrl:TICart_AddCart withParams:userDict withRequestFinishBlock:^(id result) {
                NSDictionary *dict = result;
                HHNSLog(@"%@",dict);
                
                if ([dict[@"code"] intValue] == 0) {
                    
                    [DeliveryUtility showMessage:@"加入租物车成功！" target:nil];
                    
                    
                    [self  removeTapGesViewConfirm];
                    
                }else
                {
                    //                                      LoginInController * login = [[LoginInController alloc]init];
                    
                    //                      [DeliveryUtility showMessage:@"请先登录用户！" target:nil];
                    [self  removeTapGesViewConfirm];
                }
                
                
            } withFieldBlock:^{
                //                [PromptLabel custemAlertPromAddView:self.shopingCarView text:kNetWork_ERROR];
                [DeliveryUtility showMessage:kNetWork_ERROR target:nil];
            }];
            
        }
    }
    
}

- (void)removeCarView
{
    [self.shopingCarView removeFromSuperview];
    [_selectBgView removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.alpha = 1;
        self.navigationController.navigationBar.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationController.navigationBar.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBar.hidden = YES;
    }];
    
    ///设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self setNavBack];
    [self loadGoodsData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//        self.tbView.tableHeaderView.frame = CGRectMake(0, 0, kViewWidth, 1000);
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setNavTabBar:@""];
    
    self.goodsMaxBought = @"";
    self.btnType = @"0";
    self.page = 1;
    self.shareImage = [UIImage imageNamed:@"180"];
    //    index_logo_03
    
    //调商品详情接口
    ////初始化商品分类选择信息
    [self createTableView];
}


- (void)createTableView
{
    [self.view addSubview:self.tbView];
    
    CGRect RECT = self.goodsTbHeaderView.frame;
    
    NSLog(@"%f",kViewWidth);
    self.goodsTbHeaderView.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.949 alpha:1.000];
    
    if (kViewWidth == 320) {
        RECT.size.height =kViewWidth + 190;
    }
    if (kViewWidth == 375) {
        RECT.size.height =kViewWidth + 183;
    }if (kViewWidth == 414) {
        RECT.size.height = kViewWidth + 180;
    }
     self.goodsTbHeaderView.frame = RECT;
    NSLog(@"%f",self.goodsTbHeaderView.frame.size.height);
    
    
    self.tbView.tableHeaderView.backgroundColor = [UIColor greenColor];
    
    self.tbView.tableHeaderView = self.goodsTbHeaderView;
    
   
    
    self.tbView.tableHeaderView.frame = RECT;
    self.tbView.tableFooterView = [[UIView alloc] init];
    

}

#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([self.btnType isEqualToString:@"0"]) {
        return 1;
    }else    if ([self.btnType isEqualToString:@"1"]) {
        return self.commentArray.count;
    }else{
    return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.btnType isEqualToString:@"0"]) {
        CGSize size = [self caculateContentSizeWithContent:self.goodsDes AndWidth:kViewWidth-1 andFont:[UIFont systemFontOfSize:18]];
        return self.webView.frame.size.height;
    }else{
        
        if (self.commentArray.count > 0) {
            GoodCommitFrame * Gframe = self.commentArray[indexPath.row];
            return Gframe.cellHeigth;
        }else{
            return 0;
        }
    }
    
}
-(CGSize)caculateContentSizeWithContent:(NSString *)content AndWidth:(CGFloat)width andFont:(UIFont *)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.btnType isEqualToString:@"0"])
    {
        static NSString *webCellID = @"goodsWebCellID";
        UITableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:webCellID];
        if (!webCell) {
            webCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:webCellID];}
//        webCell.textLabel.numberOfLines = 0;
//        webCell.textLabel.textColor = [UIColor colorWithWhite:0.396 alpha:1.000];
//        webCell.textLabel.text = self.goodsDes;
        [webCell.contentView addSubview:self.webView];
        self.webView.backgroundColor = [UIColor clearColor];
//        [self.webView sizeToFit];
   
        webCell.selectionStyle = UITableViewCellSelectionStyleNone;
        webCell.backgroundColor = [UIColor clearColor];
        self.tbView.scrollsToTop = YES;
        return webCell;
        
    }else if ([self.btnType isEqualToString:@"1"]) {
        
        static NSString *cellID = @"goodsDetailCellID";
        GoodsDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[GoodsDetailTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
//        if (self.commentArray.count == 0) {
//            
//        }else{
//            
            GoodCommitFrame *gf = self.commentArray[indexPath.row];
            
            cell.Gframe = gf;
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
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
    //    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    //    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
    //    [ShareSDK cancelAuthWithType:ShareTypeQQ];
    
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
    id<ISSContent> publishContent = [ShareSDK content:@"商品租赁"
                                       defaultContent:@"商品租赁"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"商品租赁"
                                                  url:@"http://www.baidu.com"
                                          description:@"商品租赁"
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

//收藏按钮
- (void)collectButtonAction
{
    [self removeCusShareView];
     if(APP_DELEGATE.user_id ==nil)
    {
        LoginInController *controller = [[LoginInController alloc]init];
        
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navC animated:YES completion:nil];
        return;
    }
    
    [MovieHttpRequest createCollectMyFavourableGoodWithGoodId:self.goodsId CallBack:^(id obj) {
        
        //        [PromptLabel custemAlertPromAddView:self.view text:@"收藏成功"];
        [DeliveryUtility showMessage:@"收藏成功！" target:nil];
        
    } andSCallBack:^(id obj) {
        NSString *infoDict = obj;
        //        HHNSLog(@"%@",infoDict);
        if([infoDict isEqualToString:@"此商品已收藏"])
        {
            //            [PromptLabel custemAlertPromAddView:self.view text:@"该商品已被收藏"];
            [DeliveryUtility showMessage:@"该商品已被收藏" target:nil];
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

    id<ISSContent> publishContent = [ShareSDK content:@"商品租赁"
                                       defaultContent:@"商品租赁"


                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"商品租赁"
                                                  url:@"http://www.baidu.com"
                                          description:@"商品租赁"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeWeixiSession
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
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

    id<ISSContent> publishContent = [ShareSDK content:@"商品租赁"
                                       defaultContent:@"商品租赁"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"商品租赁"
                                                  url:@"http://www.baidu.com"
                                          description:@"商品租赁"
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
    

    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",@"咔么电影网",self.goodsDesc_Url]
                                       defaultContent:@"商品租赁"
                       image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"商品租赁"
                                                  url:@"http://www.baidu.com"

                                          description:@"商品租赁"

                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
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
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 35, 25, 25)];
    [leftBtn setImage:[UIImage imageNamed:@"goodInfo_back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.alpha = 1;
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(8, 33, 30, 30)];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.layer.cornerRadius = 15;
    leftView.alpha = 0.7;
    leftView.layer.masksToBounds = YES;
    [self.view addSubview:leftView];
    [self.view addSubview:leftBtn];
    
    UIImageView *rightImage =[WNController createImageViewWithFrame:CGRectMake(kViewWidth-38, 33, 30, 30) ImageName:@"point_info"];
    
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(kViewWidth-38, 30, 30, 30)];
    rightView.layer.cornerRadius = 15;
    rightView.alpha = 0.7;
    rightView.layer.masksToBounds = YES;
    rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightView];
    [self setNavRightImage:@"point_info" rightAction:@selector(shareAction)];
    [self.view addSubview:rightImage];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kViewWidth-38, 30, 40, 40)];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 6, 0, -6)];
    [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.alpha = 1;
    [self.view addSubview:rightBtn];
}

#pragma mark - 商品分类选择信息
- (void)loadGoodsAttribute
{
    MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.goodsId,@"goods_id", APP_DELEGATE.user_id,@"user_id",nil];
    
    if(!APP_DELEGATE.user_id)
    {
        [userDict setValue:@"" forKey:@"user_id"];
    }
    
    __weak typeof(self)weakSelf = self;
    [HttpRequestServers requestBaseUrl:TIGoods_GoodsAttributes withParams:userDict withRequestFinishBlock:^(id result) {
        
        @try {
            
            NSDictionary *dict = result;
            HHNSLog(@"presece------>%@",dict);
            
            if ([dict[@"code"]intValue] == 0) {
                NSDictionary * infoDict = dict[@"data"];
                
                weakSelf.model = [[GoodDesModel alloc]initWithDict:infoDict];
                
                weakSelf.curretPrice = [WNController nullString:infoDict[@"goods_price"]];
                weakSelf.goodsMaxBought = [WNController nullString:infoDict[@"goods_number"]];
                weakSelf.goodsCarImg = [WNController nullString:infoDict[@"img_path"]];
                
                [weakSelf setNavBack];
                hud.labelText = @"加载成功";
                [MBHudManager removeHud:hud scallBack:^(id obj) {
                    
                }];
            }
            else
            {
                [weakSelf setNavBack];
                [MBHudManager removeHud:hud scallBack:^(id obj) {
                    
                }];
            }
            [weakSelf createUI];
            
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
    if(self.bottomView)
    {
        return;
    }else
    {
        UIView *lineView = [WNController createViewFrame:CGRectMake(0, kViewHeight-51+20, kViewWidth, 1)];
        lineView.backgroundColor = kViewBackColor;
        [self.view addSubview:lineView];
        self.bottomView = [WNController createViewFrame:CGRectMake(0, kViewHeight-50+20, kViewWidth, 50)];
        UIButton *btn1  = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth/4, 50) ImageName:@"goodInfo_message" Target:self Action:@selector(sendMessageToCustomerService:) Title:@""];
        //[btn1 setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
        [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0,12, 0, -12)];
//        [self.bottomView addSubview:btn1];
        
        
        if (self.isShop) {
            
        }else{
            UIButton *btn2  = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4, 0, kViewWidth/4, 50) ImageName:@"goodInfo_shop" Target:self Action:@selector(enterGoodMainShop:) Title:@""];
            [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 12)];
            [self.bottomView addSubview:btn2];
        }
        
        UIButton *btn3  = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2, 0, kViewWidth/4, 50) ImageName:@"" Target:self Action:@selector(addGoodInMineShopCar:) Title:@"加入租物车" fontSize:(kViewWidth<375?14:16)];
        
        btn3.backgroundColor = [UIColor colorWithRed:0.98 green:0.6 blue:0.04 alpha:1];
        [self.bottomView addSubview:btn3];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *btn4  = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4*3, 0, kViewWidth/4, 50) ImageName:@"" Target:self Action:@selector(rentGoodRightNow:) Title:@"立即租" fontSize:(kViewWidth<375?14:16)];
        btn4.backgroundColor = [UIColor redColor];
        [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bottomView addSubview:btn4];
        
        [self.view addSubview:self.bottomView];
    }
}


#pragma mark - 进入咨询客服界面
- (void)sendMessageToCustomerService:(id)sender
{
    NSLog(@"咨询客服界面被点击");
    [[RCIM sharedRCIM] initWithAppKey:@"qf3d5gbj3my5h"];
    
    [[RCIM sharedRCIM] connectWithToken:@"M5jUEJEZsBfTmqwJs3Pp0SbYHuAAZjlWtC47uOsD645PlClQV8xiMx8cTFEo2hh492l79a9j8YDVQIhduaIRKA==" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"KM1";
    //设置聊天会话界面要显示的标题
    chat.title = @"KM1";
    self.chat = chat;
    [chat setMessageAvatarStyle:1];
    //        [chat setValue:[UIColor whiteColor] forKey:@"titleColor"];
    chat.displayUserNameInCell = YES;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction1WithController:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [chat.navigationItem setLeftBarButtonItem:backItem];
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
    
}
- (void)setBackItem
{
    
}

- (void)backAction1WithController:(RCConversationViewController *)chat
{
    [self.chat.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 进入商品所在店铺
- (void)enterGoodMainShop:(id)sender
{
    SearchShopResultController *shopVc = [[SearchShopResultController alloc] init];
    shopVc.shopId = self.shopID;
    [self.navigationController pushViewController:shopVc animated:YES];
    NSLog(@"商品所在店铺被点击");
}

#pragma mark - 添加商品到我的购物车
- (void)addGoodInMineShopCar:(id)sender
{
    
    if([self.user_id intValue]==[APP_DELEGATE.user_id intValue])
    {
        [DeliveryUtility showMessage:@"商家不能购买自己的商品" target:self];
        return;
    }
    if(!APP_DELEGATE.user_id)
    {
        LoginInController *loginVc = [[LoginInController alloc] init];
        loginVc.isCc = @"1";
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:navC animated:YES completion:nil];
        [self loadGoodsAttribute];
        return;
    }
    //库存限制
    if ([self.model.goods_number isEqualToString:@"0"]) {
        //        [PromptLabel custemAlertPromAddView:self.view text:@"亲，没有库存啦"];
        [DeliveryUtility showMessage:@"亲，没有库存了" target:nil];
    }else
    {
        [self showSelectGoodsAttr:@"0"];
    }
    
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
    
//    if([self.model.goods_number intValue]<=0)
//    {
//        self.shopingCarView.InventoryLabel.text = [NSString stringWithFormat:@"库存100件"];
//    }
//    else
//    {
        self.shopingCarView.InventoryLabel.text = [NSString stringWithFormat:@"库存%@件",self.model.goods_number];
//    }
    
    
    if (self.model.img_path) {
        [self.shopingCarView.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.model.img_path]]];
    }else{
        
        [self.shopingCarView.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.model.imgs[0]]]];}
    
    CGFloat currenPri = [self.model.goods_price floatValue];
    self.shopingCarView.pricelabel.text = [NSString stringWithFormat:@"￥%.2f",currenPri];
    
    if (self.goodsColorsArray.count<1) {
        CGFloat btnX = 12;
        UIButton *btn = [WNController createButtonWithFrame:CGRectMake(btnX, 12, 66, 30) ImageName:@"" Target:self Action:@selector(chooseColosAction:) Title:@"默认" fontSize:15];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self chooseColosAction:btn];
        });
        
       
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self chooseXinhaoAction:btn];
        });
       
        
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
//            [self chooseXinhaoAction:btn];
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
    
    if ([type isEqualToString:@"0"]) {
        ///点击确认按钮 加入租物车
        [self.shopingCarView.comfirmButton addTarget:self action:@selector(addBuyCars) forControlEvents:UIControlEventTouchUpInside];
    }
    
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
    NSInteger maxCount = [self.model.goods_number integerValue];
    NSInteger count = [[self.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal] integerValue];
    
    if (count<maxCount) {
        count++;
        [self.shopingCarView.goodsCountLabel setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    }else
    {
    
        [DeliveryUtility showMessage:@"不能再加了" target:nil];
    }
}

#pragma mark - 立即租用此商品
- (void)rentGoodRightNow:(id)sender
{
    if([self.user_id intValue]==[APP_DELEGATE.user_id intValue])
    {
        [DeliveryUtility showMessage:@"商家不能购买自己的商品" target:self];
        return;
    }
    HHNSLog(@"立即租用此商品被点击");
    //显示选择分类
    if(!APP_DELEGATE.user_id)
    {
        LoginInController *loginVc = [[LoginInController alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVc];
        loginVc.isCc = @"1";
        [self presentViewController:navC animated:YES completion:nil];
        [self loadGoodsAttribute];
        return;
    }
    //库存限制
    if ([self.model.goods_number isEqualToString:@"0"]) {
        //        [PromptLabel custemAlertPromAddView:self.view text:@"亲，没有库存啦"];
        [DeliveryUtility showMessage:@"亲，没有库存了" target:nil];
    }else
    {
        [self showSelectGoodsAttr:@"1"];
    }
    
}
/**
 *  选择之后立即租 生成订单
 */
- (void)nextRentAction
{
    
    NSString *goodsCount = [self.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal];
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:APP_DELEGATE.user_id,@"user_id",self.goodsId,@"goods_id",goodsCount,@"goods_number", nil];
    NSMutableDictionary * attributesDic = [NSMutableDictionary dictionary];
    attributesDic[@"attribute_name_id"] = @"1";
    attributesDic[@"attribute_name"] = @"默认";
    attributesDic[@"attribute_value_id"] = @"2";
    attributesDic[@"attribute_value"] = @"默认";
    userDict[@"attributes"] = attributesDic;
    userDict[@"cart_type"] = @"1";
    
    __weak typeof(self)weakSelf = self;
    [HttpRequestServers requestBaseUrl:TICart_AddCart withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        
        if ([dict[@"code"] intValue] == 0) {
            weakSelf.dataStr = dict[@"data"];
            if ([[weakSelf.selectedColorBtn titleForState:UIControlStateNormal] isEqualToString:@""]) {
                //                [PromptLabel custemAlertPromAddView:self.shopingCarView text:@"请选择颜色"];
                [DeliveryUtility showMessage:@"请选择颜色" target:nil];
                
            }else
            {
                if ([[weakSelf.selectedXinhaoBtn titleForState:UIControlStateNormal] isEqualToString:@""]) {
                    //                    [PromptLabel custemAlertPromAddView:self.shopingCarView text:@"请选择型号"];
                    [DeliveryUtility showMessage:@"请选择型号" target:nil];
                }else
                {
                    
                    [weakSelf removeCarView];
                    MovieComfirmOrderViewController *confirmVc = [[MovieComfirmOrderViewController alloc] init];
                    confirmVc.model = weakSelf.model;
                    confirmVc.method = weakSelf.model.goods_express;
                    if(weakSelf.model.imgs ==nil)
                    {
                        NSLog(@"model is nil ");
                    }
                    confirmVc.goodsCount = weakSelf.shopingCarView.goodsCountLabel.titleLabel.text;
                    NSString *goodsString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.goodsId,[weakSelf.shopingCarView.goodsCountLabel titleForState:UIControlStateNormal],self.shopID,[weakSelf.selectedColorBtn titleForState:UIControlStateNormal],[weakSelf.selectedXinhaoBtn titleForState:UIControlStateNormal]];
                    
                    NSArray *array = [NSArray arrayWithObjects:goodsString, nil];
                    confirmVc.dataStr = weakSelf.dataStr;
                    confirmVc.goodsID = weakSelf.goodsId;
                    confirmVc.shopID = weakSelf.shopID;
                    confirmVc.type = weakSelf.model.type;
                    //                    confirmVc.goodsInfoArray = array;
                    [weakSelf.navigationController pushViewController:confirmVc animated:YES];}}
            
        }else
        {
            //            [PromptLabel custemAlertPromAddView:self.view text:@"获取cartid失败"];
            [DeliveryUtility showMessage:@"获取cartid失败" target:nil];
            [weakSelf  removeTapGesViewConfirm];
        }
        
        
    } withFieldBlock:^{
        //        [PromptLabel custemAlertPromAddView:self.shopingCarView text:kNetWork_ERROR];
        [DeliveryUtility showMessage:kNetWork_ERROR target:nil];
    }];
    
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

- (void)addBuyCars
{
    [self joinGoodsCars];
}

#pragma mark - 请求商品数据
- (void)loadGoodsData
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.goodsId,@"goods_id", nil];
    if(APP_DELEGATE.user_id)
    {
        [userDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    }
    else
    {
        [userDict setObject:@"" forKey:@"user_id"];
        
    }

    __weak typeof(self)weakSelf = self;
    [HttpRequestServers requestBaseUrl:TIGoods_Details withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"------->%@,%@",TIGoods_Details,dict);
        @try {
            
            NSDictionary *dic =  dict[@"data"];
            
            GoodDesModel * model = [[GoodDesModel alloc]initWithDict:dic];
            weakSelf.model = model;
            weakSelf.goodsDes = dic[@"goods_desc"];
            weakSelf.goodsTbHeaderView.goodsNameLabel.text = [WNController nullString:dic[@"goods_name"]];
            weakSelf.user_id = model.user_id;
            self.goodsDesc_Url = model.goods_info;
            
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,kViewWidth-1,1)];

            self.webView.scrollView.scrollEnabled = NO;
            self.webView.userInteractionEnabled = NO;
            self.webView.delegate = self;
            [self.webView loadHTMLString:self.goodsDesc_Url baseURL:nil];
            
            
            weakSelf.goodsTbHeaderView.goodsLocationLabel.text = [WNController nullString:dic[@"people_location"]];
            //送货方式字段
            weakSelf.goodsTbHeaderView.desc.text = dic[@"goods_desc"];
            NSArray *arr = [NSArray arrayWithObjects:@"送货上门",@"快递",@"自提", nil];
            
            if ([model.type intValue] == 0) {
               weakSelf.goodsTbHeaderView.businessPostTypeLabel.text = [WNController nullString:[ arr objectAtIndex: [dic[@"goods_express"]intValue]]];
            }else{
            
            weakSelf.goodsTbHeaderView.businessPostTypeLabel.text = @"";
            }
            

            weakSelf.goodsTbHeaderView.currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"goods_price"] floatValue]];
            
            ///设置下划线
            NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",[[WNController nullString:dic[@"market_price"]] floatValue]];
            NSUInteger length = [oldPrice length];
            
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
            [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
            [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
            weakSelf.goodsTbHeaderView.oldPriceLabel.text = oldPrice;
#warning message
            weakSelf.goodsTbHeaderView.yajinLabel.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"goods_deposit"] floatValue]];
            
            NSMutableArray *imgsArr = dic[@"imgs"];
            
            weakSelf.imgsArray = imgsArr;
            
            //分享图片是第一张图
            weakSelf.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.model.imgs[0]]]]];
            
            if (weakSelf.imgsArray.count>0) {
                NSMutableArray * imageArray = [NSMutableArray array];
                for (int i = 0; i < weakSelf.imgsArray.count; i ++) {
                    NSString * iamge = [NSString stringWithFormat:@"%@%@",TIBIGImage,weakSelf.imgsArray[i]];
                    [imageArray addObject:iamge];
                }
                
                
                weakSelf.goodsTbHeaderView.goodsScrollView.imageURLStringsGroup = imageArray;
                weakSelf.goodsTbHeaderView.goodsScrollView.dotColor = [UIColor lightGrayColor];
                
            }
            [weakSelf createUI];
            [weakSelf.tbView reloadData];
            
            
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
    NSMutableDictionary * userDict = [NSMutableDictionary dictionary];
    userDict[@"user_id"] = APP_DELEGATE.user_id;
    userDict[@"goods_id"] = self.goodsId;
    [self.commentArray removeAllObjects];
    [HttpRequestServers requestBaseUrl:TIGoods_Evaluatelist withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        @try {
            if ([dict[@"code"]intValue] == 0)
            {
                for (NSDictionary *listDict in dict[@"data"]) {
                    GoodsCommentModel *model = [[GoodsCommentModel alloc] initWithDict:listDict];
                    
                    GoodCommitFrame * Gframe = [[GoodCommitFrame alloc]init];
                    Gframe.model = model;
                    
                    [self.commentArray addObject:Gframe];
                }
                
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        [_tbView reloadData];
        [self.tbView reloadData];
        
    } withFieldBlock:^{
        
    }];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    

    webView.userInteractionEnabled = NO;
    if (self.view.frame.size.width == 320) {
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth = 320.0;" // UIWebView中显示的图片宽度
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "oldwidth = myimg.width;"
         "if(oldwidth > maxwidth){"
         "myimg.width = maxwidth;"
         "myimg.height *= (maxwidth/oldwidth)*2;"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
    }else if (self.view.frame.size.width == 375){
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth = 375.0;" // UIWebView中显示的图片宽度
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "oldwidth = myimg.width;"
         "if(oldwidth > maxwidth){"
         "myimg.width = maxwidth;"
         "myimg.height *= (maxwidth/oldwidth)*2 -10;"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
    }else{
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth = 414.0;" // UIWebView中显示的图片宽度
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "oldwidth = myimg.width;"
         "if(oldwidth > maxwidth){"
         "myimg.width = maxwidth;"
         "myimg.height *= (maxwidth/oldwidth)*2-20;"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
    }
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
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
