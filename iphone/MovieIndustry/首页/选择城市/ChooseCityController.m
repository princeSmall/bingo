//
//  ChooseCityController.m
//  QuLiu
//
//  Created by Shining Chen on 15/9/28.
//  Copyright © 2015年 han. All rights reserved.
//

#import "ChooseCityController.h"
#import "HHLocationService.h"
#import "NSUserManager.h"
#import "CityModel.h"

@interface ChooseCityController() <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HHLocationServiceDelegate>
{
    ///定位城市
    UILabel *_cityLab;
}
@property(nonatomic,strong)UITableView *tableView;
////系统定位
@property (nonatomic,strong) HHLocationService *locationMana;

///索引目录
@property (nonatomic,strong) NSMutableArray *suoyinArray;
///城市数组
@property (nonatomic,strong) NSMutableArray *cityArray;
///热点城市
@property (nonatomic, strong) NSMutableArray *arrayHotCity;//热门城市
///搜索状态
@property (nonatomic,assign) BOOL isSearch;

//定位的时候在转动
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

//定位之后点击的按钮 开始状态为不可点击
@property (nonatomic,strong) UIButton *locationButton;
//定位之后的城市id
@property (nonatomic,copy) NSString *locationCityId;

///历史搜索的数组
@property (nonatomic,strong) NSMutableArray *historyCityArray;
////历史搜索的城市ID
@property (nonatomic,strong) NSMutableArray *historyCityIDArray;

@end

@implementation ChooseCityController

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


- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _indicatorView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavTabBar:@"选择城市"];
    
    self.isSearch = NO;
    
    [self creatTableView];
    
    _locationMana = [[HHLocationService alloc] init];
    _locationMana.delegate = self;
    [_locationMana openLocationService];
    
    self.navigationController.navigationBar.barTintColor=kNavBarColor;
    self.navigationController.navigationBar.translucent=NO;
    
    [self loadCityData:@""];
}

- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
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
    if ([self.isDismis isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 获取网络城市数据
- (void)loadCityData:(NSString *)cityID
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:cityID,@"name", nil];
    [HttpRequestServers requestBaseUrl:City_list withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        //        HHNSLog(@"-------->%@",dict);
        @try {
            
            if ([dict[@"status"] isEqualToString:@"f99"])
            {
                
                NSDictionary *currentDict = dict[@"current"];
                if (currentDict.count>0) {
                    self.locationButton.enabled = YES;
                    self.locationCityId = currentDict[@"id"];
                }
                
                [self.suoyinArray removeAllObjects];
                [self.cityArray removeAllObjects];
                [self.arrayHotCity removeAllObjects];
                
                if (self.historyCityArray.count>0) {
                    ///添加历史搜索
                    [self.cityArray addObject:self.historyCityArray];
                    [self.suoyinArray addObject:@""];
                }
                //不是搜索
                _isSearch = NO;
                
                ///添加索引的搜索按钮
                [self.suoyinArray addObject:UITableViewIndexSearch];
                ///热点城市
                for (NSDictionary *hotDcit in dict[@"hot_list"]) {
                    CityModel *hotCityModel = [[CityModel alloc] init];
                    hotCityModel.cityName = hotDcit[@"name"];
                    hotCityModel.cityId = hotDcit[@"id"];
                    [self.arrayHotCity addObject:hotCityModel];
                }
                ///将热点城市加到大数组里面
                [self.cityArray addObject:self.arrayHotCity];
                ///城市索引和城市列表表
                for (NSDictionary *listDict in dict[@"list"]) {
                    [self.suoyinArray addObject:listDict[@"u_name"]];
                    ///存储城市列表临时变量
                    NSMutableArray *cityInfoArray = [NSMutableArray array];
                    for (NSDictionary *infoDict  in listDict[@"info"]) {
                        CityModel *cityModel = [[CityModel alloc] init];
                        cityModel.cityName = infoDict[@"name"];
                        cityModel.cityId = infoDict[@"id"];
                        [cityInfoArray addObject:cityModel];
                    }
                    ///存储到数据数组
                    [self.cityArray addObject:cityInfoArray];
                }
                
                //                HHNSLog(@"hotarr %@, cityArr %@, suoyin%@",self.arrayHotCity,self.cityArray,self.suoyinArray);
                
                ///刷新数据
                if (self.historyCityArray.count>0){
                    CityModel * model = self.cityArray[23][1];
                    
                    NSMutableArray * cityArray1 = [NSMutableArray arrayWithArray:self.cityArray[23]];
                    [cityArray1 removeObject:model];
                    self.cityArray[23] = cityArray1;
                    NSMutableArray * cityArray2 = [NSMutableArray arrayWithArray:self.cityArray[4]];
                    [cityArray2 insertObject:model atIndex:0];
                    self.cityArray[4] = cityArray2;
                    
                }else{
                
                    CityModel * model = self.cityArray[22][1];
                    NSMutableArray * cityArray1 = [NSMutableArray arrayWithArray:self.cityArray[22]];
                    [cityArray1 removeObject:model];
                    self.cityArray[22] = cityArray1;
                    NSMutableArray * cityArray2 = [NSMutableArray arrayWithArray:self.cityArray[3]];
                    [cityArray2 insertObject:model atIndex:0];
                    self.cityArray[3] = cityArray2;
                
                }
                
                [self.tableView reloadData];
                [self.view endEditing:YES];
                
            }else
            {
                [DeliveryUtility showMessage:dict[@"msg"] target:nil];
                
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
        [DeliveryUtility showMessage:kNetWork_ERROR target:nil];
    }];
}


- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //设置索引目录的背景颜色
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    UIView *tbHeaderView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 97)];
    tbHeaderView.backgroundColor = kViewBackColor;
    
    
    //文本框的圆角背景View
    UIView *textView = [WNController createViewFrame:CGRectMake(10, 10, kViewWidth-20, 36)];
    textView.layer.cornerRadius = 16;
    textView.clipsToBounds = YES;
    [tbHeaderView addSubview:textView];
    
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(10, 0, kViewWidth-40, 36) boreStyle:UITextBorderStyleNone font:15];
    textField.backgroundColor = [UIColor whiteColor];
    //    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeySearch;
    textField.delegate = self;
    ///添加监听变化
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    textField.placeholder = @"请输入城市名查询";
    [textView addSubview:textField];
    
    
    ///城市的本地View
    UIView *locationView = [WNController createViewFrame:CGRectMake(0, 57, kViewWidth, 40)];
    UILabel *locationLabel =  [WNController createLabelWithFrame:CGRectMake(15, 0, 150, 40) Font:15 Text:@"" textAligment:NSTextAlignmentLeft];
    _cityLab = locationLabel;
    
    
    [locationView addSubview:locationLabel];
    
    UILabel *gpsLabel = [WNController createLabelWithFrame:CGRectMake(kViewWidth-100, 0, 90, 40) Font:13 Text:@"GPS定位" textAligment:NSTextAlignmentRight];
    gpsLabel.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    [locationView addSubview:gpsLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, kViewWidth, 40);
    [btn addTarget:self action:@selector(chooseLocationAction) forControlEvents:UIControlEventTouchUpInside];
    btn.enabled = NO;
    self.locationButton = btn;
    [locationView addSubview:btn];
    
    [self.indicatorView startAnimating];
    [locationView addSubview:self.indicatorView];
    
    //    UIActivity
    
    //
    [tbHeaderView addSubview:locationView];
    
    _tableView.tableHeaderView.frame = CGRectMake(0, 0, kViewWidth, 97);
    //设置tableView的头部视图
    _tableView.tableHeaderView = tbHeaderView;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
}

