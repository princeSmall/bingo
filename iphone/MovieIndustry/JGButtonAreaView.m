//
//  JGButtonAreaView.m
//  选择城市按钮
//
//  Created by aaa on 16/1/21.
//  Copyright © 2016年 aaa. All rights reserved.
//

#import "JGButtonAreaView.h"
#import "AreaButton.h"
#import "ProvinceModel.h"
#import "CitysModel.h"
#import "JGCoverView.h"
#import "JGAreaModel.h"
#import "JGSecondCoverView.h"

@interface JGButtonAreaView ()


//读取plist文件，拿到对应的地址信息，保存到array中
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSMutableArray * provinceArray;
//标识的省份
@property (nonatomic,strong)NSString * provinceStr;
@property (nonatomic,strong)NSString * cityStr;//标识城市的字符
//标识的区域数组
@property (nonatomic,strong)NSArray * areaArray;
@property (nonatomic,strong)NSArray * tableSourceArray;

@property (nonatomic,strong)UIViewController * viewController;

//省份 城市block
@property (nonatomic,strong)EndProvinceBlock provinceBlock;
@property (nonatomic,strong)EndCityBlock cityBlock;
@property (nonatomic,strong)EndAreaBlock areaBlock;


@end
@implementation JGButtonAreaView
//获取省份ID
- (NSString *)getProID{
    return self.proID;
}
//获取城市ID
- (NSString *)getCitID{
    return self.citID;
}
//获取区域ID
- (NSString *)getAreID{
    return self.areID;
}


//获取地址名字段
- (NSString *)getAddress{
    NSString * areaStr = self.areaBtn.titleLabel.text;
    if ([areaStr isEqualToString:@"无"]||[areaStr isEqualToString:@"区域"]) {
        areaStr = @"";
    }
    NSString * string;
    if ([areaStr isEqualToString:@""]) {
        string = [NSString stringWithFormat:@"%@,%@,%@",self.provinceBtn.titleLabel.text,self.cityBtn.titleLabel.text,areaStr];
    }else{
        string = [NSString stringWithFormat:@"%@,%@,%@",self.provinceBtn.titleLabel.text,self.cityBtn.titleLabel.text,areaStr];}
    return string;
}
//判断地址信息是否选择完全
- (BOOL)isAllAddress{
    if ([self.areaBtn.titleLabel.text isEqualToString:@"区域"]) {
        return NO;
    }else{
        return YES;
    }
}
- (instancetype)initWithFrame:(CGRect)frame WithController:(UIViewController *)controller{
    
    if (self = [super initWithFrame:frame]) {
        self.viewController = controller;
        [self createBtnProCityArea];
    }
    return self;
}
//懒加载数据源
- (NSMutableArray *)provinceArray{
    if (_provinceArray == nil) {
        _provinceArray = [NSMutableArray array];
        NSString * path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        NSArray * array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * mutArray = [NSMutableArray array];
        for (NSDictionary * dic in array) {
            ProvinceModel * province = [ProvinceModel provinceWithDict:dic];
            [mutArray addObject:province];
            [_provinceArray addObject:province.state];
        }
        self.dataArray = mutArray;
    }
    return _provinceArray;
}
- (void)createBtnProCityArea{
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -5, 60, 50)];
    addressLabel.text = @"地区";
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:addressLabel];
    CGFloat buttonW = ([UIScreen mainScreen].bounds.size.width - 70)/3;
    CGFloat buttonH = 40;
    CGFloat buttonY = 0;
    CGFloat buttonX1 = 60;
    CGFloat buttonX2 = 60 + buttonW;
    CGFloat buttonX3 = 60 + 2* buttonW;
    //省份button
    self.provinceBtn = [[AreaButton alloc]initWithFrame:CGRectMake(buttonX1, buttonY, buttonW, buttonH)AndString:@"省份"];
    [self addSubview:self.provinceBtn];
//    [self.provinceBtn addTarget:self action:@selector(changeProvince) forControlEvents:UIControlEventTouchUpInside];
    //城市button
    self.cityBtn = [[AreaButton alloc]initWithFrame:CGRectMake(buttonX2, buttonY, buttonW, buttonH) AndString:@"城市"];
    [self addSubview:self.cityBtn];
//    [self.cityBtn addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    //区域button
    self.areaBtn = [[AreaButton alloc]initWithFrame:CGRectMake(buttonX3, buttonY, buttonW, buttonH) AndString:@"区域"];
//    [self.areaBtn addTarget:self action:@selector(changeArea) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.areaBtn];
}




