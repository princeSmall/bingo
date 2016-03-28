//
//  MovieTalkToPersonViewController.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTalkToPersonViewController.h"
#import "MovieTalkPersonFirstCell.h"
#import "MovieTalkPersonSecondCell.h"
#import "MovieTalkPersonThirdCell.h"
#import "MovieNewtestCommentViewController.h"
#import "MovieCommetView.h"
#import "MovieArticleDetailModel.h"
#import "MovieNewCommentCell.h"
#import "ModelArticleCommentModel.h"
#import "MWCommon.h"
#import "MWPhoto.h"
#import "MovieRelatedArticleModel.h"
#import "MovieRelateArticleCell.h"
#import "ShareView.h"
#import <ShareSDK/ShareSDK.h>

@interface MovieTalkToPersonViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,ShareViewDelegate>

/** 图片选择器 */
@property (nonatomic,strong) UIImagePickerController *imagePicker;

///分享UI
@property (nonatomic,strong) ShareView *shareView;

@property (nonatomic,retain) MBProgressHUD *webHUD;

@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain) UITableView *leftTableView;//详情列表
@property (nonatomic,retain) UITableView *rightTableView;//评论列表

@property (nonatomic,retain) UIWebView *webView;

/** 评论视图 */
@property (nonatomic,strong) MovieCommetView *commentView;

@property (nonatomic,strong) UIView *maskView;

@property (nonatomic,strong) NSMutableDictionary *commentDict;

/** 文章详情数据 */
@property (nonatomic,strong) MovieArticleDetailModel *mainModel;

/** 相关文章列表数据 */
@property (nonatomic,retain) NSMutableArray *relatedArray;

/** 评论列表数据 */
@property (nonatomic,retain) NSMutableArray *commentArray;

//分享的Image
@property (nonatomic,strong) UIImage *shareImage;


/** 1:原文 0:评论列表 */
@property (nonatomic,assign) BOOL isArticle;

@property (nonatomic,assign) int page; //评论列表页数

@property (nonatomic,retain) MBProgressHUD *HUD;

/** 原文/浏览量按钮 */
@property (nonatomic,retain) UIButton *articleBtn;

/** 评论图片 */
@property (nonatomic,retain) UIImage *commentImage;

/** 删除评论图片按钮 */
@property (nonatomic,retain) UIButton *imageButton;


/** 评论列表cell图片 */
@property (nonatomic,retain) NSMutableArray *commentImageArray;

@property (nonatomic,assign)CGRect commentViewFrame;


@end

@implementation MovieTalkToPersonViewController

- (NSMutableArray *)relatedArray
{
    if (!_relatedArray) {
        _relatedArray  = [NSMutableArray new];
    }
    return _relatedArray;
}

- (NSMutableArray *)commentImageArray
{
    if (!_commentImageArray) {
        _commentImageArray = [NSMutableArray new];
    }
    return _commentImageArray;
}

- (MovieCommetView *)commentView
{
    if (!_commentView) {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"MovieCommetView" owner:self options:nil] lastObject];
    }
    return _commentView;
}

- (NSMutableArray *)CommentArray
{
    if (nil == _commentArray) {
        _commentArray = [NSMutableArray new];
    }
    return _commentArray;
}

- (NSMutableDictionary *)commentDict
{
    if (nil == _commentDict) {
        _commentDict = [NSMutableDictionary new];
    }
    return _commentDict;
}

#pragma mark - 添加通知监听键盘高度变化
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(activeKeyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(activeKeyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}


//传入的(NSDictionary *)userInfo用于存放键盘的各种信息，其中UIKeyboardFrameEndUserInfoKey对应的存放键盘的尺寸信息，以CGRect形式取出。最终返回的是键盘在当前视图中的高度.然后，根据键盘高度将当前视图向上滚动同样高度。
-(void)activeKeyboardWillAppear:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        CGRect currentFrame = self.commentView.frame;
        currentFrame.origin.y = window.bounds.size.height;
        self.commentView.frame = currentFrame;
        
        CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
        currentFrame.origin.y = self.commentView.frame.origin.y - change - currentFrame.size.height;
        self.commentView.frame = currentFrame;
        NSLog(@"----\n%@\n------",NSStringFromCGRect(currentFrame));
    }];
}

//其次键盘的高度计算：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.commentView convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}


