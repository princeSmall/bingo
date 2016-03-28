//
//  LightningRentController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "LightningRentController.h"
#import "MovieDefaultTableViewCell.h"
#import "MovieLightRentSimpleModel.h"
#import "PushSuccessViewController.h"
#import "LightRentPublishView.h"
#import "CustomDatePickView.h"
#import "NSUserManager.h"
#import "TimeSelectView.h"
#import "CityModel.h"
#import "HHLocationService.h"
#import "LightRentContentModel.h"

#define DEFAULT_PLACEHOLD @"请输入备注信息(限5~100字)"
#define PLACEHOLD_COLOR   RGBColor(187, 187, 190, 1)
#define TEXT_COLOR        [UIColor blackColor]

#define BTN_START_TAG 100
#define btnBgColor [UIColor colorWithRed:0.91 green:0.91 blue:0.95 alpha:1]

@interface LightningRentController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,HHLocationServiceDelegate>

@property (nonatomic,retain) UITableView *mainTableView;

//关键字输入框
@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIView *segmentView;
@property (nonatomic,assign) NSInteger chooseIndex;

@property (nonatomic,retain) NSArray *priceArray;//价格列表数据
@property (nonatomic,retain) NSArray *typeArray; //类型列表数据

///索引目录
@property (nonatomic,strong) NSMutableArray *suoyinArray;
///城市数组
@property (nonatomic,strong) NSMutableArray *cityArray;
///热点城市
@property (nonatomic, strong) NSMutableArray *arrayHotCity;//热门城市
///历史搜索的数组
@property (nonatomic,strong) NSMutableArray *historyCityArray;
////历史搜索的城市ID
@property (nonatomic,strong) NSMutableArray *historyCityIDArray;
/**
 *  本地城市label
 */
@property (nonatomic,strong) UILabel *localCityLbl;

//备注输入框
@property (nonatomic,strong) UITextView *textView;

//发布闪电租 数据源
@property (nonatomic,strong) NSMutableDictionary *requestDict;

///发布弹出的提示框
@property (nonatomic,strong) LightRentPublishView *lightRentPubView;

///自定义DataPickView
@property (nonatomic,strong) CustomDatePickView *customPickView;
//点击开始的按钮为0，结束为1
@property (nonatomic,copy) NSString *dateTimeType;
///判断是否显示时间选择器
@property (nonatomic,assign) NSUInteger clickDatePickCount;

///选择时间View
@property (nonatomic,strong) TimeSelectView *timeSelectView;
////时间选择时的按钮字要隐藏
@property (nonatomic,strong) UIButton *tempButton;

///开始的时间
@property (nonatomic,strong) NSDate *startDate;
//结束的时间
@property (nonatomic,strong) NSDate *endDate;
///城市字符串
@property (nonatomic,copy) NSString *selectedCity;
///显示地区的按钮
@property (nonatomic,strong) UIButton *cityButton;
///显示的时间
@property (nonatomic,strong) UIButton *timesButton;
//开始的时间
@property (nonatomic,copy) NSString *qiTimes;
//结束的时间
@property (nonatomic,copy) NSString *zhiTime;
///显示类型
@property (nonatomic,strong) UIButton *rentTypeButton;
///显示价格
@property (nonatomic,strong) UIButton *rentPriceButton;

//选中的值 用于显示四个按钮
@property (nonatomic,assign) NSUInteger btnframeindex;

//定位的时候在转动
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

//位置管理器
@property (nonatomic,strong) HHLocationService *locationManager;
/**
 *  发布详情模型
 */
@property (nonatomic,strong) LightRentContentModel *rentModel;
@end

@implementation LightningRentController

-(LightRentContentModel *)rentModel
{
    if(!_rentModel)
    {
        _rentModel = [[LightRentContentModel alloc]init];
    }
    return _rentModel;
}
//历史记录数组  本地文件存储
- (NSMutableArray *)historyCityArray
{
    if (!_historyCityArray) {
        _historyCityArray = [NSMutableArray array];
        _historyCityArray = [NSMutableArray arrayWithArray:[NSUserManager readNSUserDefaultsAndKey:@"rentHistoryCity"]];
    }
    return _historyCityArray;
}

- (NSMutableArray *)historyCityIDArray
{
    if (!_historyCityIDArray) {
        _historyCityIDArray = [NSMutableArray array];
        _historyCityIDArray = [NSMutableArray arrayWithArray:[NSUserManager readNSUserDefaultsAndKey:@"rentHistoryCityID"]];
    }
    return _historyCityIDArray;
}

- (TimeSelectView *)timeSelectView
{
    if (!_timeSelectView) {
        _timeSelectView = [[TimeSelectView alloc] init];
        _timeSelectView.selectedButton.tag = 101;
        [_timeSelectView.selectedButton addTarget:self action:@selector(changeScreenCondiction:) forControlEvents:UIControlEventTouchUpInside];
        _timeSelectView.frame = CGRectMake(kViewWidth/4+10, 0, kViewWidth/4-20, 50);
    }
    
    return _timeSelectView;
}

- (NSMutableArray *)arrayHotCity
{
    if (!_arrayHotCity) {
        _arrayHotCity = [NSMutableArray array];
    }
    return _arrayHotCity;
}

- (NSMutableArray *)suoyinArray
{
    if (!_suoyinArray) {
        _suoyinArray = [NSMutableArray array];
    }
    return _suoyinArray;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
    
    
    
}

#warning 
#warning 
#warning
//这边考虑是先写死数据，随后，采用网络请求的方式获值
- (NSArray *)priceArray
{
    if (nil == _priceArray) {
        _priceArray = [NSArray new];
        _priceArray = @[@"1000元以下",@"1000元~5000元",@"5000元~15000元",@"15000元~30000元",@"30000元以上",@"不限"];
    }
    return _priceArray;
}

- (NSArray *)typeArray
{
    if (nil == _typeArray) {
        _typeArray = [NSArray new];
        _typeArray = @[@"场地",@"人员",@"产品",@"不限"];
        
    }
    return _typeArray;
}

-(UIActivityIndicatorView *)indicatorView
{
    if(!_indicatorView)
    {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView .frame = CGRectMake(5, 5, 30, 30);
    }
    return _indicatorView;
}

- (NSMutableDictionary *)requestDict
{
    if (nil == _requestDict) {
        _requestDict = [NSMutableDictionary new];
    }
    return _requestDict;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,91 + 10+10, kViewWidth, kViewHeight-44-101-10) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        //设置索引目录的背景颜色
        _mainTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _mainTableView.backgroundColor = kViewBackColor;
        
    }
    return _mainTableView;
}
/**
 *  增加headview
 */
