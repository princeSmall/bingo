//
//  LeftActivityImgController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//
#define UploadImage_Url [NSString stringWithFormat:@"%@index.php/Home/ApiUsers/photo",PREFIX]
#import "LeftActivityImgController.h"
#import "MovieTuesdayActiveFirstCell.h"
//#import "MovieTuesdayActiveSecondCell.h"
#import "MovieTuestdayHistroyListViewController.h"
#import "MovieTuesdayGoodModel.h"
#import "MovieComfirmOrderViewController.h"
#import "MovieNewCommentCell.h"
#import "MovieTuesdayCommentModel.h"
#import "MovieCommetView.h"
#import "MWCommon.h"
#import "MWPhoto.h"


@interface LeftActivityImgController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,MovieComfirmOrderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 图片选择器 */
@property (nonatomic,strong) UIImagePickerController *imagePicker;

/** 网页高度 */
@property (nonatomic,assign) CGFloat webHeight;

@property (nonatomic,retain) UITableView *mainTableView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) MovieTuesdayGoodModel *mainModel;

@property (nonatomic,retain) MBProgressHUD *webHUD;

@property (nonatomic,retain) UIWebView *infoWebView;

@property (nonatomic,retain) MovieTuesdayActiveFirstCell *headerView;

@property (nonatomic,retain) NSTimer *activeTimer;

@property (nonatomic,assign) BOOL isCanRush;

@property (nonatomic,assign) NSInteger segmentIndex;

/** 评论列表 */
@property (nonatomic,retain) NSMutableArray *commentArray;

/** 分页 */
@property (nonatomic,assign) int commentPage;

/** 评论图片 */
@property (nonatomic,retain) UIImage *commentImage;

/** 评论视图 */
@property (nonatomic,strong) MovieCommetView *commentView;

/** 删除评论图片按钮 */
@property (nonatomic,retain) UIButton *imageButton;

@property (nonatomic,strong) UIView *maskView;

@property (nonatomic,strong) NSMutableDictionary *commentDict;

/** 评论列表cell图片 */
@property (nonatomic,retain) NSMutableArray *commentImageArray;

@end

@implementation LeftActivityImgController

- (NSMutableArray *)commentImageArray
{
    if (!_commentImageArray) {
        _commentImageArray = [NSMutableArray new];
    }
    return _commentImageArray;
}

- (NSMutableDictionary *)commentDict
{
    if (nil == _commentDict) {
        _commentDict = [NSMutableDictionary new];
    }
    return _commentDict;
}

- (MovieCommetView *)commentView
{
    if (!_commentView) {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"MovieCommetView" owner:self options:nil] lastObject];
    }
    return _commentView;
}

- (NSMutableArray *)commentArray
{
    if (nil == _commentArray) {
        _commentArray = [NSMutableArray new];
    }
    return _commentArray;
}

- (MBProgressHUD *)webHUD
{
    if (nil == _webHUD) {
        _webHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _webHUD;
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
        currentFrame.origin.y = self.commentView.frame.origin.y - change ;
        self.commentView.frame = currentFrame;
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

#pragma mark - 初始化页面
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _commentPage = 1;
    [self setNavTabBar:@"周二抢"];
    [self createTuesdayActiveView];
    [self createActiveInputeMaskView];
    [self requetTuesdayGoodsActivityDatas];
    [self addTableViewFooterRefresh];
}

- (void)createTuesdayActiveView
{
    _isCanRush = NO;
    
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"MovieTuesdayActiveFirstCell" owner:self options:nil] lastObject];
    self.headerView.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.headerView.histoyBtn addTarget:self action:@selector(inspectHistoryActive:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.startBtn addTarget:self action:@selector(startBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.leftSegmentBtn addTarget:self action:@selector(activeSegmentBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.rightSegmentBtn addTarget:self action:@selector(activeSegmentBtnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, kViewHeight-44-50) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.headerView;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    //创建网页
    self.infoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 1)];
    self.infoWebView.delegate = self;
    self.infoWebView.scrollView.scrollEnabled = NO;
    [self.infoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Goods_xiangqing_url]]]];
    
    self.mainTableView.alpha = 0;
}

#pragma mark - 创建底部输入框
- (void)createTuesdayBottomInputeView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kViewHeight-50-44, kViewWidth,50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,0,kViewWidth,1)];
    line.backgroundColor=RGBColor(212,212,212,0.5);
    [bottomView addSubview:line];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(justCommentTuesdayActive)];
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
    
