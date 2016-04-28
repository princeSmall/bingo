//
//  TTIChooseCityController.m
//  TTIChooseAddress
//
//  Created by Hopkins Patrick on 3/31/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import "TTIChooseCityController.h"
#import "JGAreaModel.h"
#import "ItemsCell.h"
#import "ShippingAddressController.h"

typedef void (^chooseFn)(id result,int status,NSString * ID);

@interface TTIChooseCityController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)chooseFn chooseCellFn;

@property (nonatomic,strong)UIView *headerProvinceView;

@property (nonatomic,strong)UIView *headerCityView;

@property (nonatomic,strong)NSMutableArray * sourceArray;

//两个label
@property (nonatomic,strong)UILabel * label1;
@property (nonatomic,strong)UILabel * label2;


//省市区的id
@property (nonatomic,strong)NSString * proID;
@property (nonatomic,strong)NSString * citID;
@property (nonatomic,strong)NSString * areID;

/**
 *  选择的阶段 0 省 1 市 2 区
 */
@property (nonatomic ,assign)int status;
@end

@implementation TTIChooseCityController
-(UIView *)headerProvinceView
{
    if(!_headerProvinceView)
    {
        _headerProvinceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        _headerProvinceView.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
        UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, 150, 40)];
        label.text = @"选择的省名";
        label.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:17];
        label.tag = 1000;
        [_headerProvinceView addSubview:label];
    }
    return _headerProvinceView;
    
}

-(UIView *)headerCityView
{
    if(!_headerCityView)
    {
        _headerCityView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 50)];
        _headerCityView.backgroundColor = [UIColor grayColor];
        UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
        label.tag =2000;
        label.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:17];
        label.text = @"选择的市名";
        [_headerCityView addSubview:label];
        
        
    }
    return _headerCityView;
    
}

- (void)requestDataWithParentID:(NSString *)ID{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"parent_id"] = ID;
    [HttpRequestServers requestBaseUrl:TIShipping_Regions withParams:dict withRequestFinishBlock:^(id result) {
        @try {
            NSArray * array = result[@"data"];
            NSMutableArray * mutArr = [NSMutableArray array];
            for (int i = 0; i < array.count; i ++) {
                [mutArr addObject:[[JGAreaModel alloc]initWithDict:array[i]]];
            }
            self.sourceArray = [NSMutableArray arrayWithArray:mutArr];
            
            [self.tableView reloadData];
        }
        @catch (NSException *exception) {}@finally {}
    } withFieldBlock:^{
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.617 blue:0.938 alpha:1.000];
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = @"选择所在地";
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    [self.view addSubview:self.headerProvinceView];
    [self.view addSubview:self.headerCityView];
    self.sourceArray = [NSMutableArray array];
    self.status = 0;
    [self setMyblock];
    [self createTableView];
    [self requestDataWithParentID:@""];
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    [leftBtn setBackgroundColor:[UIColor whiteColor]];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}
-(void)backAction
{
    switch (self.status) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            NSLog( @"选择省--时退出");
            break;
        case 1:
        {
            [self requestDataWithParentID:@""];
            [UIView beginAnimations:@"doflip" context:nil];
            //设置时常
            [UIView setAnimationDuration:0.6];
            //设置动画淡入淡出
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            //设置代理
            [UIView setAnimationDelegate:self];
            //设置翻转方向
            [UIView setAnimationTransition:
             UIViewAnimationTransitionFlipFromLeft
                                   forView:self.headerProvinceView cache:YES];
            //动画结束
            [UIView commitAnimations];
            
            [UIView animateWithDuration:0.4 animations:^{
                CGRect frame =  self.tableView.frame;
                frame.origin.y = frame.origin.y-50;
                frame.size.height += 50;
                self.tableView.frame = frame;
            } completion:^(BOOL finished) {
                self.headerProvinceView .hidden = YES;
            }];
            NSLog( @"选择城市时返回到选择省");
            self.status -=1;
        }
            break;
            
            
        case 2:
        {
            [self requestDataWithParentID:self.proID];
            [UIView beginAnimations:@"doflip" context:nil];
            //设置时常
            [UIView setAnimationDuration:0.6];
            //设置动画淡入淡出
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            //设置代理
            [UIView setAnimationDelegate:self];
            //设置翻转方向
            [UIView setAnimationTransition:
             UIViewAnimationTransitionFlipFromLeft  forView:self.headerCityView cache:YES];
            //动画结束
            [UIView commitAnimations];
            [UIView animateWithDuration:0.4 animations:^{
                CGRect frame =  self.tableView.frame;
                frame.origin.y = frame.origin.y-50;
                frame.size.height += 50;
                self.tableView.frame = frame;
            } completion:^(BOOL finished) {
                self.headerCityView .hidden = YES;
            }];
            self.status -=1;
            NSLog( @"选择区时返回到选择城市");
            
        }
            
        default:
            break;
    }
}

