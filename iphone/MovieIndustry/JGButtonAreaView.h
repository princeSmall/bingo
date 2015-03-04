//
//  JGButtonAreaView.h
//  选择城市按钮
//
//  Created by aaa on 16/1/21.
//  Copyright © 2016年 aaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGCoverView.h"
#import "AreaButton.h"

typedef void (^EndProvinceBlock)(NSString * provinceStr);
typedef void (^EndCityBlock)(NSString * cityStr);
typedef void (^EndAreaBlock)(NSString * areaStr);

@interface JGButtonAreaView : UIView

@property (nonatomic,strong)JGCoverView * coverView;
@property (nonatomic,strong)AreaButton * provinceBtn;
@property (nonatomic,strong)AreaButton * cityBtn;
@property (nonatomic,strong)AreaButton * areaBtn;
@property (nonatomic,strong)NSString * proID;
@property (nonatomic,strong)NSString * citID;
@property (nonatomic,strong)NSString * areID;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame WithController:(UIViewController *)controller;
//获取 地址名字段
- (NSString *)getAddress;
//判断地址信息是否选择完全
- (BOOL)isAllAddress;

//传出点击省份按钮的事件
- (void)provinceActionEndWithBlock:(EndProvinceBlock)provinceBlock;
//传出点击省份按钮的事件 二级分类
- (void)provinceActionEndWithtype:(NSString *)type Block:(EndProvinceBlock)provinceBlock;
//传出点击城市按钮的事件
- (void)cityActionEndWithBlock:(EndCityBlock)cityBlock;
//传出点击区域的事件
- (void)areaActionEndWithBlock:(EndAreaBlock)areaBlock;


//传入数组修改数据
- (void)ChangeTitleWith:(NSArray *)array;

//获取省份ID
- (NSString *)getProID;
//获取城市ID
- (NSString *)getCitID;
//获取区域ID
- (NSString *)getAreID;

@end
