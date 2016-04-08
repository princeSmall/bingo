//
//  HHMeViewController.m
//  个人中心页面
//
//  Created by aaa on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "HHMeViewController.h"
#import "UIImage+Blur.h"
#import "DeliveryUtility.h"
#import "HHMTableViewCell.h"
#import "MoviePersonalInfoViewController.h"
#import "MyCollectionController.h"
#import "CourseViewController.h"
#import "FansAndFriendsController.h"
#import "MyMessageController.h"
#import "SettingViewController.h"
#import "MovieShopCarViewController.h"
#import "MyPhotosController.h"
#import "MovieCreateMineShopViewController.h"
#import "MyShopController.h"


@interface HHMeViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  顶部视图
 */
@property (nonatomic,strong)UIView * headView;
/**
 *  TableView视图
 */
@property (nonatomic,strong)UITableView * mainTableView;

@property (nonatomic,strong)UIImageView * headImage;
@property (nonatomic,strong)UIImageView * headBackGroundView;
//姓名
@property (nonatomic,strong)NSString * nameString;
//职称
@property (nonatomic,strong)NSString * desString;
//粉丝
@property (nonatomic,strong)NSString * fansString;
@property (nonatomic,strong)UILabel * fans;
//关注
@property (nonatomic,strong)NSString * noticeString;
@property (nonatomic,strong)UILabel * notices;
//积分
@property (nonatomic,strong)NSString * countString;
@property (nonatomic,strong)UILabel * counts;

//余额
@property (nonatomic,strong)UILabel *bananceLabel;
@property (nonatomic,strong)UILabel * yuanLabel;

//传入点击头像页面的参数
@property (nonatomic,strong)UserDesModel * desModel;
@property (nonatomic,strong)NSData * sendData;

//我要开店的string
@property (nonatomic,strong)NSString * shopStr;


//namelabel  竖线  职称
@property (nonatomic,strong)UILabel * labelName;
@property (nonatomic,strong)UILabel * labelLine;
@property (nonatomic,strong)UILabel * labelZC;

@end

@implementation HHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shopStr = @"0";
    self.view.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = @"我的";
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    //创建顶部视图
    [self CreateHeadView];
    [self CreateIconAndLv];
    //创建四个按钮
    [self CreateMidView];
    //创建余额页面
    [self CreateBalanceView];
    //创建底部的视图
    [self CreateMainTableView];
    //发送网络请求
    [self getMineInfoRequest];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMineInfoRequest) name:@"storeOpenSuccess" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)getMineInfoRequest
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if(!APP_DELEGATE.user_id){return;}
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
- (void)refreshMineInfomations{
  [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.desModel.img]] placeholderImage:[UIImage imageNamed:@"defualt_headerImg"]];

    if ([self.desModel.nickname isEqualToString:@""]) {
        self.nameString = self.desModel.mobile;
    }else{
        self.nameString = self.desModel.nickname;
    }
    self.shopStr = self.desModel.has_shop;
     [self CreateNameAndDesLabel];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,self.desModel.img]]];
    
    self.sendData = data;
    self.headBackGroundView.image = [[UIImage imageWithData:data] blurredImage:0.5];
    [self.mainTableView reloadData];

}

