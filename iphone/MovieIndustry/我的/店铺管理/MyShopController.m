//
//  MyShopController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyShopController.h"
#import "TradingManagerController.h"
#import "PublishPersonnelController.h"
#import "PublishProductController.h"
#import "SiteViewController.h"
#import "GoodsManagerController.h"
#import "StoreSettingController.h"
#import "IncomeDetailsController.h"
#import "MyWalletController.h"
#import "MovieMineStoreInfoModel.h"

#import "ShopMainModel.h"

@interface MyShopController ()<StoreSettingControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UILabel *shopDescLabel;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *myBtnView;
@property (nonatomic,strong) ShopMainModel *storeModel;

@property (nonatomic,strong) UIImageView *shopImageView;


@end

@implementation MyShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTabBar:@"我的店铺"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestMineStoreInfo) name:@"我的店铺修改" object:nil];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(0, 660);
    [self.view addSubview:self.scrollView];
    [self requestMineStoreInfo];
}

#pragma mark - 请求我的店铺数据
- (void)requestMineStoreInfo
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createMineStoreInfomationCallBack:^(id obj) {
        
        HUD.labelText = @"加载完成";
        [HUD hide:YES];
        
        self.storeModel = (ShopMainModel *)obj;
        
//        [self setNavRightItem:@"预览" rightAction:@selector(showAction:)];
        [self createUI];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark - 创建视图
- (void)createUI
{
    NSString *shopName = self.storeModel.shop_name;
    NSString *shopBrify = self.storeModel.shop_desc;
//    NSString *income = [NSString stringWithFormat:@"%.2f元",[self.storeModel.income floatValue]];
//    NSString *myMoney = [NSString stringWithFormat:@"%.2f元",[self.storeModel.money floatValue]];
    UIView *myView1 = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 190)];
    [self.scrollView addSubview:myView1];
    
    //店铺头像
    _shopImageView = [WNController createImageViewWithFrame:CGRectMake(8, 10, 140, 108) ImageName:@"changShop_logo"];
    _shopImageView.clipsToBounds = YES;
    _shopImageView.maskView.clipsToBounds = YES;
    _shopImageView.layer.borderWidth = 1.0f;
    _shopImageView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.87 alpha:1].CGColor;
    
    _shopImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.storeModel.shop_logo]] placeholderImage:[UIImage imageNamed:@"changShop_logo"]];
    _shopImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [myView1 addSubview:_shopImageView];
    UIImageView *smImageView = [WNController createImageViewWithFrame:CGRectMake(CGRectGetMaxX(_shopImageView.frame)-15, CGRectGetMaxY(_shopImageView.frame)-15, 30, 30) ImageName:@"shop_03-02"];
    [myView1 addSubview:smImageView];
    //店铺名称
    
     CGSize size = [shopName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DefaultFont,NSFontAttributeName, nil]];
    CGFloat nameW = screenWidth-255;
    float n = size.width/(int)nameW;
    CGFloat nameH = ceilf(n) * size.height;
    //CGFloat nameW = [DeliveryUtility caculateContentSizeWithContent:shopName andHight:21.0f andWidth:screenWidth-230 andFont:DefaultFont].width;
    // CGFloat nameH = [DeliveryUtility caculateContentSizeWithContent:shopName andHight:21.0f andWidth:screenWidth-130 andFont:DefaultFont].height;
    CGRect nameFrame = CGRectMake(CGRectGetMaxX(_shopImageView.frame)+15, CGRectGetMinY(_shopImageView.frame)+10 , nameW, nameH);
    self.shopNameLabel = [WNController createLabelWithFrame:nameFrame Font:16.0f Text:shopName textAligment:NSTextAlignmentLeft];
    self.shopNameLabel.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
    [myView1 addSubview:self.shopNameLabel];
    
    
    //打分星星
     StarView * starView = [[StarView alloc] initWithFrame:CGRectMake(kViewWidth - 88, 18, 88, 16) score:0 canscore:@"0"];
    [myView1 addSubview:starView];
    
    //星星前面的标志
    UIImageView *levelImage = [WNController createImageViewWithFrame:CGRectMake(CGRectGetMinX(starView.frame)-30,14, 25, 25) ImageName:@"shop_03.png"];
    [myView1 addSubview:levelImage];

    //店铺简介
    CGSize brifySize = [shopBrify sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:DefaultFont,NSFontAttributeName, nil]];
    CGFloat brifyW = screenWidth-170;
    
    CGFloat brifyH =ceilf(brifySize.width/(int)brifyW )*brifySize.height;
    CGRect brifyFrame = CGRectMake(CGRectGetMaxX(_shopImageView.frame)+20, CGRectGetMaxY(self.shopNameLabel.frame)+10, brifyW, brifyH);
    
    self.shopDescLabel = [WNController createLabelWithFrame:brifyFrame Font:13 Text:shopBrify textAligment:NSTextAlignmentLeft];
    self.shopDescLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1];
    [myView1 addSubview:self.shopDescLabel];