-(void)addHeaderView
{
    //设置headerview
    UIView *headerView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 40)];
    UILabel *locationLabel =  [WNController createLabelWithFrame:CGRectMake(15, 0, 150, 40) Font:15 Text:@"" textAligment:NSTextAlignmentLeft];
    //定位的城市
    UILabel *gpsLabel = [WNController createLabelWithFrame:CGRectMake(kViewWidth-100, 0, 90, 40) Font:13 Text:@"GPS定位" textAligment:NSTextAlignmentRight];
    gpsLabel.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    //菊花
    [self.indicatorView startAnimating];
    
    //点击按钮定位
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, kViewWidth, 40);
    [btn addTarget:self action:@selector(chooseLocationAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:gpsLabel];
    [headerView addSubview:locationLabel];
    [headerView addSubview:self.indicatorView];
    [headerView addSubview:btn];
    self.localCityLbl  = locationLabel;
    _mainTableView.tableHeaderView = headerView;
    //_mainTableView.tableHeaderView.hidden =YES;

}
/**
 *  移除headview
 */
-(void)dismissHeadView
{
    [_mainTableView setTableHeaderView:[[UIView alloc]init]];

}
/**
 *  刷新定位
 */
-(void)chooseLocationAction
{
    NSLog(@"刷新定位");
}
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view removeGestureRecognizer:self.panGes];
    
    
    [self setNavTabBar:@"闪电租"];//设置导航栏按钮以及标题
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rentHistoryCity"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rentHistoryCityID"];
    
    //监听键盘的高度
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    ////初始化datePick类型
    self.dateTimeType = @"0";
    
    self.btnframeindex = 0;
    
    self.clickDatePickCount = 1;
    ///加载城市及数据
    [self loadCityData];
    
    [self createMainViews];
    
    self.locationManager = [[HHLocationService alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager openLocationService];
    
//    [self requestPriceAndCatelogueDatas];
}

- (void)locationAddressString:(NSString *)addString
{
    _localCityLbl.text = addString;
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    //抽取前两位
    
    NSString *cityStr = @"";
    @try {
        cityStr = [addString substringWithRange:NSMakeRange(0, 2)];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    //[self loadCityData:cityStr];
}
#pragma mark - 获取网络城市数据
- (void)loadCityData
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"name", nil];
    [HttpRequestServers requestBaseUrl:TICity_List withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"-------->%@",dict);
        @try {
            
            if ([dict[@"code"] intValue]==0)
            {
                NSArray *arrayCity = dict[@"data"];
                [self.suoyinArray removeAllObjects];
                [self.cityArray removeAllObjects];
                [self.arrayHotCity removeAllObjects];
                
                //[self.suoyinArray addObject:UITableViewIndexSearch];
                if (self.historyCityArray.count>0) {
                    ///添加历史搜索
                    [self.cityArray addObject:self.historyCityArray];
                    [self.suoyinArray addObject:@"历"];
                }
                ///添加索引的搜索按钮
                [self.suoyinArray addObject:@"热"];
                ///热点城市
                for (int i=0 ;i<1;i++) {
                    CityModel *hotCityModel = [[CityModel alloc] init];
                    hotCityModel.cityName = @"上海";
                    hotCityModel.cityId = @"上海";
                    [self.arrayHotCity addObject:hotCityModel];
                }
                ///将热点城市加到大数组里面
                [self.cityArray addObject:self.arrayHotCity];
                ///城市索引和城市列表表
                for (NSDictionary *listDict in arrayCity) {
                    [self.suoyinArray addObject:listDict[@"type"]];
                    ///存储城市列表临时变量
                    NSMutableArray *cityInfoArray = [NSMutableArray array];
                    for (NSString *city  in listDict[@"list"]) {
                        CityModel *cityModel = [[CityModel alloc] init];
                        cityModel.cityName = city;
                        cityModel.cityId = city;
                        [cityInfoArray addObject:cityModel];
                    }
                    ///存储到数据数组
                    [self.cityArray addObject:cityInfoArray];
                }
                
                HHNSLog(@"hotarr %@, cityArr %@, suoyin%@",self.arrayHotCity,self.cityArray,self.suoyinArray);
                
                ///刷新数据
                [self.mainTableView reloadData];
                [self.view endEditing:YES];
                
            }else
            {
//                [PromptLabel custemAlertPromAddView:self.view text:dict[@"msg"]];
            }

            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",[exception description]);
        }
        @finally {
            
        }
        
    } withFieldBlock:^{
//        [PromptLabel custemAlertPromAddView:self.view text:kNetWork_ERROR];
    }];
}


- (void)createMainViews
{
    //文本框的圆角背景View
    UIView *textView = [WNController createViewFrame:CGRectMake(10, 10, kViewWidth-20, 36)];
    textView.layer.cornerRadius = 16;
    textView.clipsToBounds = YES;
    [self.view addSubview:textView];
    
    self.textField = [WNController createTextFieldWithFrame:CGRectMake(10, 0, kViewWidth-40, 36) boreStyle:UITextBorderStyleNone font:15];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    self.textField.placeholder = @"请输入关键字";
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [textView addSubview:self.textField];
    
    self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(textView.frame) + 10,kViewWidth,45)];
    self.segmentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = kViewWidth/4;
    CGFloat btnHeight = 44;
    
    //底部下滑红线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, (btnHeight-2), (btnWidth-20), 2)];
    line.tag = 200;
    line.backgroundColor = [UIColor redColor];
    [self.segmentView addSubview:line];
    
    NSArray *titleArray = @[@"地区",@"时间",@"类型",@"价格"];
    
    for (int i = 0; i<titleArray.count; i++) {
        
        CGRect btnFrame = CGRectMake(i*btnWidth, 0, btnWidth, btnHeight);
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentBtn setFrame:btnFrame];
        segmentBtn.tag = BTN_START_TAG + i;
        segmentBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [segmentBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [segmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segmentBtn addTarget:self action:@selector(changeScreenCondiction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            self.selectedBtn = segmentBtn;
        }
        if (1== i) {
            self.tempButton = segmentBtn;
        }
        
        [self.segmentView addSubview:segmentBtn];
    }
    
    ///给第二个
    [self.view addSubview:self.segmentView];
    
    
    
    
    [self createInputeView];
}

/**
 *  重新设置TableView的frame，输入备注框的frame
 */