- (void)CreateBalanceView{
    CGFloat bananceH = 50;
    UIView * viewBanance = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+55, self.view.frame.size.width, bananceH)];
    viewBanance.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewBanance];
    UILabel * bananceLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 60, bananceH)];
    bananceLabel.textColor = [UIColor colorWithRed:0.482 green:0.486 blue:0.490 alpha:1.000];
    bananceLabel.font = [UIFont systemFontOfSize:15];
    bananceLabel.text = @"余额";
    NSString * stri = @"0.00";
    CGSize bananSize = [DeliveryUtility caculateContentSizeWithContent:stri andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:22]];
    UILabel * bananceCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bananceLabel.frame),0,bananSize.width, bananceH)];
    bananceCountLabel.textColor = [UIColor colorWithRed:0.796 green:0.122 blue:0.247 alpha:1.000];
    bananceCountLabel.text = stri;
    bananceCountLabel.font = [UIFont systemFontOfSize:22];
    self.bananceLabel = bananceCountLabel;
    UILabel * yuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bananceCountLabel.frame)+3,3,bananSize.width, bananceH)];
    yuanLabel.text = @"元";
    self.yuanLabel = yuanLabel;
    yuanLabel.font = [UIFont systemFontOfSize:12];
    yuanLabel.textColor = [UIColor colorWithRed:0.796 green:0.122 blue:0.247 alpha:1.000];
    [viewBanance addSubview:bananceLabel];
    [viewBanance addSubview:bananceCountLabel];
    [viewBanance addSubview:yuanLabel];
    
    UIImageView * LimageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 28, 15, 20, 20)];
    LimageView.image = [UIImage imageNamed:@"help_right.png"];
    [viewBanance addSubview:LimageView];
    
    UIButton * bananceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewBanance.frame.size.width, viewBanance.frame.size.height)];
    [bananceBtn addTarget:self action:@selector(BananceAction) forControlEvents:UIControlEventTouchUpInside];
    [viewBanance addSubview:bananceBtn];
}
/**
 *  余额按钮事件
 */
- (void)BananceAction{
    NSLog(@"余额按钮事件");
}



- (void)CreateMainTableView{

    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+115, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.headView.frame)+115)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.scrollEnabled = NO;
    self.mainTableView.separatorStyle = 0;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HHMTableViewCell * cell = [[HHMTableViewCell alloc]initWithTableView:tableView];
    if (indexPath.row == 0) {
        [cell SetTitle:@"设置" AndIcon:[UIImage imageNamed:@"site2.png"]];
    }
    if (indexPath.row == 1) {
        [cell SetTitle:@"租物车" AndIcon:[UIImage imageNamed:@"site3.png"]];
    }
    if (indexPath.row == 2) {
        [cell SetTitle:@"相册" AndIcon:[UIImage imageNamed:@"site4.png"]];
    }
    if (indexPath.row == 3) {
        
        if ([self.shopStr isEqualToString:@"0"]) {
            [cell SetTitle:@"我要开店" AndIcon:[UIImage imageNamed:@"site5.png"]];
        }else{
            [cell SetTitle:@"店铺管理" AndIcon:[UIImage imageNamed:@"site5.png"]];
        }
    }
    cell.selectionStyle = 0;
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  创建中间的四个Button和灰色区
 *
 */
- (void)CreateMidView{
       CGFloat btnW = [UIScreen mainScreen].bounds.size.width/4;
    [self CreateBtnWithTitle:@"消息" AndSel:@selector(NoticeAction) AndBtnX:0];
    [self CreateBtnWithTitle:@"收藏" AndSel:@selector(FavoritesAction) AndBtnX:btnW];
    [self CreateBtnWithTitle:@"课程" AndSel:@selector(ClassAction) AndBtnX:2*btnW];
    [self CreateBtnWithTitle:@"粉丝及好友" AndSel:@selector(FriendsAction) AndBtnX:3*btnW];
 
}
//消息按钮
- (void)NoticeAction{
    MyMessageController *messVc = [[MyMessageController alloc] init];
    [messVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:messVc animated:YES];
}
//收藏按钮
- (void)FavoritesAction{
    MyCollectionController *collectVc = [[MyCollectionController alloc] init];
    [collectVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:collectVc animated:YES];
}
//课程按钮
- (void)ClassAction{
    CourseViewController *courseVc = [[CourseViewController alloc] init];
    [courseVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:courseVc animated:YES];
}

- (void)FriendsAction{
    FansAndFriendsController *fansVc = [[FansAndFriendsController alloc] init];
    [fansVc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:fansVc animated:YES];
}


/**
 *  这边是创建消息收藏等按钮，需要考虑 在消息按钮上方放致小红点。
 */