#warning 删除
    //第一条线
//    UIView *line1 = [WNController createViewFrame:CGRectMake(0, 128, kViewWidth, 1)];
//    line1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
//    [myView1 addSubview:line1];
    
//    
//    UILabel *label1 = [WNController createLabelWithFrame:CGRectMake(0, 133, kViewWidth/2, 31) Font:21 Text:income textAligment:NSTextAlignmentCenter];
//    label1.textColor = [UIColor colorWithRed:0.8 green:0.07 blue:0 alpha:1];
//    [myView1 addSubview:label1];
    
//    UILabel *label2 = [WNController createLabelWithFrame:CGRectMake(kViewWidth/2, 133, kViewWidth/2, 31) Font:21 Text:myMoney textAligment:NSTextAlignmentCenter];
//    label2.textColor = [UIColor colorWithRed:0.8 green:0.07 blue:0 alpha:1];
//    [myView1 addSubview:label2];
//    
//    UILabel *label3 = [WNController createLabelWithFrame:CGRectMake(kViewWidth/4-30, 163, 60, 21) Font:14 Text:@"今日收入" textAligment:NSTextAlignmentCenter];
//    label3.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
//    [myView1 addSubview:label3];
//    
//    
//    UILabel *label4 = [WNController createLabelWithFrame:CGRectMake(kViewWidth/4*3-30, 163, 60, 21) Font:14 Text:@"余额" textAligment:NSTextAlignmentCenter];
//    label4.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
//    label4.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
//    [myView1 addSubview:label4];
//    
//    UIView *line2 = [WNController createViewFrame:CGRectMake(kViewWidth/2-0.5, 142, 1, 33)];
//    line2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
//    [myView1 addSubview:line2];
    
    
//    //按钮收入明细
//    UIButton *incomeBtn = [WNController createButtonWithFrame:CGRectMake(0, 128, kViewWidth/2, 64) ImageName:@"" Target:self Action:@selector(icomeAction) Title:@"" fontSize:10];
//    [myView1 addSubview:incomeBtn];
//    
//    //余额按钮
//    UIButton *wallletBtn = [WNController createButtonWithFrame:CGRectMake(kViewWidth/2, 128, kViewWidth/2, 64) ImageName:@"" Target:self Action:@selector(walletAction) Title:@""];
//    [myView1 addSubview:wallletBtn];
//

    
   UIView  *btnView = [WNController createViewFrame:CGRectMake(0, 136, kViewWidth, 334)];
   [self.scrollView  addSubview:btnView];
    
    //创建灰色的view
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 13)];
    view.backgroundColor = kViewBackColor;
    [btnView addSubview:view];
    
    
    //创建四个按钮
    UIButton *publishBtn = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4-30, 36, 60, 60) ImageName:@"shop_11" Target:self Action:@selector(publishBtnAction) Title:@""];
    [btnView addSubview:publishBtn];
    
    UILabel *publishLabel = [WNController createLabelWithFrame:CGRectMake(0, 105, kViewWidth/2, 31) Font:17 Text:@"发布商品" textAligment:NSTextAlignmentCenter];
    publishLabel.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
    ;
    [btnView addSubview:publishLabel];
    
    UIButton *goodsManagerBtn = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4*3-30, 36, 60, 60) ImageName:@"shop_11-04" Target:self Action:@selector(goodsManagerAction) Title:@""];
    [btnView addSubview:goodsManagerBtn];
    
    UILabel *goodsManagerLabel = [WNController createLabelWithFrame:CGRectMake(kViewWidth/2, 105, kViewWidth/2, 31) Font:17 Text:@"商品管理" textAligment:NSTextAlignmentCenter];
    goodsManagerLabel.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
    ;
    [btnView addSubview:goodsManagerLabel];
    
    
    UIButton *transManageBtn = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4-30, 202, 60, 60) ImageName:@"shop_11-05.png" Target:self Action:@selector(transManageAction) Title:@""];
    [btnView addSubview:transManageBtn];
    
    UILabel *transManageLabel = [WNController createLabelWithFrame:CGRectMake(0, 268, kViewWidth/2, 31) Font:17 Text:@"交易管理" textAligment:NSTextAlignmentCenter];
    transManageLabel.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
    [btnView addSubview:transManageLabel];
    
    UIButton *storeSetBtn = [WNController createButtonWithFrame:CGRectMake(kViewWidth/4*3-30, 202, 60, 60) ImageName:@"shop_11-06" Target:self Action:@selector(storeSetAction) Title:@""];
    [btnView addSubview:storeSetBtn];
    
    UILabel *storeSetLabel = [WNController createLabelWithFrame:CGRectMake(kViewWidth/2, 268, kViewWidth/2, 31) Font:17 Text:@"店铺设置" textAligment:NSTextAlignmentCenter];
    storeSetLabel.textColor = [UIColor colorWithRed:0.22 green:0.22 blue:0.22 alpha:1];
    [btnView addSubview:storeSetLabel];
    
    
    //创建四条线
    UIView *leftLine = [WNController createViewFrame:CGRectMake(18, 166, kViewWidth/2-36, 1)];
    leftLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [btnView addSubview:leftLine];
    
    UIView *rightLine = [WNController createViewFrame:CGRectMake(18+kViewWidth/2, 166, kViewWidth/2-36, 1)];
    rightLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [btnView addSubview:rightLine];
    
    UIView *upLine = [WNController createViewFrame:CGRectMake(kViewWidth/2-0.5, 18, 1, 334/2-36)];
    upLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [btnView addSubview:upLine];
    
    UIView *downLine = [WNController createViewFrame:CGRectMake(kViewWidth/2-0.5, 18+334/2, 1, 334/2-36)];
    downLine.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [btnView addSubview:downLine];
    
}