- (void)resetTbViewAndInputViewFrame
{
    self.mainTableView.frame =  CGRectMake(0,91 + 10+55, kViewWidth, kViewHeight-44-101-55);
    self.textView.frame = CGRectMake(20, CGRectGetMaxY(self.segmentView.frame)+10+60, kViewWidth-40, 180);
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    btn.frame = CGRectMake(20,CGRectGetMaxY(self.textView.frame)+10,kViewWidth-40, 40);
}

#pragma mark - 创建备注输入框
- (void)createInputeView
{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.segmentView.frame)+10, kViewWidth-40, 180)];
    self.textView.maskView.clipsToBounds = YES;
    self.textView.layer.cornerRadius = 8.0f;
    self.textView.font = DefaultFont;
    self.textView.text = DEFAULT_PLACEHOLD;
    self.textView.textColor = PLACEHOLD_COLOR;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    UIButton *comfirmBtn = [DeliveryUtility createBtnFrame:CGRectMake(20,CGRectGetMaxY(self.textView.frame)+10,kViewWidth-40, 40) title:@"确定" andFont:[UIFont systemFontOfSize:17.0f] target:self action:@selector(comfirmPublishRentRquest)];
    comfirmBtn.tag = 1000;
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    [comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [self.view addSubview:comfirmBtn];
}