- (void)CreateBtnWithTitle:(NSString *)title AndSel:(SEL)action AndBtnX:(CGFloat)BtnX{
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width/4;
    CGFloat btnH = 45;
    CGFloat btnY = CGRectGetMaxY(self.headView.frame);
    CGRect rect = CGRectMake(BtnX, btnY, btnW, btnH);
    UIButton * button = [[UIButton alloc]initWithFrame:rect];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor colorWithWhite:0.341 alpha:1.000] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button];
}




/**
 *  创建顶部的view
 */
- (void)CreateHeadView{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/2 - 40)];
    UIImageView * BackGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    BackGroundImageView.center = headView.center;
    UIImage * backImage = [UIImage imageNamed:@"testImage.jpg"];
    BackGroundImageView.image = [backImage blurredImage:0.5];
    self.headBackGroundView = BackGroundImageView;
    BackGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [headView addSubview:BackGroundImageView];
    headView.layer.masksToBounds = YES;
    [self.view addSubview:headView];
    self.headView = headView;
}
/**
 *  创建头像和LV等级
 */
- (void)CreateIconAndLv{
    //头像
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,([UIScreen mainScreen].bounds.size.width/2 - 30 -  [UIScreen mainScreen].bounds.size.width/4 + 10)/2 ,  [UIScreen mainScreen].bounds.size.width/4 - 10,  [UIScreen mainScreen].bounds.size.width/4 - 10)];
    headerImage.image = [UIImage imageNamed:@"defualt_headerImg"];
    headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImage.layer.borderWidth = 2;
    headerImage.layer.cornerRadius = ([UIScreen mainScreen].bounds.size.width/4 - 10)/2;
    headerImage.layer.masksToBounds = YES;
    self.headImage = headerImage;
    UIButton * iconBtn = [[UIButton alloc]initWithFrame:headerImage.frame];
    [iconBtn addTarget:self action:@selector(IconAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:headerImage];
    [self.headView addSubview:iconBtn];
    //等级
    UILabel * lvLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)-25, CGRectGetMaxY(headerImage.frame)- 16, 35, 16)];
    lvLabel.backgroundColor = [UIColor colorWithRed:0.976 green:0.408 blue:0.047 alpha:1.000];
    lvLabel.textColor = [UIColor whiteColor];
    lvLabel.text = @"V1";
    lvLabel.font = [UIFont systemFontOfSize:16];
    lvLabel.layer.cornerRadius = 8;
    lvLabel.layer.masksToBounds = YES;
    lvLabel.textAlignment = 1;
    [self.headView addSubview:lvLabel];
    
    //粉丝
    CGSize fansSize = [DeliveryUtility caculateContentSizeWithContent:@"粉丝：" andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:15]];
    UILabel * fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame) + 30, CGRectGetMaxY(self.headImage.frame) - self.headImage.frame.size.height/2 - fansSize.height/2, fansSize.width, fansSize.height)];
    fansLabel.textColor = [UIColor whiteColor];
    fansLabel.font = [UIFont systemFontOfSize:15];
    fansLabel.text = @"粉丝：";
    [self.headView addSubview:fansLabel];
    
    UILabel * fans = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fansLabel.frame), fansLabel.frame.origin.y, 60, fansSize.height)];
    fans.textColor = [UIColor whiteColor];
    fans.font = [UIFont systemFontOfSize:15];
    fans.text = @"0";
    self.fans = fans;
    [self.headView addSubview:self.fans];
    //关注
    UILabel * noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fans.frame), fans.frame.origin.y, fansSize.width, fansSize.height)];
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.font = [UIFont systemFontOfSize:15];
    noticeLabel.text = @"关注：";
    [self.headView addSubview:noticeLabel];
    
    UILabel * notices = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noticeLabel.frame), fans.frame.origin.y, 60, fansSize.height)];
    notices.textColor = [UIColor whiteColor];
    notices.font = [UIFont systemFontOfSize:15];
    notices.text = @"0";
    self.notices = notices;
    [self.headView addSubview:notices];
    //积分
    UILabel * countLabel = [[UILabel alloc]initWithFrame:CGRectMake(fansLabel.frame.origin.x,CGRectGetMaxY(self.headImage.frame) - fansSize.height, fansSize.width, fansSize.height)];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.text = @"积分：";
    countLabel.font = [UIFont systemFontOfSize:15];
    [self.headView addSubview:countLabel];
    
    UILabel * counts = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(countLabel.frame), countLabel.frame.origin.y, 60, fansSize.height)];
    counts.textColor = [UIColor whiteColor];
    counts.font = [UIFont systemFontOfSize:15];
    counts.text = @"0";
    self.counts = counts;
    [self.headView addSubview:self.counts];
    
    //积分Button
    UIButton * countsBtn = [[UIButton alloc]initWithFrame:CGRectMake(countLabel.frame.origin.x, countLabel.frame.origin.y, 300, 50)];
    [countsBtn addTarget:self action:@selector(CountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:countsBtn];
}
/**
 *  这边是请求到数据后，去做的事情
 */