//    原文/浏览数量按钮
    UIButton *commentNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentNumBtn.frame = CGRectMake(kViewWidth-70, 10, 60, 30);
    [commentNumBtn setTitle:@"评论" forState:UIControlStateNormal];
    commentNumBtn.clipsToBounds = YES;
    commentNumBtn.layer.cornerRadius = 5.0f;
    commentNumBtn.layer.borderColor = RGBColor(212, 212, 212, 0.5).CGColor;
    commentNumBtn.layer.borderWidth = 1.0f;
    [commentNumBtn setTitleColor:RGBColor(249, 111, 11, 1) forState:UIControlStateNormal];
    commentNumBtn.userInteractionEnabled = NO;
    commentNumBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [bottomView addSubview:commentNumBtn];
    [self.view addSubview:bottomView];
}

- (void)justCommentTuesdayActive
{
    [self.commentDict setObject:@"" forKey:@"contentId"];
    [self popCommentTextView];
}


#pragma mark - 创建评论视图以及遮罩
- (void)createActiveInputeMaskView
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

#pragma mark - 点击发表评论按钮
- (void)commentButtonClicked:(UIButton *)button
{
    NSString *commtentStr = [self.commentView.textView.text asTrim];
    
    if (self.commentImage)
    {
        //如果有评论图片,先上传图片
        [self requestUploadActiveCommentImage];
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
        [self requestSendActiveComment];
    }
}

#pragma mark - 请求发表我的评论
- (void)requestSendActiveComment
{
    NSString *commtentStr = [self.commentView.textView.text asTrim];
    
    [self.commentDict setObject:self.mainModel.dealId forKey:@"deal_id"];
    [self.commentDict setObject:commtentStr forKey:@"content"];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = @"正在发表";
    [HUD show:YES];
    
    [MovieHttpRequest createTuesdaySendCommentWithCommentDict:self.commentDict CallBack:^(id obj) {
        HUD.labelText = @"发表成功";
        [HUD hide:YES];
        
        [window makeToastCenter:@"发表成功"];
        [self talkViewKeyboardDown];
        self.commentView.textView.text = @"";
        [self delectCommentImage:nil];
        
        [self requestTuesdayActiveCommentDatas];
        
        _segmentIndex = 1;
        [self activeSegmentBtnClickedAction:self.headerView.rightSegmentBtn];
////        UIView *line = [self.headerView viewWithTag:200];
//        self.headerView.rightSegmentBtn.selected
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            CGRect lineFrame = line.frame;
//            lineFrame.origin.x = (viewW+20);
//            line.frame = lineFrame;
//        }];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - 上传我的评论中的图片
- (void)requestUploadActiveCommentImage
{
    UIImage *postImage = [DeliveryUtility imageWithImageSimple:self.commentImage scaledToSize:CGSizeMake(self.commentImage.size.width*0.8, self.commentImage.size.height*0.8)];
    
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
            
            [self requestSendActiveComment];
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
    [self.mainTableView endEditing:YES];
    [self.commentView.textView endEditing:YES];
    [self.commentView.textView resignFirstResponder];
}


#pragma mark - 请求周二抢页面数据
- (void)requetTuesdayGoodsActivityDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createTuesdayGoodSellActivityCallBack:^(id obj) {
        
        HUD.labelText = @"加载成功";
        [HUD hide:YES];
        
        self.mainModel = (MovieTuesdayGoodModel *)obj;
        [self.headerView setGoodsModel:self.mainModel];
        [self judementCurrentTimeWhetherActiveTime];
        [self.mainTableView reloadData];
        
        [self requestTuesdayActiveCommentDatas];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - 请求周二抢评论列表接口
- (void)requestTuesdayActiveCommentDatas
{
    [MovieHttpRequest createTuesdayCommentListDatasWithPage:_commentPage andGoodId:self.mainModel.dealId CallBack:^(id obj) {
        
        if (1 == _commentPage) {
            self.commentArray = [NSMutableArray arrayWithArray:obj];
        }
        else{
            [self.commentArray addObjectsFromArray:obj];
        }
        
        [self.mainTableView reloadData];

//        NSInteger count = self.commentArray.count;;
//        if (count > 99) {
//            [self.headerView.rightSegmentBtn setTitle:@"评价(99+)" forState:UIControlStateNormal];
//        }
//        else{
//            [self.headerView.rightSegmentBtn setTitle:[NSString stringWithFormat:@"评价(%zd)",self.commentArray.count] forState:UIControlStateNormal];
//        }
        
        [self.mainTableView.footer endRefreshing];
        
    } andSCallBack:^(id obj) {
        
        [self.mainTableView.footer endRefreshing];
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (0 == _segmentIndex)?1:self.commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == _segmentIndex)
    {
        UITableViewCell *webCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"webCellId"];
        [webCell.contentView addSubview:self.infoWebView];
        webCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return webCell;
    }
    else
    {
        static NSString *cellID = @"commentCellID";
        MovieNewCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == commentCell) {
            commentCell = [[[NSBundle mainBundle] loadNibNamed:@"MovieNewCommentCell" owner:self options:nil] lastObject];
        }
        
        commentCell.tag = indexPath.row;
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        commentCell.blessBtn.tag = indexPath.row;
        [commentCell.blessBtn addTarget:self action:@selector(blessActiveCommentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActiveCommentImageView:)];
        [commentCell.commentImage addGestureRecognizer:tapGes];
        
        MovieTuesdayCommentModel *model = _commentArray[indexPath.row];
        [commentCell setActiveModel:model];
        
        return commentCell;
    }
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == _segmentIndex) {
        return self.infoWebView.frame.size.height;
    }
    else{
        MovieTuesdayCommentModel *model = _commentArray[indexPath.row];
        return [self cacaluteCellHeight:model];
    }
}

//计算评论列表cell高度
- (CGFloat)cacaluteCellHeight:(MovieTuesdayCommentModel *)model
{
    
    CGFloat contentH = [DeliveryUtility caculateContentSizeWithContent:model.content andHight:CGFLOAT_MAX andWidth:kViewWidth-90 andFont:DefaultFont].height;
    
    if (model.img.length) {
        return contentH + 165;
    }else{
        return contentH + 80;
    }
}

- (void)activeSegmentBtnClickedAction:(UIButton *)button
{
    NSInteger index = button.tag - 200;
    UIView *line = [button.superview viewWithTag:300];
    CGFloat viewW = screenWidth/2;
        
    if (0 == index) {
        
        _segmentIndex = 0;
        [UIView animateWithDuration:0.3 animations:^{
           
            CGRect lineFrame = line.frame;
            lineFrame.origin.x = 20;
            line.frame = lineFrame;
        }];
    }
    else{
        
        _segmentIndex = 1;
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect lineFrame = line.frame;
            lineFrame.origin.x = (viewW+20);
            line.frame = lineFrame;
        }];
    }
    
    [self.mainTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 请求点赞与取消点赞接口
- (void)blessActiveCommentBtnClicked:(UIButton *)button
{
    NSInteger index = button.tag;
    MovieTuesdayCommentModel *commentModel = _commentArray[index];
    NSString *commentId = commentModel.commentId;
    
    
    [MovieHttpRequest createActiveBlessWithCommentId:commentId CallBack:^(id obj) {
        
        NSDictionary *dict = (NSDictionary *)obj;
        NSString *praiseNum = [DeliveryUtility nullString:dict[@"content_praise_num"]];
        NSString *statues = [DeliveryUtility nullString:dict[@"ping"]];
        
        if ([statues isEqualToString:@"1"]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"点赞成功"];
             [DeliveryUtility showMessage:@"点赞成功" target:nil];
        }
        
        if ([statues isEqualToString:@"0"]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"取消点赞"];
             [DeliveryUtility showMessage:@"取消点赞" target:nil];
        }
        
        commentModel.ping = statues;
        commentModel.contentPraiseNum = praiseNum;
        [self.mainTableView reloadData];
        
    } andSCallBack:^(id obj) {
        
        
        NSLog(@"点赞失败");
        [DeliveryUtility showMessage:obj target:self];
    }];
}


