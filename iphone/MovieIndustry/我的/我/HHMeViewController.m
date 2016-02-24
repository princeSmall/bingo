//
//  HHMeViewController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/6.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "HHMeViewController.h"
#import "PointTableViewController.h"
#import "TradeRecordController.h"
#import "MyShopingCarController.h"
#import "MyPhotosController.h"
#import "SettingViewController.h"
#import "MyShopController.h"
//#import "ChatViewController.h"
#import "MyMessageController.h"
#import "CourseViewController.h"
#import "MyCollectionController.h"
#import "FansAndFriendsController.h"
#import "MoviePersonalInfoViewController.h"
#import "MovieMineInfoModel.h"
#import "MovieCreateMineShopViewController.h"
#import "HHOrderViewController.h"
#import "MovieShopCarViewController.h"
#import "LoginInController.h"

#import "MyHelpViewController.h"

#import "UserDesModel.h"


@interface HHMeViewController ()

@property (nonatomic,retain) MovieMineInfoModel *mainModel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabelStr;

@property (nonatomic,strong)UserDesModel * desModel;

@end

@implementation HHMeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createMineStoreSuccess) name:@"storeOpenSuccess" object:nil];

    if (!APP_DELEGATE.user_id) {
        self.view.userInteractionEnabled = NO;

    }else
    {
        self.view.userInteractionEnabled = YES;
        
    }
}

- (void)createMineStoreSuccess
{
    [self getMineInfoRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = kViewBackColor;
    [self setNavTabBar:@"我的"];
     self.headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
#warning 帮助
//   [self setNavRightItem:@"帮助" rightAction:@selector(RightAction)];
    [self addTargetActionForButton];
    [self getMineInfoRequest];

}

- (void)RightAction{
    NSLog(@"右边按钮点击事件");
    MyHelpViewController * help = [[MyHelpViewController alloc]init];
    [self.navigationController pushViewController:help animated:YES];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.mainModel) {
        [self getMineInfoRequest];
    }
}

