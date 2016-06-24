//
//  ChooseCityTableView.h
//  MovieIndustry
//
//  Created by 童乐 on 15/12/14.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseCityTableViewDelegate <NSObject>

-(void)cityName:(NSString *)CityName andCityId:(NSString *)cityId;

@end

@interface ChooseCityTableView : UITableView

///索引目录
@property (nonatomic,strong) NSMutableArray *suoyinArray;
///城市数组
@property (nonatomic,strong) NSMutableArray *cityArray;
///热点城市
@property (nonatomic, strong) NSMutableArray *arrayHotCity;//热门城市

@property (nonatomic,weak)id<ChooseCityTableViewDelegate>myDelegate;

@end