#pragma mark - 点击手机定位的View
- (void)chooseLocationAction
{
    if (!self.locationCityId) {
        self.locationCityId = @"";
    }
    
    [self.delegate cityName:_cityLab.text andCityId:self.locationCityId];
    if ([self.isDismis isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - tableView 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
///cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isSearch) {
        if (self.historyCityArray.count>0) {
            if (indexPath.section == 0) {
                
                CGFloat hotWord = 0.0f;
                for (int i = 0; i<self.historyCityArray.count; i++)
                {
                    hotWord = 10+(36*(i/3))+((i/3)*10);
                }
                //        return 200;
                return hotWord+10+36;
            }else
                if (indexPath.section == 1) {
                    
                    CGFloat hotWord = 0.0f;
                    for (int i = 0; i<self.arrayHotCity.count; i++)
                    {
                        hotWord = 10+(36*(i/3))+((i/3)*10);
                    }
                    //        return 200;
                    return hotWord+10+36;
                }else
                {
                    return 40;
                }
        }else
        {
            if (indexPath.section == 0) {
                
                CGFloat hotWord = 0.0f;
                for (int i = 0; i<self.arrayHotCity.count; i++)
                {
                    hotWord = 10+(36*(i/3))+((i/3)*10);
                }
                //        return 200;
                return hotWord+10+36;
            }else
            {
                return 40;
            }
        }
    }else
    {
        return 40;
    }
}

//头部的View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 30)];
    bgView.backgroundColor=kViewBackColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor=[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:NormalFont];
    
    if (self.historyCityArray.count>0) {
        if (!_isSearch) {
            if (section == 0) {
                titleLabel.text = @"历史访问";
            }else if (section == 1)
            {
                titleLabel.text = @"热门城市";
            }else
            {
                NSString *key = [self.suoyinArray objectAtIndex:section];
                titleLabel.text = key;
            }
        }else
        {
            if (section == 0)
            {
                titleLabel.text = @"搜索结果";
            }
            else
            {
                NSString *key = [self.suoyinArray objectAtIndex:section];
                titleLabel.text = key;
            }
        }
    }else
    {
        if (!_isSearch) {
            if (section == 0)
            {
                titleLabel.text = @"热门城市";
            }else
            {
                NSString *key = [self.suoyinArray objectAtIndex:section];
                titleLabel.text = key;
            }
        }else
        {
            if (section == 0)
            {
                titleLabel.text = @"搜索结果";
            }else
            {
                NSString *key = [self.suoyinArray objectAtIndex:section];
                titleLabel.text = key;
            }
        }
    }
    
    [bgView addSubview:titleLabel];
    return bgView;
}

//索引目录
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.suoyinArray;
}

#pragma mark - 点击索引的时候调用方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //    NSLog(@"index %ld",index);
    
    if (self.historyCityIDArray.count>0) {
        if (index == 1) {
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            return -1;
        }
        
        return index;
    }else
    {
        if (index == 0) {
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
            return -1;
        }
        
        return index;
    }
}

//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.cityArray count];
}


//每组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_isSearch) {
        if (self.historyCityArray.count>0) {
            if (section == 0) {
                return 1;
            }else if(section == 1)
            {
                return 1;
            }else
            {
                ///
                NSArray *citySection = self.cityArray[section];
                return [citySection count];
            }
        }else
        {
            if (section == 0) {
                return 1;
            }else
            {
                NSArray *citySection = self.cityArray[section];
                return [citySection count];
            }
        }
    }else
    {
        ///
        NSArray *citySection = self.cityArray[section];
        return [citySection count];
    }
}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///如果不是搜索状态
    if (!_isSearch) {
        //如果是第一行
        if (indexPath.section == 0) {
            //如果有历史搜索记录
            if (self.historyCityArray.count>0) {
                static NSString *cellID = @"ChooseCityHistoryCell1";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                CGFloat btnWidth = (kViewWidth-40)/3;
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                }
                
                for (int i = 0; i<self.historyCityArray.count; i++) {
                    
                    
                    UIButton *btn = [WNController createButtonWithFrame:CGRectMake(10+(10*(i%3))+btnWidth*(i%3), 10+(36*(i/3))+((i/3)*10), btnWidth, 36) ImageName:@"" Target:self Action:@selector(chooseHistoryCityAction:) Title:self.historyCityArray[i] fontSize:NormalFont];
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
                static NSString *cellID = @"ChooseCityCell1";
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
            }
        }else if(indexPath.section == 1)
        {
            if (self.historyCityArray.count>0) {
                static NSString *cellID = @"ChooseCityCell1";
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
                static NSString *CellIdentifier = @"ChooseCityCell3";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [cell.textLabel setTextColor:[UIColor blackColor]];
                    cell.textLabel.font = [UIFont systemFontOfSize:15];
                }
                
                ///设置城市显示
                NSArray *selectCityArr = self.cityArray[indexPath.section];
                CityModel *model = selectCityArr[indexPath.row];
                cell.textLabel.text = model.cityName;
                
                return cell;
            }
        }else
        {
            static NSString *CellIdentifier = @"ChooseCityCell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.textLabel setTextColor:[UIColor blackColor]];
                cell.textLabel.font = [UIFont systemFontOfSize:15];
            }
            
            ///设置城市显示
            NSArray *selectCityArr = self.cityArray[indexPath.section];
            CityModel *model = selectCityArr[indexPath.row];
            cell.textLabel.text = model.cityName;
            
            return cell;
        }
        
    }else
    {
        static NSString *CellIdentifier = @"ChooseCityCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.textLabel setTextColor:[UIColor blackColor]];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        ///设置城市显示
        NSArray *selectCityArr = self.cityArray[indexPath.section];
        CityModel *model = selectCityArr[indexPath.row];
        cell.textLabel.text = model.cityName;
        
        return cell;
    }
    
}