#pragma mark - 切换筛选条件
- (void)changeScreenCondiction:(UIButton *)btn
{
    [self lightRentKeyBoardDown];
    _chooseIndex = btn.tag -100;
    [self.selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectedBtn = btn;
    [self.selectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //设置gps定位的view
    if(_chooseIndex==0)
    {
        [self addHeaderView];
    }
    else
    {
        [self dismissHeadView];
    }
    
    if (_chooseIndex == 1) {
        
        [self.mainTableView removeFromSuperview];
        
        [self.tempButton setTitle:@"" forState:UIControlStateNormal];
        [self.segmentView addSubview:self.timeSelectView];
        
        if (self.clickDatePickCount == 1) {
            //添加时间选择器
            [self createTimeSelectView];
        }
        self.clickDatePickCount++;
    }
    else
    {
        self.historyCityArray = [NSMutableArray arrayWithArray:[NSUserManager readNSUserDefaultsAndKey:@"rentHistoryCity"]];
        self.historyCityIDArray = [NSMutableArray arrayWithArray:[NSUserManager readNSUserDefaultsAndKey:@"rentHistoryCityID"]];
        
        if (self.historyCityArray.count>0) {
            [self loadCityData];
        }
        
        [self.view addSubview:self.mainTableView];
        
        
        [self.tempButton setTitle:@"时间" forState:UIControlStateNormal];
        [self.timeSelectView removeFromSuperview];
        [self.customPickView removeFromSuperview];
        self.clickDatePickCount = 1;
    }
    
    
    UIView *line = (UIView *)[btn.superview viewWithTag:200];
    [UIView animateWithDuration:0.3 animations:^{
       
        CGRect lineFrame = line.frame;
        lineFrame.origin.x = (kViewWidth/4)*_chooseIndex + 10;
        line.frame = lineFrame;
    }];
    
    NSLog(@"选中的筛选条件 --> %zd",self.chooseIndex);
    [self.mainTableView reloadData];
}


#pragma mark - 回收键盘
- (void)lightRentKeyBoardDown
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
    [self.textField resignFirstResponder];
}

#pragma mark - 确定发布闪电租需求
- (void)comfirmPublishRentRquest
{
#warning 这边确定发布闪电租
#warning 这边确定发布闪电租
#warning 这边确定发布闪电租
    
    
    NSLog(@"确定发布闪电租需求");
    [self.view endEditing:YES];
    //移除键盘的时候弹出框的问题
    [self performSelector:@selector(waittingEdting) withObject:nil afterDelay:0.5];
}

- (void)waittingEdting
{
    if ([self checkRentInfomationValid]) {
        
        self.lightRentPubView = [[[NSBundle mainBundle] loadNibNamed:@"LightRentPublishView" owner:self options:nil] lastObject];
        [self.lightRentPubView.publishButton addTarget:self action:@selector(publishButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.lightRentPubView.keyWordsLabel.text = [NSString stringWithFormat:@"关键字：%@",_rentModel.keyWord];
        self.lightRentPubView.areaLabel.text = [NSString stringWithFormat:@"地区：%@",self.selectedCity];
        
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"YYYY/MM/dd "];
        
        self.lightRentPubView.startTimelabel.text = [NSString stringWithFormat:@"时间：%@起",[format stringFromDate:self.startDate]];
        
        self.lightRentPubView.endTimeLabel.text = [NSString stringWithFormat:@"%@止",[format stringFromDate:self.endDate]];
        
        self.lightRentPubView.typeLabel.text = [NSString stringWithFormat:@"类型：%@",self.rentModel.type];
        self.lightRentPubView.priceLabel.text = [NSString stringWithFormat:@"价格：%@",self.rentModel.price];
        self.lightRentPubView.noteLabel.text = [NSString stringWithFormat:@"%@",self.rentModel.remarks];
        
        [self.lightRentPubView show];
        
        
    }

}

#pragma mark - 发布闪电租
- (void)publishButtonAction
{
    [self.view endEditing:YES];
    [self.mainTableView endEditing:YES];
    [self.textField resignFirstResponder];
    
    [self.lightRentPubView myRemove];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在发布";
    [HUD show:YES];
    
    HHNSLog(@"requestDict %@",self.requestDict);

    #warning 缺少发布接口 
    #warning 缺少发布接口 
    #warning 返回推送成功页面
    
    //
    [self performSelector:@selector(lightRentGoback) withObject:nil afterDelay:0.25];
    [MovieHttpRequest createMakeMineLightingRentWithRequestInfo:self.requestDict CallBack:^(id obj) {
        
        HUD.labelText = @"发布成功";
        [HUD hide:YES];
        
        [self.view makeToast:@"发布成功"];
        [self performSelector:@selector(lightRentGoback) withObject:nil afterDelay:0.25];
        
    } andSCallBack:^(id obj) {
        
        [DeliveryUtility showMessage:obj target:self];
        [HUD hide:YES];
    }];
}

- (NSString *)PriceList:(NSString *)priceID
{
    NSUInteger pri = [priceID integerValue];
    switch (pri) {
        case 7:
            return @"1000以下";
            break;
        case 8:
            return @"1000~5000";
            break;
        case 9:
            return @"5000~15000";
            break;
        case 10:
            return @"15000~30000";
            break;
        case 11:
            return @"30000以上";
            break;
        case 0:
            return @"不限";
            break;
        default:
            break;
    }
    return @"0000";
}

- (NSString *)cateList:(NSString *)cateID
{
    NSUInteger pri = [cateID integerValue];
    switch (pri) {
        case 3:
            return @"场地";
            break;
        case 2:
            return @"人员";
            break;
        case 1:
            return @"产品";
            break;
        case 0:
            return @"不限";
            break;
        default:
            break;
    }
    return @"不限";
}

- (void)lightRentGoback
{
    PushSuccessViewController *pushVc = [[PushSuccessViewController alloc] init];
    [self.navigationController pushViewController:pushVc animated:YES];
}



/**
 * 发布闪电租接口
 * 需要post(user_id用户id,keyword关键词,city_id城市id,cate_id类型id,price_id价格id,time_str时间字符串,remark备注);
 * 返回 (返回f1失败,f99成功,msg是提示信息;rent_id闪电租id)
 */
- (BOOL)checkRentInfomationValid
{
    NSString *keyword = [self.textField.text asTrim];
    NSString *cityId = [self.cityButton.titleLabel.text asTrim];
    NSString *catalague = [self.rentTypeButton.titleLabel.text asTrim];
    NSString *priceId = [self.rentPriceButton.titleLabel.text asTrim];
    NSString *timeStr = [NSString stringWithFormat:@"%@起\n%@止", self.customPickView.startTimeLabel.text,self.customPickView.endTimeLabel.text];
    NSString *remark = [self.textView.text asTrim];
    
    self.rentModel.keyWord = keyword;
    self.rentModel.address = cityId;
    self.rentModel.times = timeStr;
    self.rentModel.type = catalague;
    self.rentModel.price = priceId;
    self.rentModel.remarks = remark;
    //判断关键字
    if ([keyword isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请输入关键字" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:keyword]){
        [DeliveryUtility showMessage:@"关键字不可包含非法字符" target:self];
        return NO;
    }
    
    //判断城市
    if (!cityId || ![DeliveryUtility nullString:cityId]) {
        [DeliveryUtility showMessage:@"请选择租用地址" target:self];
        return NO;
    }
    
    //判断类型
    if (!catalague || ![DeliveryUtility nullString:catalague]) {
        [DeliveryUtility showMessage:@"请选择租用物品类型" target:self];
        return NO;
    }
    
    //判断价格
    if (!priceId || ![DeliveryUtility nullString:priceId]) {
        [DeliveryUtility showMessage:@"请选择价格区间" target:self];
        return NO;
    }
    
    //判断时间
    if (!timeStr || ![DeliveryUtility nullString:timeStr]) {
        [DeliveryUtility showMessage:@"请选择租用时间" target:self];
        return NO;
    }
    
    //判断备注信息
    if ([remark isEqualToString:@""]) {
        [DeliveryUtility showMessage:@"请填写备注信息" target:self];
        return NO;
    }
    if (remark.length<5)
    {
        [DeliveryUtility showMessage:@"备注信息不能少于5个字哦" target:self];
        return NO;
    }
    
    [self.requestDict setObject:keyword forKey:@"keyword"];
    [self.requestDict setObject:remark forKey:@"remark"];
    
    return YES;
}
/**
 *  获取价格区间
 */
- (void)requestPriceAndCatelogueDatas
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
    [MovieHttpRequest createLightingRentViewDatasCallBack:^(id obj) {
        
        NSDictionary *resultDict = (NSDictionary *)obj;
        self.priceArray = [NSArray arrayWithArray:resultDict[@"price"]];
        self.typeArray = [NSArray arrayWithArray:resultDict[@"catalogue"]];
        
        HUD.labelText = @"加载完成";
        [HUD hide:YES];
        
    } andSCallBack:^(id obj) {
        
        [HUD hide:YES];
        [DeliveryUtility showMessage:obj target:self];
    }];
}

#pragma mark 添加时间选择器
- (void)createTimeSelectView
{
   
    self.customPickView = [[[NSBundle mainBundle] loadNibNamed:@"CustomDatePickView" owner:self options:nil]lastObject];
    self.customPickView.backgroundColor = [UIColor whiteColor];
    self.customPickView.frame = CGRectMake(0, 112, kViewWidth, 254);
    //    self.customPickView.datePickView.datePickerMode
    if (self.mainTableView.frame.origin.y == 156) {
        self.customPickView.frame = CGRectMake(0, 112+45, kViewWidth, 254);;
    }
   
    [self.view addSubview:self.customPickView];
    

    
    
    
    ///自动登录
    
    
    self.dateTimeType = @"0";
    
    //把开始的时间格式变一下
    NSDate *myDate = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    NSDateFormatter *ymd =[[NSDateFormatter alloc] init];
    [ymd setDateFormat:@"yyyy-MM-dd"];
    [fm setDateFormat:@"yy-MM-dd HH:mm:00"];
    NSString *curDateStr = [fm stringFromDate:myDate];
    NSDate *curDate = [fm dateFromString:curDateStr];
    self.customPickView.datePickView.minimumDate = curDate;
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ch"];
    [self.customPickView.datePickView setLocale:[NSLocale currentLocale]];
    
    
    self.customPickView.datePickView.datePickerMode = UIDatePickerModeDate;
    //设置起始时间label为当前时间
    self.customPickView.startTimeLabel.text = [ymd stringFromDate:myDate];
    self.startDate = myDate;
    ////设置时间的方法
    [self.customPickView.datePickView addTarget:self action:@selector(datePickViewAction:) forControlEvents:UIControlEventValueChanged];
    //设置成中文年月
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.customPickView.datePickView.locale =locale;
    
    [self.customPickView.startTimeButton addTarget:self action:@selector(startTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.customPickView.endTimeButton addTarget:self action:@selector(endTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    ///保存
    [self.customPickView.saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 保存起止时间
- (void)saveButtonAction
{
    ///判断起止时间是否有无
    if ([self.customPickView.startTimeLabel.text isEqualToString:@""]||[self.customPickView.endTimeLabel.text isEqualToString:@""]) {
        
//        [PromptLabel custemAlertPromAddView:self.view text:@"请选择起止时间"];
        
    }else
    {
        self.timeSelectView.qiLabel.text = [NSString stringWithFormat:@"起%@",self.customPickView.startTimeLabel.text];
        self.timeSelectView.zhiLabel.text =  [NSString stringWithFormat:@"止%@",self.customPickView.endTimeLabel.text];
        
        NSString *timeStr = [NSString stringWithFormat:@"%@,%@",self.customPickView.startTimeLabel.text,self.customPickView.endTimeLabel.text];
        
        
        ///设置时间参数
        [self.requestDict setObject:timeStr forKey:@"time_str"];
        [self.tempButton setTitle:@"" forState:UIControlStateNormal];
        
        
        UILabel *qiLabel  = [WNController createLabelWithFrame:CGRectMake(0, 0, kViewWidth/4, 12) Font:10 Text:@"起" textAligment:NSTextAlignmentCenter];
        qiLabel.backgroundColor = [UIColor clearColor];
        
        UILabel *zhiLabel = [WNController createLabelWithFrame:CGRectMake(0, 15, kViewWidth/4, 12) Font:10 Text:@"止" textAligment:NSTextAlignmentCenter];
        zhiLabel.backgroundColor = [UIColor clearColor];
        
        qiLabel.textColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1];
        zhiLabel.textColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1];
        
        if (!self.timesButton) {
            self.timesButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:@"" fontSize:13];
            self.timesButton.backgroundColor = btnBgColor;
            self.timesButton.layer.cornerRadius = 5;
            self.timesButton.layer.masksToBounds = YES;
            
           
            
            [self.timesButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
            [self.view addSubview:self.timesButton];
            
            [self.timesButton addSubview:qiLabel];
            [self.timesButton addSubview:zhiLabel];
            
            qiLabel.text = [NSString stringWithFormat:@"起%@",self.customPickView.startTimeLabel.text];
            zhiLabel.text = [NSString stringWithFormat:@"止%@",self.customPickView.endTimeLabel.text];
            self.btnframeindex++;
        }else
        {
            for (UIView *mView in self.timesButton.subviews) {
                [mView removeFromSuperview];
            }
            
            [self.timesButton addSubview:qiLabel];
            [self.timesButton addSubview:zhiLabel];
            
            qiLabel.text = [NSString stringWithFormat:@"起%@",self.customPickView.startTimeLabel.text];
            zhiLabel.text = [NSString stringWithFormat:@"止%@",self.customPickView.endTimeLabel.text];
        }
        
        //增加按钮方法
        [self.timesButton setBackgroundImage:[UIImage imageNamed:@"tag_s"] forState:UIControlStateSelected];
        [self.timesButton addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.timesButton.tag = 301;
        
        [self.customPickView removeFromSuperview];
        self.clickDatePickCount = 1;
        
        [self resetTbViewAndInputViewFrame];
        
    }
}
/**
 *  选择条件的按钮
 *
 *  @param btn 按钮对象
 */
-(void)actionSelect:(UIButton *)btn
{
    btn.selected = !btn.selected;

    
    UIButton *button = (UIButton *)[btn viewWithTag:btn.tag-200];
    if(button ==nil)
    {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kViewWidth/4-15, 0, 15, 30)];
        [btn addSubview:button];
        [button addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = btn.tag-200;
    }
    else
    {
        if(btn.selected ==NO)
        {
            button .hidden = YES;
        }
        else
        {
            button.hidden = NO;
        }

    }
        
    
}
/**
 *  删除按钮
 *
 *  @param btn 按钮对象
 */
-(void)actionCancel:(UIButton *)btn
{
    UIButton *button = (UIButton *)[self.view viewWithTag:btn.tag+200];
    if(self.cityButton==button)
    {
        [self changeButtonFrame:self.cityButton];
        [self.cityButton removeFromSuperview];
        self.cityButton = nil;
        self.btnframeindex--;
        
    }
    if(self.timesButton==button)
    {
        [self changeButtonFrame:self.timesButton];
        [self.timesButton removeFromSuperview];
        self.timesButton = nil;
        self.btnframeindex--;
        
    }

    if(self.rentTypeButton==button)
    {
        [self changeButtonFrame:self.rentTypeButton];
        [self.rentTypeButton removeFromSuperview];
        self.rentTypeButton = nil;
        self.btnframeindex--;
        
    }

    if(self.rentPriceButton==button)
    {
        
        [self changeButtonFrame:self.rentPriceButton];
        [self.rentPriceButton removeFromSuperview];
        self.rentPriceButton = nil;
        self.btnframeindex--;
    }

    
    NSLog(@"取消");
}
/**
 *  刷新button的frame
 *
 *  @param btn 选中的按钮
 */
-(void)changeButtonFrame:(UIButton *)btn
{
    //CGRect btnRect = btn.frame;
    if(self.cityButton)
    {
        
        CGRect rect = self.cityButton.frame;
        if(rect.origin.x>btn.frame.origin.x)
        {
            self.cityButton.frame = CGRectMake(rect.origin.x-kViewWidth/4, 114,kViewWidth/4-5, 30);
        }
    }
    if(self.timesButton)
    {
        
        CGRect rect = self.timesButton.frame;
        if(rect.origin.x>btn.frame.origin.x)
        {
            self.timesButton.frame = CGRectMake(rect.origin.x-kViewWidth/4, 114,kViewWidth/4-5, 30);
        }
    }

    if(self.rentTypeButton)
    {
        CGRect rect = self.rentTypeButton.frame;
        if(rect.origin.x>btn.frame.origin.x)
        {
            self.rentTypeButton.frame = CGRectMake(rect.origin.x-kViewWidth/4, 114,kViewWidth/4-5, 30);
        }
    }

    if(self.rentPriceButton)
    {
        CGRect rect = self.rentPriceButton.frame;
        if(rect.origin.x>btn.frame.origin.x)
        {
            self.rentPriceButton.frame = CGRectMake(rect.origin.x-kViewWidth/4, 114,kViewWidth/4-5, 30);
        }
    }

    
}
#pragma mark - 时间选择器
- (void)datePickViewAction:(UIDatePicker *)pick
{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    pick.minimumDate = [NSDate date];
    [format setDateFormat:@"YYYY-MM-dd"];
    ///时间显示
    NSString *dateStr = [format stringFromDate:pick.date];
    if ([self.dateTimeType isEqualToString:@"0"]) {
        
        self.startDate = pick.date;
        self.customPickView.startTimeLabel.text = dateStr;
        
        //判断起始时间是否大于结束时间
        NSComparisonResult result = [self.startDate compare:self.endDate];
        if(result ==NSOrderedDescending)
        {
            NSLog(@"Date1  is in the future");
            self.endDate = self.startDate;
            self.customPickView.endTimeLabel.text = dateStr;

        }

    }else
    {
        pick.minimumDate = self.startDate;
        self.endDate = pick.date;
        self.customPickView.endTimeLabel.text = dateStr;
    }
    NSLog(@"startDate:%@ \\d endDate:%@",self.startDate,self.endDate);
}

#pragma mark - startTimeButtonAction
- (void)startTimeButtonAction
{
    self.dateTimeType = @"0";
    self.customPickView.datePickView.minimumDate = [NSDate date];
    self.customPickView.qilabel.textColor = [UIColor redColor];
    self.customPickView.zhiLabel.textColor = [UIColor blackColor];
    self.customPickView.startTimeLabel.textColor = [UIColor redColor];
    self.customPickView.endTimeLabel.textColor = [UIColor blackColor];
}

#pragma mark - endTimeButtonAction
- (void)endTimeButtonAction
{
    self.dateTimeType = @"1";
    self.customPickView.datePickView.minimumDate = self.startDate;
    self.customPickView.qilabel.textColor = [UIColor blackColor];
    self.customPickView.zhiLabel.textColor = [UIColor redColor];
    self.customPickView.startTimeLabel.textColor = [UIColor blackColor];
    self.customPickView.endTimeLabel.textColor = [UIColor redColor];
}




#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.chooseIndex == 0) {
        if (self.cityArray.count>0) {
            ///返回多少组
            return self.cityArray.count;
        }
        return 0;
    }else{
        self.textField.placeholder = @"请输入关键词";
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *citySection = [NSArray array];
    if (self.cityArray.count>0) {
        citySection = self.cityArray[section];
    }
    NSInteger arrayCount = 0;
    switch (self.chooseIndex) {
        case 0: //地区
            if (self.historyCityArray.count>0)
            {
                arrayCount = (section==0)||(section==1)?1:citySection.count;
            }else
            {
                arrayCount = section==0?1:citySection.count;
            }
            break;
        case 1: //时间
            arrayCount = 1;
            break;
        case 2: //类型
            arrayCount = self.typeArray.count;
            break;
        case 3: //价格
            arrayCount = self.priceArray.count;
            break;
        default:
            break;
    };
    
    return arrayCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == self.chooseIndex) {
        
        ////历史搜索记录
        if (self.historyCityArray.count>0)
        {
            if (indexPath.section==0)
            {
                static NSString *cellID = @"historyCityCell1";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                CGFloat btnWidth = (kViewWidth-40)/3;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                }
                
                
                for (int i = 0; i<self.historyCityArray.count; i++) {
                    
                    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(10+(10*(i%3))+btnWidth*(i%3), 10+(36*(i/3))+((i/3)*10), btnWidth, 36) ImageName:@"" Target:self Action:@selector(historyCityAction:) Title:self.historyCityArray[i] fontSize:NormalFont];
                    btn.tag = 100+i;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [cell addSubview:btn];
                    
                }
                
                cell.backgroundColor = kViewBackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //        cell.textLabel.font = [UIFont systemFontOfSize:16];
                //        cell.textLabel.text = @"金贝DII-250W摄影灯摄影棚";
                return cell;
                
            }else if(indexPath.section == 1)
            {
                static NSString *cellID = @"RentChooseCityCell1";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                CGFloat btnWidth = (kViewWidth-40)/3;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                }
                
                
                for (int i = 0; i<self.arrayHotCity.count; i++) {
                    CityModel *cityModel = self.arrayHotCity[i];
                    
                    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(10+(10*(i%3))+btnWidth*(i%3), 10+(36*(i/3))+((i/3)*10), btnWidth, 36) ImageName:@"" Target:self Action:@selector(hotCityAction:) Title:cityModel.cityName fontSize:NormalFont];
                    btn.tag = 100+i;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [cell addSubview:btn];
                    
                }
                
                cell.backgroundColor = kViewBackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //        cell.textLabel.font = [UIFont systemFontOfSize:16];
                //        cell.textLabel.text = @"金贝DII-250W摄影灯摄影棚";
                return cell;
                
            }else
            {
                //地区选择
                MovieDefaultTableViewCell *cell = [MovieDefaultTableViewCell cellWithTableView:tableView];
                ///设置城市显示
                NSArray *selectCityArr = self.cityArray[indexPath.section];
                CityModel *model = selectCityArr[indexPath.row];
                
                [cell setMainContent:model.cityName];
                
                return cell;
            }
            
        }else
        {
            if (indexPath.section==0)
            {
                static NSString *cellID = @"RentChooseCityCell1";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                CGFloat btnWidth = (kViewWidth-40)/3;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                }
                
                
                for (int i = 0; i<self.arrayHotCity.count; i++) {
                    CityModel *cityModel = self.arrayHotCity[i];
                    
                    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(10+(10*(i%3))+btnWidth*(i%3), 10+(36*(i/3))+((i/3)*10), btnWidth, 36) ImageName:@"" Target:self Action:@selector(hotCityAction:) Title:cityModel.cityName fontSize:NormalFont];
                    btn.tag = 100+i;
                    btn.backgroundColor = [UIColor whiteColor];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [cell addSubview:btn];
                    
                }
                
                cell.backgroundColor = kViewBackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //        cell.textLabel.font = [UIFont systemFontOfSize:16];
                //        cell.textLabel.text = @"金贝DII-250W摄影灯摄影棚";
                return cell;
                
            }else
            {
                //地区选择
                MovieDefaultTableViewCell *cell = [MovieDefaultTableViewCell cellWithTableView:tableView];
                ///设置城市显示
                NSArray *selectCityArr = self.cityArray[indexPath.section];
                CityModel *model = selectCityArr[indexPath.row];
                
                [cell setMainContent:model.cityName];
                
                return cell;
            }
        
        }
    }
    else if(1 == self.chooseIndex)
    {
        //时间选择
        MovieDefaultTableViewCell *cell = [MovieDefaultTableViewCell cellWithTableView:tableView];
        
//        //添加时间选择器
//        [self createTimeSelectView];
        
        return cell;
    }
    else
    {
        
        MovieDefaultTableViewCell *cell = [MovieDefaultTableViewCell cellWithTableView:tableView];
//        MovieLightRentSimpleModel *model = (self.chooseIndex==2)?self.typeArray[indexPath.row]:self.priceArray[indexPath.row];
        
        NSString * showStr = (self.chooseIndex==2)?self.typeArray[indexPath.row]:self.priceArray[indexPath.row];
        
//        [cell setMainContent:model.name];
        [cell setMainContent:showStr];
        
        return cell;
    }

    return nil;
}