- (void)changeProvinceSecond{
    //这边先拿到数组 然后回主线程  请求数据
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
    NSMutableArray * proArray = [NSMutableArray array];
    
    [HttpRequestServers requestBaseUrl:TIShipping_Regions withParams:dict withRequestFinishBlock:^(id result) {
        
        [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
        
        if (!result[@"data"]) {
            
        }else{
            NSArray * resArray = result[@"data"];
            for (int i = 0; i < resArray.count; i ++) {
                JGAreaModel * model = [[JGAreaModel alloc]initWithDict:resArray[i]];
                [proArray addObject:model];
            }
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
                __weak __typeof(self)weakSelf = self;
                self.coverView = [[JGCoverView alloc]initWithFrame:[UIScreen mainScreen].bounds And:proArray And:^(NSString *string) {
                    
                    NSArray * arrayStr = [string componentsSeparatedByString:@","];
                    weakSelf.provinceBtn.buttonTitle = arrayStr[0];
                    weakSelf.proID = arrayStr[1];
                    weakSelf.cityBtn.buttonTitle = @"城市";
                    weakSelf.areaBtn.buttonTitle = @"区域";
                    weakSelf.citID = nil;
                    weakSelf.areID = nil;
                    weakSelf.provinceStr = string;
//                    [self changeCitySecond];
                    
//                    NSArray * array = [string componentsSeparatedByString:@","];
//                    
                    self.provinceBlock(string);
                }];
                [self.viewController.view addSubview:_coverView];
            }];
            
        }
        
    } withFieldBlock:^{
        [self CreateAlertViewWith:@"网络请求失败，请检查网络"];
        [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
    }];
}


//修改省份
- (void)changeProvince{
    //这边先拿到数组 然后回主线程  请求数据
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
    NSMutableArray * proArray = [NSMutableArray array];
    
    [HttpRequestServers requestBaseUrl:TIShipping_Regions withParams:dict withRequestFinishBlock:^(id result) {
        
        [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
        
        if (!result[@"data"]) {
            
        }else{
        NSArray * resArray = result[@"data"];
        for (int i = 0; i < resArray.count; i ++) {
            JGAreaModel * model = [[JGAreaModel alloc]initWithDict:resArray[i]];
            [proArray addObject:model];
        }
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            __weak __typeof(self)weakSelf = self;
            self.coverView = [[JGCoverView alloc]initWithFrame:[UIScreen mainScreen].bounds And:proArray And:^(NSString *string) {
                
                NSArray * arrayStr = [string componentsSeparatedByString:@","];
                weakSelf.provinceBtn.buttonTitle = arrayStr[0];
                weakSelf.proID = arrayStr[1];
                weakSelf.cityBtn.buttonTitle = @"城市";
                weakSelf.areaBtn.buttonTitle = @"区域";
                weakSelf.citID = nil;
                weakSelf.areID = nil;
                weakSelf.provinceStr = string;
                if (weakSelf.provinceBlock) {
                    weakSelf.provinceBlock(string);
                }
                [weakSelf.coverView removeFromSuperview];
                weakSelf.coverView = nil;
            }];
            [self.viewController.view addSubview:_coverView];
        }];
     
        }
        
    } withFieldBlock:^{
        [self CreateAlertViewWith:@"网络请求失败，请检查网络"];
             [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
    }];
    }
//传出点击省份按钮的事件
- (void)provinceActionEndWithBlock:(EndProvinceBlock)provinceBlock{
    [self changeProvince];
    self.provinceBlock = provinceBlock;
}

- (void)provinceActionEndWithtype:(NSString *)type Block:(EndProvinceBlock)provinceBlock{
[self changeProvinceSecond];
     self.provinceBlock = provinceBlock;

}


//传出点击城市按钮的事件
- (void)cityActionEndWithBlock:(EndCityBlock)cityBlock{
    [self changeCity];
    self.cityBlock = cityBlock;
}

- (void)areaActionEndWithBlock:(EndAreaBlock)areaBlock{

    [self changeArea];
 self.areaBlock = areaBlock;
}