//最后，当键盘消失后，视图需要恢复原状。
-(void)activeKeyboardWillDisappear:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        //恢复原位
        CGRect currentFrame = self.commentView.frame;
        currentFrame.origin.y = window.bounds.size.height;
        self.commentView.frame = currentFrame;
    }];
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavRightImage:@"search_more" rightAction:@selector(shareAction:)];
    self.shareImage = [UIImage imageNamed:@"index_logo_03"];
    _isArticle = YES;
    
    if (!self.articleId) {
        self.articleId = @"3";
    }
    
    [self setNavTabBar:@"文章详情"];
    [self createTalkTpPersonView];
//    [self requestArticleDetailInfo];
    [self createInputeMaskView];
//    [self setupCommentListRefresh]
//    [self requestRelatedArticlesData];
    self.commentViewFrame =CGRectMake(0, self.view.frame.size.height-self.commentView.frame.size.height, self.view.frame.size.width, self.commentView.frame.size.height);

}
#pragma mark - 弹出分享框
- (void)shareAction:(UIButton *)btn
{
    self.shareView =  [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
    self.shareView.collectButton.alpha = 0;
    self.shareView.collectLabel.alpha = 0;
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)qqButtonAction
{
    [self removeCusShareView];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"咔么电影"
                                       defaultContent:@"咔么电影"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影网"
                                                  url:[NSString stringWithFormat:@"%@&id=%@",ArtileDetial_HTML,self.articleId]
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
}

- (void)wechatButtonAction
{
    [self removeCusShareView];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"咔么电影"
                                       defaultContent:@"咔么电影"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影"
                                                  url:[NSString stringWithFormat:@"%@&id=%@",ArtileDetial_HTML,self.articleId]
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
                                                  url:[NSString stringWithFormat:@"%@&id=%@",ArtileDetial_HTML,self.articleId]
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
    
    NSString *strUrl = [NSString stringWithFormat:@"%@&id=%@",ArtileDetial_HTML,self.articleId];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",@"咔么电影",strUrl]
                                       defaultContent:@"咔么电影网"
                                                image:[ShareSDK pngImageWithImage:_shareImage]
                                                title:@"咔么电影网"
                                                  url:@""
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


- (void)createInputeMaskView
{
    //暗黑色遮罩
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth, kViewHeight + 44)];
    self.maskView.backgroundColor = RGBColor(0,0,0, 0.35);
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(talkViewKeyboardDown)];
    [self.maskView addGestureRecognizer:tapGes];
    
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    
    CGFloat commentY = mainWindow.bounds.size.height;
    
    
    self.commentView.frame = CGRectMake(0,commentY,kViewWidth,120);
    
    [self.commentView.takePhotoBtn addTarget:self action:@selector(takeCommentImageFromCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.commentView.albumBtn addTarget:self action:@selector(takeCommentImageFromAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.commentView.publishBtn addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 创建视图,滚动视图,文章列表,评论列表
- (void)createTalkTpPersonView
{
    CGFloat viewW = kViewWidth;
    CGFloat viewH = (kViewHeight-44-50);
    
    //滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,viewW,viewH)];
    self.scrollView.contentSize = CGSizeMake(viewW*2,viewH);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    
    //文章详情
    NSString *urlPath = [NSString stringWithFormat:@"%@&id=%@",ArtileDetial_HTML,self.articleId];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,viewW-1,1)];
    [self.webView setScalesPageToFit:YES];
//    self.webView.scrollView.pagingEnabled = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]]];
    
    //文章详情列表
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,viewW-1, viewH) style:UITableViewStyleGrouped];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    
    //评论列表
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(viewW-1,0,viewW, viewH) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.leftTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    
    [self.scrollView addSubview:self.leftTableView];
    [self.scrollView addSubview:self.rightTableView];
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = kViewBackColor;
    self.leftTableView.backgroundColor = kViewBackColor;
    self.rightTableView.backgroundColor = kViewBackColor;
    
    self.leftTableView.alpha = 0;
}