#pragma mark - 历史访问
- (void)historyCityAction:(UIButton *)historybtn
{
    [self.customPickView removeFromSuperview];
    [self.mainTableView removeFromSuperview];
    ///重设frame
    [self resetTbViewAndInputViewFrame];
    
    self.selectedCity = self.historyCityArray[historybtn.tag-100];
    [self.requestDict setObject:self.historyCityIDArray[historybtn.tag-100] forKey:@"city_id"];
    
    if (!self.cityButton) {
        self.cityButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:self.historyCityArray[historybtn.tag-100] fontSize:13];
        self.cityButton.backgroundColor = btnBgColor;
        self.cityButton.layer.cornerRadius = 5;
        self.cityButton.layer.masksToBounds = YES;
        [self.cityButton setBackgroundImage:[UIImage imageNamed:@"tag_s"] forState:UIControlStateSelected];
        [self.cityButton addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.cityButton.tag = 300;
        [self.cityButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
        [self.view addSubview:self.cityButton];
        self.btnframeindex++;
    }else
    {
        [self.cityButton setTitle:self.historyCityArray[historybtn.tag-100] forState:UIControlStateNormal];
    }

    
}

#pragma mark - 热门城市
- (void)hotCityAction:(UIButton *)hotCity
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rentHistoryCity"];
    
    [self.customPickView removeFromSuperview];
    [self.mainTableView removeFromSuperview];
    ///重设frame
    [self resetTbViewAndInputViewFrame];
    
    CityModel *cityModel = self.arrayHotCity[hotCity.tag-100];
    self.selectedCity = cityModel.cityName;
    [NSUserManager SetSearchText:cityModel.cityName andKey:@"rentHistoryCity"];
    [NSUserManager SetSearchText:cityModel.cityId andKey:@"rentHistoryCityID"];
    NSLog(@"地址选择 --> %@",cityModel.cityId);
    [self.requestDict setObject:cityModel.cityId forKey:@"city_id"];
    
    if (!self.cityButton) {
        self.cityButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:cityModel.cityName fontSize:13];
        self.cityButton.backgroundColor = btnBgColor;
        self.cityButton.layer.cornerRadius = 5;
        self.cityButton.layer.masksToBounds = YES;
        [self.cityButton setBackgroundImage:[UIImage imageNamed:@"tag_s"] forState:UIControlStateSelected];
        [self.cityButton addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.cityButton.tag = 300;
        [self.cityButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
        [self.view addSubview:self.cityButton];
        self.btnframeindex++;
    }else
    {
        [self.cityButton setTitle:cityModel.cityName forState:UIControlStateNormal];
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
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.historyCityArray.count>0) {
        if (0 == self.chooseIndex) {
            if (indexPath.section == 0) {
                
                CGFloat hotWord = 0.0f;
                for (int i = 0; i<self.historyCityArray.count; i++)
                {
                    hotWord = 10+(36*(i/3))+((i/3)*10);
                }
                //        return 200;
                return hotWord+10+36;
            }
            
            if (indexPath.section == 1) {
                
                CGFloat hotWord = 0.0f;
                for (int i = 0; i<self.arrayHotCity.count; i++)
                {
                    hotWord = 10+(36*(i/3))+((i/3)*10);
                }
                //        return 200;
                return hotWord+10+36;
            }
            
        }
    }else
    {
        if (0 == self.chooseIndex) {
            if (indexPath.section == 0) {
                
                CGFloat hotWord = 0.0f;
                for (int i = 0; i<self.arrayHotCity.count; i++)
                {
                    hotWord = 10+(36*(i/3))+((i/3)*10);
                }
                //        return 200;
                return hotWord+10+36;
            }
        }
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (1==self.chooseIndex) {
        return 254;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 != self.chooseIndex) {
        return 0.1;
    }
    return 30;
}


//索引目录
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return (0 == self.chooseIndex)?self.suoyinArray:nil;
}

//头部的View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0==self.chooseIndex) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 30)];
        bgView.backgroundColor=kViewBackColor;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
        titleLabel.font = [UIFont systemFontOfSize:NormalFont];
        
        
        if (self.historyCityArray.count>0) {
            ///设置第一行
            if (section == 0) {
                titleLabel.text = @"历史访问";
            }else if (section == 1) {
                titleLabel.text = @"热门城市";
            }else
            {
                NSString *key = [self.suoyinArray objectAtIndex:section];
                titleLabel.text = key;
            }
            
        }else
        {
            ///设置第一行
            if (section == 0) {
                titleLabel.text = @"热门城市";
            }else
            {
                NSString *key = [self.suoyinArray objectAtIndex:section];
                titleLabel.text = key;
            }
        }
        [bgView addSubview:titleLabel];
        return bgView;
    }else
    {
        UIView *view = [[UIView alloc] init];
        return view;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        [self.customPickView removeFromSuperview];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.mainTableView removeFromSuperview];
        
        ///重设frame
        [self resetTbViewAndInputViewFrame];
        
        
        switch (self.chooseIndex) {
            case 2: //类型
            {
//                MovieLightRentSimpleModel *model = _typeArray[indexPath.row];
                
                NSString * modelStr = self.typeArray[indexPath.row];
                
//                NSString *catalogueId = model.infoId;
//                [self.requestDict setObject:catalogueId forKey:@"cate_id"];
              
                
                if (!self.rentTypeButton) {
                    self.rentTypeButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:modelStr fontSize:13];
                    self.rentTypeButton.backgroundColor = btnBgColor;
                    self.rentTypeButton.layer.cornerRadius = 5;
                    self.rentTypeButton.layer.masksToBounds = YES;
                    
                    [self.rentTypeButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
                    [self.view addSubview:self.rentTypeButton];
                    self.btnframeindex++;
                }else
                {
                    [self.rentTypeButton setTitle:modelStr forState:UIControlStateNormal];
                }
                
            }
                break;
            case 3: //价格
            {
//                MovieLightRentSimpleModel *model = _priceArray[indexPath.row];
//                NSString *priceId = model.infoId;
//                [self.requestDict setObject:priceId forKey:@"price_id"];
                
                NSString * priceStr = self.priceArray[indexPath.row];
                
                if (!self.rentPriceButton) {
                    self.rentPriceButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:priceStr fontSize:13];
                    self.rentPriceButton.titleLabel.numberOfLines = 0;
                    self.rentPriceButton.backgroundColor = btnBgColor;
                    self.rentPriceButton.layer.cornerRadius = 5;
                    self.rentPriceButton.layer.masksToBounds = YES;
                    
                    [self.rentPriceButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
                    [self.view addSubview:self.rentPriceButton];
                    self.rentPriceButton.tag = 303;
                    self.btnframeindex++;
                }else
                {
                    [self.rentPriceButton setTitle:priceStr forState:UIControlStateNormal];
                }
                
            }
                break;
            default:
                break;
        }
    }else
    {
        [self.customPickView removeFromSuperview];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.mainTableView removeFromSuperview];
        
        ///重设frame
        [self resetTbViewAndInputViewFrame];
        
        
        switch (self.chooseIndex) {
            case 0: //地区
            {
                ///设置城市显示
                NSArray *selectCityArr = self.cityArray[indexPath.section];
                CityModel *model = selectCityArr[indexPath.row];
                ////设置选中的城市名称
                self.selectedCity = model.cityName;
                
                ///记录搜索历史
                [NSUserManager SetSearchText:model.cityName andKey:@"rentHistoryCity"];
                [NSUserManager SetSearchText:model.cityId andKey:@"rentHistoryCityID"];
                
                if (!self.cityButton) {
                    self.cityButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:model.cityName fontSize:13];
                    self.cityButton.backgroundColor = btnBgColor;
                    self.cityButton.layer.cornerRadius = 5;
                    self.cityButton.layer.masksToBounds = YES;
                    
                    [self.cityButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
                    [self.view addSubview:self.cityButton];
                    self.btnframeindex++;
                }else
                {
                    [self.cityButton setTitle:model.cityName forState:UIControlStateNormal];
                }
                
                
                [self.requestDict setObject:model.cityId forKey:@"city_name"];
            }
                break;
            case 1: //时间选择
            {
                //            NSString *timeStr = @"2013.10.02";
                //            [self.requestDict setObject:timeStr forKey:@"time_str"];
            }
                break;
            case 2: //类型
            {
                MovieLightRentSimpleModel *model = _typeArray[indexPath.row];
                NSString *catalogueId = model.infoId;
                [self.requestDict setObject:catalogueId forKey:@"cate_id"];
                
                
                if (!self.rentTypeButton) {
                    self.rentTypeButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:model.name fontSize:13];
                    self.rentTypeButton.backgroundColor = btnBgColor;
                    self.rentTypeButton.layer.cornerRadius = 5;
                    self.rentTypeButton.layer.masksToBounds = YES;
                    
                    [self.rentTypeButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
                    [self.view addSubview:self.rentTypeButton];
                    self.btnframeindex++;
                }else
                {
                    [self.rentTypeButton setTitle:model.name forState:UIControlStateNormal];
                }
                
            }
                break;
            case 3: //价格
            {
                MovieLightRentSimpleModel *model = _priceArray[indexPath.row];
                NSString *priceId = model.infoId;
                [self.requestDict setObject:priceId forKey:@"price_id"];
                
                if (!self.rentPriceButton) {
                    self.rentPriceButton = [WNController createButtonWithFrame:CGRectMake((kViewWidth/4)*self.btnframeindex+5, 114, kViewWidth/4-5, 30) ImageName:@"" Target:nil Action:nil Title:model.name fontSize:13];
                    self.rentPriceButton.titleLabel.numberOfLines = 0;
                    self.rentPriceButton.backgroundColor = btnBgColor;
                    self.rentPriceButton.layer.cornerRadius = 5;
                    self.rentPriceButton.layer.masksToBounds = YES;
                    
                    [self.rentPriceButton setTitleColor:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1] forState:UIControlStateNormal];
                    [self.view addSubview:self.rentPriceButton];
                    self.btnframeindex++;
                }else
                {
                    [self.rentPriceButton setTitle:model.name forState:UIControlStateNormal];
                }
                
            }
                break;
            default:
                break;
        }
    }
    //增加删除功能
    
    //类型
    
    if(self.rentTypeButton)
    {
        [self.rentTypeButton setBackgroundImage:[UIImage imageNamed:@"tag_s"] forState:UIControlStateSelected];
        [self.rentTypeButton addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.rentTypeButton.tag =302;
    }
    //价格
    
    if(self.rentPriceButton)
    {
        [self.rentPriceButton setBackgroundImage:[UIImage imageNamed:@"tag_s"] forState:UIControlStateSelected];
        [self.rentPriceButton addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.rentPriceButton.tag = 303;
    }
    //城市
    
    if(self.cityButton)
    {
        [self.cityButton setBackgroundImage:[UIImage imageNamed:@"tag_s"] forState:UIControlStateSelected];
        [self.cityButton addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.cityButton.tag = 300;
    }
    
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:DEFAULT_PLACEHOLD]) {
        self.textView.text = @"";
        self.textView.textColor = TEXT_COLOR;
    }
    return YES;
}