#pragma mark - 选择历史搜索记录
- (void)chooseHistoryCityAction:(UIButton *)btn
{
    [self.delegate cityName:self.historyCityArray[btn.tag-100] andCityId:self.historyCityIDArray[btn.tag-100]];
    if ([self.isDismis isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isSearch) {
        
        if (self.historyCityArray.count>0) {
            
            if (indexPath.section>1) {
                NSArray *selectCityArr = self.cityArray[indexPath.section];
                CityModel *model = selectCityArr[indexPath.row];
                [self.delegate cityName:model.cityName andCityId:model.cityId];
                [NSUserManager SetSearchText:model.cityName andKey:@"rentHistoryCity"];
                [NSUserManager SetSearchText:model.cityId andKey:@"rentHistoryCityID"];
                
                if ([self.isDismis isEqualToString:@"1"]) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                        
                }else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }else
        {
            if (indexPath.section>0) {
                NSArray *selectCityArr = self.cityArray[indexPath.section];
                CityModel *model = selectCityArr[indexPath.row];
                [self.delegate cityName:model.cityName andCityId:model.cityId];
                [NSUserManager SetSearchText:model.cityName andKey:@"rentHistoryCity"];
                [NSUserManager SetSearchText:model.cityId andKey:@"rentHistoryCityID"];
                if ([self.isDismis isEqualToString:@"1"]) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
        
    }else
    {
        NSArray *selectCityArr = self.cityArray[indexPath.section];
        CityModel *model = selectCityArr[indexPath.row];
        [self.delegate cityName:model.cityName andCityId:model.cityId];
        [NSUserManager SetSearchText:model.cityName andKey:@"rentHistoryCity"];
        [NSUserManager SetSearchText:model.cityId andKey:@"rentHistoryCityID"];
        if ([self.isDismis isEqualToString:@"1"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - 热门城市
- (void)hotCityAction:(UIButton *)hotCity
{
    CityModel *cityModel = self.arrayHotCity[hotCity.tag-100];
    [self.delegate cityName:cityModel.cityName andCityId:cityModel.cityId];
    
    [NSUserManager SetSearchText:cityModel.cityName andKey:@"rentHistoryCity"];
    [NSUserManager SetSearchText:cityModel.cityId andKey:@"rentHistoryCityID"];
    if ([self.isDismis isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    if (![textField.text isEqualToString:@""]) {
        @try {
            //调用搜索接口
            [self searchCity:textField.text];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    return YES;
}


#pragma mark - 判断输入时的变化
- (void)textFieldDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        
        [self loadCityData:@""];
    }
}

#pragma mark 定位到城市的代理方法
- (void)locationAddressString:(NSString *)addString
{
    _cityLab.text = addString;
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    ///抽取前两位
    
    NSString *cityStr = @"";
    @try {
        cityStr = [addString substringWithRange:NSMakeRange(0, 2)];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    [self loadCityData:cityStr];
}

#pragma mark - 搜索城市
- (void)searchCity:(NSString *)cityStr
{
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:cityStr,@"keyword", nil];
    [HttpRequestServers requestBaseUrl:City_list_search withParams:userDict withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        //        HHNSLog(@"-------->%@",dict);
        
        if ([dict[@"status"] isEqualToString:@"f99"]) {
            [self.cityArray removeAllObjects];
            [self.suoyinArray removeAllObjects];
            
            NSMutableArray *listArr = [NSMutableArray array];
            for (NSDictionary *infoDict in dict[@"list"]) {
                //                [self.suoyinArray addObject:infoDict[@"u_name"]];
                
                CityModel *model = [[CityModel alloc] init];
                model.cityName = infoDict[@"name"];
                model.cityId = infoDict[@"id"];
                [listArr addObject:model];
            }
            
            [self.cityArray addObject:listArr];
            
            _isSearch = YES;
            [self.tableView reloadData];
        }
        
        
    } withFieldBlock:^{
        
    }];
}

////TableView的分割线处理
-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