- (void)CreateNameAndDesLabel{
    
    /**
     *  之前的时候 要给fansS等 赋值。
     */
//    self.nameString = @"诸葛亮诸葛亮";
    self.desString = @"蜀国军师";
    self.fansString = @"0";
    self.noticeString = @"0";
    self.countString = @"0";
    //姓名
    UIFont * font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    CGSize nameSize = [DeliveryUtility caculateContentSizeWithContent:self.nameString andHight:MAXFLOAT andWidth:MAXFLOAT andFont:font];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame) + 30, _headImage.frame.origin.y, nameSize.width, nameSize.height)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = font;
    nameLabel.text = self.nameString;
    [self.headView addSubview:nameLabel];
    self.labelName = nameLabel;
    //竖线
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+10, nameLabel.frame.origin.y, 0.7, nameLabel.frame.size.height)];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:lineLabel];
    self.labelLine = lineLabel;
    //职称
    CGSize ZCSize = [DeliveryUtility caculateContentSizeWithContent:self.nameString andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:15]];
    UILabel * labelZC = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineLabel.frame) +10, CGRectGetMaxY(nameLabel.frame)-ZCSize.height, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(lineLabel.frame)-30, ZCSize.height)];
    labelZC.textColor = [UIColor whiteColor];
    labelZC.font = [UIFont systemFontOfSize:15];
    labelZC.text = self.desString;
    self.labelZC = labelZC;
    [self.headView addSubview:labelZC];
    
    self.fans.text = self.fansString;
    self.notices.text = self.noticeString;
    self.counts.text = self.countString;
    
}

- (void)CountBtnClick{
    NSLog(@"积分按钮被点击");
    
}
/**
 *  头像按钮被点击
 */
- (void)IconAction{
 
    MoviePersonalInfoViewController *personalVC = [[MoviePersonalInfoViewController alloc]init];
    personalVC.model = self.desModel;
    personalVC.headImageData = self.sendData;
    personalVC.block = ^(BOOL isChange){
        
        if (isChange) {
            [self.labelLine removeFromSuperview];
            [self.labelName removeFromSuperview];
            [self.labelZC removeFromSuperview];
            [self getMineInfoRequest];
        }
    };
    
    [personalVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:personalVC animated:YES];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        SettingViewController *settingVc = [[SettingViewController alloc] init];
        [settingVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:settingVc animated:YES];
    }if (indexPath.row == 1) {
        MovieShopCarViewController *shopingVc = [[MovieShopCarViewController alloc] init];
        [shopingVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shopingVc animated:YES];
    }if (indexPath.row == 2) {
        MyPhotosController *photosVc = [[MyPhotosController alloc] init];
        [photosVc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:photosVc animated:YES];
    }if (indexPath.row == 3) {
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
}



@end