#pragma mark - UItextView
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>100) {
        textView.text = [textView.text substringToIndex:100];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = [UIColor blackColor];
    //textView.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"详细地址"]||[textView.text isEqualToString:@""]) {
        textView.text = @"";
        textView.textColor = [UIColor lightGrayColor];
    }
}



#pragma mark - 监听键盘高度调用的方法
//其次键盘的高度计算：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}


//传入的(NSDictionary *)userInfo用于存放键盘的各种信息，其中UIKeyboardFrameEndUserInfoKey对应的存放键盘的尺寸信息，以CGRect形式取出。

//最终返回的是键盘在当前视图中的高度。
//然后，根据键盘高度将当前视图向上滚动同样高度。
-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    
    
    //先恢复原位 //可能这个方法重复调用
    currentFrame.origin.y = 64;
    self.view.frame = currentFrame;
    
//    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    
    
    if ([self.textView isFirstResponder])
    {
        currentFrame.origin.y = - 100+64;
        self.view.frame = currentFrame;
        NSLog(@"%@",NSStringFromCGRect(currentFrame));
    }
    
}
//最后，当键盘消失后，视图需要恢复原状。
-(void)keyboardWillDisappear:(NSNotification *)notification
{
    //恢复原位
    CGRect currentFrame = self.view.frame;
    currentFrame.origin.y = 64;
    self.view.frame = currentFrame;
    
}


//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:DEFAULT_PLACEHOLD]) {
//        self.textView.text = @"";
//    }
//    return YES;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self lightRentKeyBoardDown];
}

#pragma mark - text
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length>15) {
        textField.text= [textField.text substringToIndex:15];
    }
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