- (void)addTargetActionForButton
{
    [self.tradeButton addTarget:self action:@selector(tradeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.carButton addTarget:self action:@selector(carButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myPhotosButton addTarget:self action:@selector(myPhotosButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.settingButton addTarget:self action:@selector(settingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.storeButton addTarget:self action:@selector(storeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //消息
    [self.messageButton addTarget:self action:@selector(messageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //收藏
    [self.collectionButton addTarget:self action:@selector(collectionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //课程
    [self.courseButton addTarget:self action:@selector(courseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //好友及粉丝
    [self.fansAndFriendsButton addTarget:self action:@selector(fansAndFriendsButtonAction) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - 请求数据,获取我的个人信息
- (void)getMineInfoRequest
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if(!APP_DELEGATE.user_id)
    {
//         [HUD hide:YES];
        return;
    }
    dict[@"user_id"] = APP_DELEGATE.user_id;
    
    [HttpRequestServers requestBaseUrl:TIPerson_UserDetail withParams:dict withRequestFinishBlock:^(id result) {
        if (result[@"data"]) {
            UserDesModel * desModel = [[UserDesModel alloc]initWithDict:result[@"data"]];
            self.desModel = desModel;
            [self refreshMineInfomations];
        }
    } withFieldBlock:^{
    }];
}

//根据网络数据刷新界面
- (void)refreshMineInfomations
{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.desModel.img]] placeholderImage:[UIImage imageNamed:@"defualt_headerImg"]];
    
    if ([self.desModel.nickname isEqualToString:@""]) {
        self.name.text = self.desModel.mobile;
    }else{
    self.name.text = self.desModel.nickname;
    }
    //判断用户是否开通店铺
    if ([self.desModel.has_shop isEqualToString:@"0"]) {
        self.shopLabelStr.text = @"我要开店";
    }else{
        self.shopLabelStr.text = @"店铺管理";
    
    }
    
    [self setSubviewsNewFrame];
}

- (void)setSubviewsNewFrame
{
    CGRect nameFrame = self.name.frame;
    nameFrame.size.width = [DeliveryUtility caculateContentSizeWithContent:self.desModel.nickname andHight:21.0f andWidth:((kViewWidth-100)/2) andFont:[UIFont systemFontOfSize:16.0f]].width;
    self.name.frame = nameFrame;
    
    CGRect lineFrame = self.separeLine.frame;
    lineFrame.origin.x = CGRectGetMaxX(nameFrame)+10;
    self.separeLine.frame = lineFrame;
    
    CGRect careerFrame = self.career.frame;
    careerFrame.origin.x = CGRectGetMaxX(lineFrame)+10;
    careerFrame.size.width = (kViewWidth-nameFrame.size.width - 150);
    self.career.frame = careerFrame;
    
    NSString *fansStr = [NSString stringWithFormat:@"粉丝: %@",self.mainModel.focusedCount];
    CGRect fansFrame = self.fansNum.frame;
    fansFrame.size.width = [DeliveryUtility caculateContentSizeWithContent:fansStr andHight:21.0f andWidth:((kViewWidth-110)/2) andFont:[UIFont systemFontOfSize:13.0f]].width;
    self.fansNum.frame = fansFrame;
    
    CGRect concernFrame = self.attentionNum.frame;
    concernFrame.origin.x = CGRectGetMaxX(fansFrame)+20;
    self.attentionNum.frame = concernFrame;
}

#pragma mark - 点击我的头像
- (IBAction)mineHeaderImageClicked:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
    MoviePersonalInfoViewController *personalVC = [storyboard instantiateViewControllerWithIdentifier:@"personalInfo"];
    personalVC.mineModel = self.mainModel;
    
    personalVC.desModel = self.desModel;
    
    personalVC.backRefreshInfo = ^(BOOL isChange){
        
        if (isChange) {
            [self getMineInfoRequest];
        }
    };

    [personalVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:personalVC animated:YES];
}


#pragma mark - 收藏
- (void)collectionButtonAction
{
    MyCollectionController *collectVc = [[MyCollectionController alloc] init];
    [collectVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:collectVc animated:YES];
}

#pragma mark - 课程
- (void)courseButtonAction
{
    CourseViewController *courseVc = [[CourseViewController alloc] init];
    [courseVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:courseVc animated:YES];
}

#pragma mark - 粉丝和好友
- (void)fansAndFriendsButtonAction
{
    FansAndFriendsController *fansVc = [[FansAndFriendsController alloc] init];
    [fansVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:fansVc animated:YES];
}

- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
}

#pragma mark - 消息页面
- (void)messageButtonAction
{
    MyMessageController *messVc = [[MyMessageController alloc] init];
    messVc.locationId = self.mainModel.locationId;
    [messVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:messVc animated:YES];
}


#pragma mark - 我的相册
- (void)myPhotosButtonAction
{
    MyPhotosController *photosVc = [[MyPhotosController alloc] init];
    [photosVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:photosVc animated:YES];
}

#pragma mark - 购物车
- (void)carButtonAction
{
    MovieShopCarViewController *shopingVc = [[MovieShopCarViewController alloc] init];
    [shopingVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:shopingVc animated:YES];
}

#pragma mark - 查看我的积分
- (IBAction)checkMinePointAction:(id)sender {
    
    PointTableViewController *pointsVc = [[PointTableViewController alloc] init];
    pointsVc.allPoint = self.mainModel.point;
    [pointsVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:pointsVc animated:YES];
}


#pragma mark - 设置界面
- (void)settingButtonAction
{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    settingVc.locationId = self.mainModel.locationId;
    [settingVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 交易记录
- (void)tradeButtonAction
{
    HHOrderViewController *tradeVc = [[HHOrderViewController alloc] init];
    [tradeVc setHidesBottomBarWhenPushed:YES];
    tradeVc.navigationItem.leftBarButtonItem = nil;
    tradeVc.Order = @"1";
    [self.navigationController pushViewController:tradeVc animated:YES];
    [tradeVc setHidesBottomBarWhenPushed:NO];
}

#pragma mark - 我的店铺
- (void)storeButtonAction
{
    //如果没有开店，则进入开店页面。
    if([self.desModel.has_shop isEqualToString:@"0"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
        
        MovieCreateMineShopViewController *createShopVC = [storyboard instantiateViewControllerWithIdentifier:@"createMineShop"];
        
        [self.navigationController pushViewController:createShopVC animated:YES];
    
    }else{
        //如果已经开店则进入店铺管理页面
    MyShopController *myShopVc = [[MyShopController alloc] init];
    [myShopVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myShopVc animated:YES];

   }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