#pragma mark - 创建底部输入框
- (void)createBottomInputeView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kViewHeight-50-44, kViewWidth,50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth,1)];
    line.backgroundColor=RGBColor(212,212,212,0.5);
    [bottomView addSubview:line];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(justCommentArticle)];
    [bottomView addGestureRecognizer:tapGes];
    
    //相机按钮
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(7,7,36,36);
    [cameraBtn setImage:[UIImage imageNamed:@"talk_camera"] forState:UIControlStateNormal];
    cameraBtn.userInteractionEnabled = NO;
    [bottomView addSubview:cameraBtn];
    
    //输入框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50,10, kViewWidth-130, 30)];
    textField.userInteractionEnabled = NO;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [bottomView addSubview:textField];
    
    //原文/浏览数量按钮
    self.articleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.articleBtn.frame = CGRectMake(kViewWidth-70, 10, 60, 30);
    [self.articleBtn setTitle:@"评论" forState:UIControlStateNormal];
    [self.articleBtn addTarget:self action:@selector(articleBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.articleBtn.clipsToBounds = YES;
    self.articleBtn.layer.cornerRadius = 5.0f;
    self.articleBtn.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
    self.articleBtn.layer.borderWidth = 1.0f;
    [self.articleBtn setTitleColor:RGBColor(249, 111, 11, 1) forState:UIControlStateNormal];
    self.articleBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [bottomView addSubview:self.articleBtn];
    [self.view addSubview:bottomView];
}


#pragma mark - 切换文章详情,评论列表
- (void)articleBtnClickedAction:(UIButton *)button
{
    _isArticle = !_isArticle;
    
    if (_isArticle) {
        
        [self setNavTabBar:@"文章详情"];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(0, 0);
            [button setTitle:@"评论" forState:UIControlStateNormal];
            [self.leftTableView reloadData];
        }];
    }
    else
    {
        [self setNavTabBar:@"最新评论"];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(kViewWidth, 0);
            [button setTitle:@"原文" forState:UIControlStateNormal];
            [self.rightTableView reloadData];
        }];
    }
}

- (void)justCommentArticle
{
    
    [self.commentDict setObject:@"" forKey:@"contentId"];
    [self popCommentTextView];
        
}

#pragma mark - 弹出评论输入框
- (void)popCommentTextView
{
    [self.view addSubview:self.maskView];
    self.commentView.frame = CGRectMake(0, self.view.frame.size.height-self.commentViewFrame.size.height, self.view.frame.size.width, self.commentViewFrame.size.height +55);
    [self.maskView addSubview:self.commentView];
    //[self.maskView bringSubviewToFront:self.commentView];
    
    
    [self.commentView becomeFirstResponder];
}

/*
#pragma mark - 请求文章详情
- (void)requestArticleDetailInfo
{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    [MovieHttpRequest createArticleDetailWithArticleId:self.articleId CallBack:^(id obj) {
        
        self.mainModel = (MovieArticleDetailModel *)obj;
        [self.leftTableView reloadData];
        
        [self setupCommentListRefresh];
        
    } andSCallBack:^(id obj) {
        
        [self.HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}
*/