#pragma mark - 判断是否到活动开抢时间
- (void)judementCurrentTimeWhetherActiveTime
{
    /** 0:活动还未开始(倒计时之前) 1:活动开始(倒计时结束) 其他:倒计时中 */
    NSString *statue = self.mainModel.daojishi;
    
    BOOL isNotStart = [statue isEqualToString:@"0"];
    BOOL isEnded = [statue isEqualToString:@"1"];
    
    if (isNotStart) { //如果活动还没有开始
        self.headerView.startBtn.backgroundColor = RGBColor(220, 220, 220, 1);
        [self.headerView.startBtn setTitle:@"即将开始" forState:UIControlStateNormal];
        [self.headerView.startBtn setTitleColor:RGBColor(85, 85, 85, 1) forState:UIControlStateNormal];
    }
    else if (isEnded)
    {   //倒计时结束,活动开始
        [self rushCheaperGoodBaseNumber];
    }
    else
    {
        self.activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setActiveStartTime) userInfo:nil repeats:YES];
    }
}

- (void)setActiveStartTime
{
    NSDate *dateNow = [NSDate date];
    NSTimeInterval nowInterval = [dateNow timeIntervalSince1970];
    
    NSString *nowStr = [NSString stringWithFormat:@"%.0f",nowInterval];
    NSString *rushTime = self.mainModel.daojishi;
    
    if ([rushTime isEqualToString:nowStr])
    {
        
        [self rushCheaperGoodBaseNumber];
        self.headerView.time.text = @"倒计时:00:00:00";
        [self.activeTimer invalidate];
        self.activeTimer = nil;
        return;
    }
    
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:(([rushTime doubleValue])-nowInterval-28800)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:timeDate];
    
    self.headerView.time.text = [NSString stringWithFormat:@"倒计时:%@",timeStr];