#pragma mark - 收入明细
- (void)icomeAction
{
    IncomeDetailsController *incomeVc = [[IncomeDetailsController alloc] init];
    [self.navigationController pushViewController:incomeVc animated:YES];
}

#pragma mark - 余额
- (void)walletAction
{
    MyWalletController *myWalletVc = [[MyWalletController alloc] init];
//    myWalletVc.balance = self.storeModel.money;
    [self.navigationController pushViewController:myWalletVc animated:YES];
    
}

#pragma mark - 发布商品
- (void)publishBtnAction
{
    NSLog(@"%@",self.storeModel.category_id);

    
    UIView *bgView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, kViewHeight+20)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    self.bgView = bgView;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTapGesAction)];
    [bgView addGestureRecognizer:tapGes];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    UIView *btnView = [WNController createViewFrame:CGRectMake(0, kViewHeight+20-148, kViewWidth, 148)];
    btnView.backgroundColor = kViewBackColor;
    self.myBtnView = btnView;
    [[UIApplication sharedApplication].keyWindow addSubview:btnView];
    
    UIButton *btn1 = [WNController createButtonWithFrame:CGRectMake(0, 0, kViewWidth, 148/3-1) ImageName:@"" Target:self Action:@selector(publishProductAction) Title:@"发布产品" fontSize:16];
    btn1.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:btn1];
    
    UIButton *btn2 = [WNController createButtonWithFrame:CGRectMake(0, 148/3, kViewWidth, 148/3-1) ImageName:@"" Target:self Action:@selector(publishPersonnelAction) Title:@"发布人员" fontSize:16];
    btn2.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:btn2];
    
    UIButton *btn3 = [WNController createButtonWithFrame:CGRectMake(0, 148/3*2, kViewWidth, 148/3-1) ImageName:@"" Target:self Action:@selector(siteAction) Title:@"场地" fontSize:16];
    btn3.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:btn3];
    
    
    NSArray * cateArray = [self.storeModel.category_id componentsSeparatedByString:@"3"];
    if ([cateArray[0] isEqualToString:@"0"]) {
        btn2.enabled = NO;
        [btn2 setTitleColor:[UIColor lightGrayColor] forState: UIControlStateNormal];
    }else{
     btn2.enabled = YES;
    [btn2 setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    }
    if ([cateArray[1] isEqualToString:@"0"]) {
        btn1.enabled = NO;
      [btn1 setTitleColor:[UIColor lightGrayColor] forState: UIControlStateNormal];
    }else{
        btn1.enabled = YES;
    [btn1 setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    }
    if ([cateArray[2] isEqualToString:@"0"]) {
        btn3.enabled = NO;
      [btn3 setTitleColor:[UIColor lightGrayColor] forState: UIControlStateNormal];
    }else{
        btn3.enabled = YES;
     [btn3 setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    }
    
    
}

#pragma mark 移除手势
- (void)removeTapGesAction
{
    [self.bgView removeFromSuperview];
    [self.myBtnView removeFromSuperview];
}

#pragma mark - 商品管理
- (void)goodsManagerAction
{
    GoodsManagerController *tradingVc = [[GoodsManagerController alloc] init];
    [self.navigationController pushViewController:tradingVc animated:YES];
}

#pragma mark - 交易管理
- (void)transManageAction
{
    TradingManagerController *tradingVc = [[TradingManagerController alloc] init];
    [self.navigationController pushViewController:tradingVc animated:YES];
    
}

#pragma mark - 店铺设置
- (void)storeSetAction
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
    StoreSettingController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"settingStore"];
    tradingVc.delegate = self;
    [self.navigationController pushViewController:tradingVc animated:YES];
}

- (void)settingMineStoreInfoSuccess:(BOOL)isSuccess;
{
    [self requestMineStoreInfo];
}

#pragma mark - 与
- (void)showAction:(UIButton *)showBtn
{
    
}



#pragma mark - 发布场地按钮点击方法
//发布产品
- (void)publishProductAction
{
    
    
    [self removeTapGesAction];
//    PublishProductController  *tradingVc = [[PublishProductController alloc] init];
//    [self.navigationController pushViewController:tradingVc animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
    PublishProductController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"publishProduct"];
    [self.navigationController pushViewController:tradingVc animated:YES];
}

//发布人员
- (void)publishPersonnelAction
{
    [self removeTapGesAction];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
    PublishPersonnelController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"issuePerson"];
    [self.navigationController pushViewController:tradingVc animated:YES];
}
//场地
- (void)siteAction
{
    [self removeTapGesAction];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MoviePersonal" bundle:nil];
    SiteViewController *tradingVc = [storyboard instantiateViewControllerWithIdentifier:@"issueGround"];
    [self.navigationController pushViewController:tradingVc animated:YES];
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