-(void)setMyblock
{
    __weak typeof(self)weakSelf = self;
    self.chooseCellFn = ^(id result ,int status,NSString * ID){
        if(status==0)//省
        {
            weakSelf.proID = ID;
            weakSelf.headerProvinceView.hidden=NO;
            UILabel *label = (UILabel *)[weakSelf.headerProvinceView viewWithTag:1000];
            label.text = result;
            label.textColor = [UIColor redColor];
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame =  weakSelf.tableView.frame;
                frame.origin.y = frame.origin.y+50;
                frame.size.height = frame.size.height - 50;
                weakSelf.tableView.frame = frame;
            }];
            weakSelf.label1 = label;
        }
        else if (status==1)//市
        {
            weakSelf.citID = ID;
            weakSelf.headerCityView.hidden = NO;
            UILabel *label = (UILabel *)[weakSelf.headerCityView viewWithTag:2000];
            label.text = result;
            label.textColor = [UIColor redColor];
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame =  weakSelf.tableView.frame;
                frame.origin.y = frame.origin.y+50;
                frame.size.height = frame.size.height - 50;
                weakSelf.tableView.frame = frame;
            }];
            weakSelf.label2 = label;
        }
        else if (status==2)//区
        {
            weakSelf.areID = ID;
            if ([weakSelf.openShop isEqualToString:@"1"]) {
                /**
                 *  这边要返回开通店铺的页面
                 */
                NSString * addressID = [NSString stringWithFormat:@"%@,%@,%@",weakSelf.proID,weakSelf.citID,weakSelf.areID];
                NSString * addressString = [NSString stringWithFormat:@"%@,%@,%@",weakSelf.label1.text,weakSelf.label2.text,result];
                weakSelf.infoFn(addressString,addressID);
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                NSLog(@"跳出页面");
                ShippingAddressController * ship = [[ShippingAddressController alloc]init];
                
                if (weakSelf.queren) {
                    ship.isQuerenOrder = YES;
                }
                
                ship.addressID = [NSString stringWithFormat:@"%@,%@,%@",weakSelf.proID,weakSelf.citID,weakSelf.areID];
                ship.addressString = [NSString stringWithFormat:@"%@,%@,%@",weakSelf.label1.text,weakSelf.label2.text,result];
                [weakSelf.navigationController pushViewController:ship animated:YES];
            }
        }
        weakSelf.status ++;
    };
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    
}

-(void)createTableView
{
    
    CGRect rect = self.view.frame;
    rect.size.height -= 64;
    
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView .tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemsCell *cell = [[ItemsCell alloc]initWithTableView:tableView indexpath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameStringLbl.text = ((JGAreaModel*)self.sourceArray[indexPath.row]).local_name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.chooseCellFn(cell.nameStringLbl.text,self.status,((JGAreaModel*)self.sourceArray[indexPath.row]).ID);
    [self requestDataWithParentID:((JGAreaModel*)self.sourceArray[indexPath.row]).ID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