//    HHNSLog(@"倒计时剩余时间 --> %f,%@",nowInterval-28800-([self.mainModel.daojishi doubleValue]),timeStr);
}

#pragma mark - 根据剩余商品数量判断是否抢购
- (void)rushCheaperGoodBaseNumber
{
    if (0 == [self.mainModel.number integerValue]) {
        
        self.headerView.startBtn.backgroundColor = RGBColor(220, 220, 220, 1);
        [self.headerView.startBtn setTitle:@"已抢完" forState:UIControlStateNormal];
        [self.headerView.startBtn setTitleColor:RGBColor(85, 85, 85, 1) forState:UIControlStateNormal];
    }
    else
    {
        _isCanRush = YES;
        self.headerView.startBtn.backgroundColor = RGBColor(215, 0, 18, 1);
        [self.headerView.startBtn setTitle:@"立即抢" forState:UIControlStateNormal];
        [self.headerView.startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


#pragma mark - 即将开始按钮被点击
- (void)startBtnClicked:(UIButton *)button
{
    if (_isCanRush) {
    
//        if (![self.mainModel.ren isEqualToString:@"1"]) {
//            
//            [DeliveryUtility showMessage:@"认证身份后才能抢购商品哦~" target:self];
//            return;
//        }
//    
//        if ([self.mainModel.qiang isEqualToString:@"0"]) {
//            [DeliveryUtility showMessage:@"每次活动每人限抢一件哦~" target:self];
//            return;
//        }
        NSLog(@"即将开始按钮被点击");
        
        NSString *goodId = self.mainModel.dealId;//商品Id
        NSString *goodNum = @"1";   //商品数量
        NSString *shopId = self.mainModel.locationId;//店铺Id
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
        comfirmOrderVC.delegate = self;
        comfirmOrderVC.tebie = @"39";
        comfirmOrderVC.goodsInfoArray = infoA;
        [self.navigationController pushViewController:comfirmOrderVC animated:YES];
    }
}

- (void)payMineOrderSuccess:(BOOL)isSuccess
{
    [self requetTuesdayGoodsActivityDatas];
}


#pragma mark - 查看历史抢购记录
- (void)inspectHistoryActive:(UIButton *)button
{
    MovieTuestdayHistroyListViewController *historyRecordVC = [[MovieTuestdayHistroyListViewController alloc] init];
    historyRecordVC.goodId = self.mainModel.dealId;
    [self.navigationController pushViewController:historyRecordVC animated:YES];
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
    CGFloat webHeight = [[self.infoWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect webFrame = self.infoWebView.frame;
    webFrame.size.height = webHeight;
    self.infoWebView.frame = webFrame;
    self.mainTableView.alpha = 1;
    [self createTuesdayBottomInputeView];
    [self.mainTableView reloadData];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.webHUD.labelText = @"加载失败";
    [self.webHUD hide:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self talkViewKeyboardDown];
}

//返回上一层
- (void)backAction
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
    self.maskView = nil;
    self.commentView = nil;
    
    [self.activeTimer invalidate];
    self.activeTimer = nil;
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


#pragma mark - 弹出评论输入框
- (void)popCommentTextView
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.maskView];
    [window addSubview:self.commentView];
    [window bringSubviewToFront:self.commentView];
    [self.commentView.textView becomeFirstResponder];
}

#pragma mark - 点击评论图片浏览大图
- (void)tapActiveCommentImageView:(UITapGestureRecognizer *)ges
{
    NSLog(@"cellIndex --> %@",NSStringFromClass([ges.view.superview.superview class]));
    [self.commentImageArray removeAllObjects];
    
    NSInteger index = ges.view.superview.superview.tag;
    MovieTuesdayCommentModel *model = _commentArray[index];
    
    NSLog(@"评论图片被点击 -->%zd",index);
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


//#pragma mark - 添加
- (void)addTableViewFooterRefresh
{
    self.mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        if (1 == _segmentIndex) {
            
            _commentPage++;
            [self requestTuesdayActiveCommentDatas];
        }
        else{
            [self.mainTableView.footer endRefreshing];
        }
        
    }];
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