- (void)changeCitySecond{
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = APP_DELEGATE.user_id;
    dict[@"parent_id"] = self.proID;
    [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
    NSMutableArray * citArray = [NSMutableArray array];
    [HttpRequestServers requestBaseUrl:TIShipping_Regions withParams:dict withRequestFinishBlock:^(id result) {
        
        [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
        
        if (!result[@"data"]) {
            
        }else{
            NSArray * resArray = result[@"data"];
            for (int i = 0; i < resArray.count; i ++) {
                JGAreaModel * model = [[JGAreaModel alloc]initWithDict:resArray[i]];
                [citArray addObject:model];
            }
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                
                CGRect rect = self.coverView.frame;
                CGFloat tableVX = rect.size.width/3;
                CGFloat tableVY = rect.size.height/6;
                CGFloat tableVW = rect.size.width/3;
                CGFloat tableVH = rect.size.height/3*2;
                
                JGSecondCoverView * second = [[JGSecondCoverView alloc]initWithFrame:CGRectMake(tableVX, tableVY, tableVW, tableVH) And:citArray WithBlock:^(NSString *string) {
                    weakSelf.provinceBlock(string);
                    self.coverView = nil;
                    [self.coverView removeFromSuperview];
                }];
                [self.viewController.view addSubview:second];
                
            }];
            
        }
    } withFieldBlock:^{
        [self CreateAlertViewWith:@"网络请求失败，请检查网络"];
        [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
    }];

    




}


- (void)changeCity{
//    NSArray * cityArray;
//    NSMutableArray * mutCityArray = [NSMutableArray array];
//    for (ProvinceModel * province in self.dataArray) {
//        if ([self.provinceStr isEqualToString:province.state]) {
//            cityArray = province.cities;
//            break;
//        }
//    }
//    for (CitysModel * model in cityArray) {
//        [mutCityArray addObject:model.city];
//    }
//    
    if (self.proID) {
        __weak __typeof(self)weakSelf = self;
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"user_id"] = APP_DELEGATE.user_id;
        dict[@"parent_id"] = self.proID;
        [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
         NSMutableArray * citArray = [NSMutableArray array];
        [HttpRequestServers requestBaseUrl:TIShipping_Regions withParams:dict withRequestFinishBlock:^(id result) {
            
            [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
            
            if (!result[@"data"]) {
                
            }else{
                NSArray * resArray = result[@"data"];
                for (int i = 0; i < resArray.count; i ++) {
                    JGAreaModel * model = [[JGAreaModel alloc]initWithDict:resArray[i]];
                    [citArray addObject:model];
                }
                
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    self.coverView = [[JGCoverView alloc]initWithFrame:[UIScreen mainScreen].bounds And:citArray And:^(NSString *string) {
                        
                        NSArray * arrayStr = [string componentsSeparatedByString:@","];
                        weakSelf.cityBtn.buttonTitle = arrayStr[0];
                        weakSelf.citID = arrayStr[1];
                        if (weakSelf.cityBlock) {
                            weakSelf.cityBlock(string);
                        }
                        weakSelf.areaBtn.buttonTitle = @"区域";
                        weakSelf.areID = nil;
                        [_coverView removeFromSuperview];
//                        for (CitysModel * model in citArray) {
//                            if ([model.city isEqualToString:string]) {
//                                weakSelf.areaArray = model.areas;
//                                break;
//                            }
//                        }
                        weakSelf.coverView = nil;
                    }];
                    [self.viewController.view addSubview:_coverView];
                    
                }];
                
            }
        } withFieldBlock:^{
        [self CreateAlertViewWith:@"网络请求失败，请检查网络"];
            [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
        }];

    }else{
        [self CreateAlertViewWith:@"省份信息没有选择"];
    }
}
- (void)changeArea{
    
    if(!self.citID){
        [self CreateAlertViewWith:@"城市信息没有选择"];
    }else{
        
        NSMutableArray * areArray = [NSMutableArray array];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"user_id"] = APP_DELEGATE.user_id;
        dict[@"parent_id"] = self.citID;
        [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
        [HttpRequestServers requestBaseUrl:TIShipping_Regions withParams:dict withRequestFinishBlock:^(id result) {
            [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
            if (!result[@"data"]) {
                
            }else{
                
                if ([result[@"data"] isKindOfClass:[NSArray class]]) {
                    NSArray * resArray = result[@"data"];
                    for (int i = 0; i < resArray.count; i ++) {
                        JGAreaModel * model = [[JGAreaModel alloc]initWithDict:resArray[i]];
                        [areArray addObject:model];
                    }
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        
                        __weak __typeof(self)weakSelf = self;
                        self.coverView = [[JGCoverView alloc]initWithFrame:[UIScreen mainScreen].bounds And:areArray And:^(NSString *string) {
                            
                            NSArray * arrayStr = [string componentsSeparatedByString:@","];
                            
                            weakSelf.areaBtn.buttonTitle = arrayStr[0];
                            weakSelf.areID = arrayStr[1];
                            
                            if (weakSelf.areaBlock) {
                                weakSelf.areaBlock(string);
                            }
                            [weakSelf.coverView removeFromSuperview];
                            weakSelf.coverView = nil;
                        }];
                        [self.viewController.view addSubview:_coverView];
                    }];
                }else{
                   self.areaBtn.buttonTitle = @"无";
                    self.areID = @"0";
                
                }
            }
        } withFieldBlock:^{
            [self CreateAlertViewWith:@"网络请求失败，请检查网络"];
            [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:YES];
            
            
        }];
        
        
//        
//        if (self.areaArray.count>0) {
//            __weak __typeof(self)weakSelf = self;
//            self.coverView = [[JGCoverView alloc]initWithFrame:[UIScreen mainScreen].bounds And:weakSelf.areaArray And:^(NSString *string) {
//                weakSelf.areaBtn.buttonTitle = string;
//                [weakSelf.coverView removeFromSuperview];
//                weakSelf.coverView = nil;
//            }];
//            [self.viewController.view addSubview:_coverView];
//        }else{
//            [self.areaBtn setTitle:@"无" forState:UIControlStateNormal];
//        }
    }
}

- (void)CreateAlertViewWith:(NSString *)string{
    UIAlertController *Alertview=[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Okaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [Alertview addAction:Okaction];
    [self.viewController presentViewController:Alertview animated:YES completion:nil];
}

- (void)ChangeTitleWith:(NSArray *)array{

    [self.provinceBtn  setButtonTitle:array[0]];
    self.cityBtn.buttonTitle = array[1];
    if (![array[2] isEqualToString:@""]) {
        self.areaBtn.buttonTitle = array[2];
    }else{
        self.areaBtn.buttonTitle = @"无";
    }
    
    

}

@end