#pragma mark - 请求文章详情
- (void)requestRelatedArticlesData
{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    [MovieHttpRequest createRelatedArticlesWithArtile:self.articleId CallBack:^(id obj) {
        
        self.relatedArray = [NSMutableArray arrayWithArray:obj];
        [self.leftTableView reloadData];
        
        [self setupCommentListRefresh];
        
    } andSCallBack:^(id obj) {
        
        [self.HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - 请求评论列表数据
- (void)requestArticleCommentlistInfo
{
    self.HUD.labelText = @"正在加载";
    [self.HUD show:YES];
    
    [MovieHttpRequest createArticleCommentListWithArticleId:self.articleId andPage:_page CallBack:^(id obj) {
        
        self.HUD.labelText = @"加载成功";
        [self.HUD hide:YES];
        
        if (1 == _page) {
            self.commentArray = [NSMutableArray arrayWithArray:obj];
            
        }else{
            [self.commentArray addObjectsFromArray:obj];
        }
        
        [self.rightTableView.header endRefreshing];
        [self.rightTableView.footer endRefreshing];
        [self.rightTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        [self.HUD hide:YES];
        [self.rightTableView.header endRefreshing];
        [self.rightTableView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - 点击发表评论按钮
- (void)commentButtonClicked:(UIButton *)button
{
    NSString *commtentStr = [self.commentView.textView.text asTrim];
    
    if (self.commentImage)
    {
        //如果有评论图片,先上传图片
        [self requestUploadCommentImage];
    }
    else if(0 == commtentStr.length)
    {   //如果没有评论图片,直接上传内容
        [DeliveryUtility showMessage:@"请输入评论内容" target:self];
    }
//    else if (!self.articleId)
//    {
//        NSLog(@"文章暂不可评论,尽情期待");
//    }
    else
    {
        [self.commentDict setObject:@"" forKey:@"img"];
        [self requestSendMineComment];
    }
}

#pragma mark - 请求发表我的评论
- (void)requestSendMineComment
{
    NSString *commtentStr = [self.commentView.textView.text asTrim];
    
    [self.commentDict setObject:self.articleId forKey:@"articleId"];
    [self.commentDict setObject:commtentStr forKey:@"content"];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = @"正在发表";
    [HUD show:YES];
    
    [MovieHttpRequest createAddArticleCommentWithInfoDict:self.commentDict CallBack:^(id obj) {
        
        HUD.labelText = @"发表成功";
        [HUD hide:YES];
        
//        [PromptLabel custemAlertPromAddView:self.view text:@"发表成功"];
         [DeliveryUtility showMessage:@"发表成功" target:nil];
        [self talkViewKeyboardDown];
        self.commentView.textView.text = @"";
        [self delectCommentImage:nil];
    
        _isArticle = YES;
        [self.rightTableView.header beginRefreshing];
        [self articleBtnClickedAction:nil];
        
        if ([self.delegate respondsToSelector:@selector(commentArticleSuccess:)])
        {
            [self.delegate commentArticleSuccess:YES];
        }
        
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - 上传我的评论中的图片
- (void)requestUploadCommentImage
{
    UIImage *originImage = self.commentImage;
    CGFloat i = originImage.size.width/400;
   UIImage * postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(originImage.size.width/i, originImage.size.height/i)];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = @"正在上传图片";
    [HUD show:YES];
    [HttpRequestServers postImageRequest:Image_upload UIImage:postImage parameters:nil requestFinish:^(id result) {
        HHNSLog(@"上传评论图片成功 --> %@",result);
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict[@"status"] isEqualToString:@"f99"]) {
            NSString *imagePath = [DeliveryUtility nullString:dict[@"image_url"]];
            [self.commentDict setObject:imagePath forKey:@"img"];
            HUD.labelText = @"上传成功";
            [self requestSendMineComment];
        }
        else
        {
            [DeliveryUtility showMessage:dict[@"msg"] target:self];
        }
        
        [HUD hide:YES afterDelay:0.25];
        
    } requestField:^{
        
        HUD.labelText = @"上传成功";
        [HUD hide:YES afterDelay:0.25];
    }];
}

#pragma mark - 收回键盘,移除maskView
- (void)talkViewKeyboardDown
{
    [self.view endEditing:YES];
    [self.maskView removeFromSuperview];
    [self.leftTableView endEditing:YES];
    [self.rightTableView endEditing:YES];
    [self.commentView.textView endEditing:YES];
    [self.commentView.textView resignFirstResponder];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSString *scrollViewX = [NSString stringWithFormat:@"%.0f",scrollView.contentOffset.x];
        NSLog(@"列表偏移量 --> %@",scrollViewX);
        
        if ([scrollViewX isEqualToString:@"0"])
        {
            _isArticle = YES;
            [self setNavTabBar:@"文章详情"];
            [self.articleBtn setTitle:@"评论" forState:UIControlStateNormal];
            [self.leftTableView reloadData];
        }
        else
        {
            _isArticle = NO;
            [self setNavTabBar:@"最新评论"];
            [self.articleBtn setTitle:@"原文" forState:UIControlStateNormal];
            [self.rightTableView reloadData];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (tableView==self.leftTableView)?2:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return (0==section)?1:self.relatedArray.count;
    }
    else
    {
        return self.commentArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView)
    {
        if (0 == indexPath.section) {
            
            static NSString *webCellID = @"webCellID";
            UITableViewCell *webCell = [tableView dequeueReusableCellWithIdentifier:webCellID];
            if (!webCell) {
                webCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:webCellID];
                [webCell.contentView addSubview:self.webView];
            }
            return webCell;
        }
        else
        {
            //相关文章Cell
            static NSString *relateCellID = @"relateCellID";
            MovieRelateArticleCell *relateCell = [tableView dequeueReusableCellWithIdentifier:relateCellID];
            if (!relateCell) {
                relateCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieRelateArticleCell" owner:self options:nil] lastObject];
            }
            
            MovieRelatedArticleModel *model = _relatedArray[indexPath.row];
            [relateCell setRelateModel:model];
            
            return relateCell;
        }
    }
    else
    {
        static NSString *cellID = @"goodCellIdentifier";
        MovieNewCommentCell *infoCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (infoCell == nil) {
            infoCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieNewCommentCell" owner:self options:nil] lastObject];
        }
        
        infoCell.tag = indexPath.row;
        infoCell.blessBtn.tag = indexPath.row;
        [infoCell.blessBtn addTarget:self action:@selector(blessCommentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCommentImageView:)];
        [infoCell.commentImage addGestureRecognizer:tapGes];
        
        ModelArticleCommentModel *commentModel = _commentArray[indexPath.row];
        [infoCell setCommentModel:commentModel];
        
        infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return infoCell;
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.leftTableView && 1 == section && self.relatedArray.count) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        
        UIImageView *articleImage = [[UIImageView alloc] initWithFrame:CGRectMake(6,6,16,16)];
        articleImage.image = [UIImage imageNamed:@"relate_article"];
        [headerView addSubview:articleImage];
        
        UILabel *relateLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 100, 21)];
        relateLab.text = @"相关文章";
        relateLab.font = DefaultFont;
        relateLab.textColor = RGBColor(135, 135, 135, 1);
        [headerView addSubview:relateLab];
        
        return headerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (tableView==self.leftTableView && 1==section)?30:0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        
        return (0==indexPath.section)?(self.webView.frame.size.height):60;
    }
    else
    {
        ModelArticleCommentModel *model = _commentArray[indexPath.row];
         return [self cacaluteCellHeight:model];
    }
}

//计算文章详情第三个cell高度
- (CGFloat)caculateArticleDetailThirdCell
{
    CGFloat contentH = [DeliveryUtility caculateContentSizeWithContent:self.mainModel.content andHight:CGFLOAT_MAX andWidth:screenWidth-30 andFont:[UIFont systemFontOfSize:17.0f]].height;
    if (self.mainModel.image.length) {
        
        //假设图片高度为100
        return contentH + 160;
    }
    else{
        return contentH + 70;
    }
}

//计算评论列表cell高度
- (CGFloat)cacaluteCellHeight:(ModelArticleCommentModel *)model
{

    CGFloat contentH = [DeliveryUtility caculateContentSizeWithContent:model.content andHight:CGFLOAT_MAX andWidth:kViewWidth-90 andFont:DefaultFont].height;
    
    if (model.img.length) {
        return contentH + 165;
    }else{
        return contentH + 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ModelArticleCommentModel *commentModel = _commentArray[indexPath.row];
//    [self.commentDict setObject:commentModel.contentId forKey:@"contentId"];
//    self.commentView.textView.text = [NSString stringWithFormat:@"回复%@:",commentModel.nikename];
//    [self popCommentTextView];
    
    if (tableView == self.leftTableView && 1 == indexPath.section) {
        
        MovieRelatedArticleModel *model = _relatedArray[indexPath.row];
        
        MovieTalkToPersonViewController *articleDetailVC = [[MovieTalkToPersonViewController alloc] init];
        articleDetailVC.articleId = model.relatedArticleId;
        [self.navigationController pushViewController:articleDetailVC animated:YES];
    }
}


#pragma mark - 给评论点赞
- (void)blessCommentBtnClicked:(UIButton *)button
{
    NSInteger index = button.tag;
    
    ModelArticleCommentModel *commentModel = _commentArray[index];
    NSString *commentId = commentModel.commentModelId;
    
    [MovieHttpRequest createAddMineBlessWithCommentId:commentId CallBack:^(id obj) {
        
        NSLog(@"点赞成功");
        NSDictionary *dict = (NSDictionary *)obj;
        NSString *praiseNum = [DeliveryUtility nullString:dict[@"content_praise_num"]];
        NSString *statues = [DeliveryUtility nullString:dict[@"statuses"]];
        
        if ([statues isEqualToString:@"1"]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"点赞成功"];
             [DeliveryUtility showMessage:@"点赞成功" target:nil];
        }
        
        if ([statues isEqualToString:@"0"]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"取消点赞"];
             [DeliveryUtility showMessage:@"取消点赞" target:nil];
        }
        
        commentModel.statuses = statues;
        commentModel.contentPraiseNum = praiseNum;
        
        NSMutableArray *indexPath = [[NSMutableArray alloc] init];
        [indexPath addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        [self.rightTableView reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationNone];
        
    } andSCallBack:^(id obj) {
      
        NSLog(@"点赞失败");
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - 拍照获取图片
- (void)takeCommentImageFromCamera
{
    //相机访问受限
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相机访问受限" message:@"请在设备的'设置-隐私-相机'中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        return;
//    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = sourceType;
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.imagePicker.allowsEditing = NO;
        
        [self.imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        if (isiOS8) {
            
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            //            self.imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
    else
    {
        [DeliveryUtility showMessage:@"该设备不支持拍照功能" target:self];
    }
}

#pragma mark - 从相册获取图片
- (void)takeCommentImageFromAlbum
{
    //判断相册访问权限
//    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusNotDetermined){
//            //无权限
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相册访问受限" message:@"请在设备的'设置-隐私-相册'中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//    
//            return;
//        }
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.imagePicker.allowsEditing = NO;
    
    [self.imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消相册选择");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self addCommentImageInView:image];
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self addCommentImageInView:image];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 把评论图片到评论框内
- (void)addCommentImageInView:(UIImage *)image
{
    self.commentImage = image;
    
    CGFloat buttonX = self.commentView.txtViewBg.bounds.size.width-75;
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton.frame = CGRectMake(buttonX,5,70,50);

    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    picture.image = image;
    UIImageView *delecteImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 20, 50)];
    delecteImage.image = [UIImage imageNamed:@"Image_delect"];
    [self.imageButton addSubview:picture];
    [self.imageButton addSubview:delecteImage];
    [self.imageButton addTarget:self action:@selector(delectCommentImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentView.txtViewBg addSubview:self.imageButton];
    
    CGRect textFrame = self.commentView.textView.frame;
    textFrame.size.width -= 80;
    self.commentView.textView.frame = textFrame;    
    self.commentView.layoutTxt.constant = 80.0f;
    [self.commentView.textView becomeFirstResponder];
    [self popCommentTextView];
}


#pragma mark - 删除评论的图片
- (void)delectCommentImage:(UIButton *)button
{
    [self.imageButton removeFromSuperview];
    
    self.commentView.layoutTxt.constant = 0;
    self.commentImage = nil;
    
    CGRect textFrame = self.commentView.textView.frame;
    textFrame.size.width += 80;
    self.commentView.textView.frame = textFrame;
}

#pragma mark - 添加上下拉刷新
- (void)setupCommentListRefresh
{
    self.rightTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self requestArticleCommentlistInfo];
    }];
    
    [self.rightTableView.header beginRefreshing];
    
    self.rightTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        [self requestArticleCommentlistInfo];
    }];
}


#pragma mark - 点击评论图片浏览大图
- (void)tapCommentImageView:(UITapGestureRecognizer *)ges
{
    NSLog(@"cellIndex --> %@",NSStringFromClass([ges.view.superview.superview class]));
    [self.commentImageArray removeAllObjects];
    
    NSInteger index = ges.view.superview.superview.tag;
    ModelArticleCommentModel *model = _commentArray[index];
    NSString *imagePath = [NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,model.img];
    
    [self.commentImageArray addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imagePath]]];
    
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    
    //Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
    [self.navigationController pushViewController:browser animated:YES];
    NSLog(@"评论图片被点击 -->");
}


#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _commentImageArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _commentImageArray.count)
        return [_commentImageArray objectAtIndex:index];
    return nil;
}

- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%lu / %zd", (unsigned long)index+1,_commentImageArray.count];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self talkViewKeyboardDown];
}

- (void)backAction
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
    self.maskView = nil;
    self.commentView = nil;
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.webHUD.labelText = @"正在加载";
    [self.webHUD show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webHUD hide:YES];
    CGFloat webHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect webFrame = self.webView.frame;
    webFrame.size.height = webHeight;
    self.webView.frame = webFrame;
    
    [self createBottomInputeView];
    [self.leftTableView reloadData];
    self.leftTableView.alpha = 1;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.webHUD.labelText = @"加载失败";
    [self.webHUD hide:YES];
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
