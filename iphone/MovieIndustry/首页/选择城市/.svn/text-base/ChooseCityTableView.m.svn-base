//
//  ChooseCityTableView.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/14.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ChooseCityTableView.h"
#import "CityModel.h"

@interface ChooseCityTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChooseCityTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
    }
    return self;
}

#pragma mark - tableView 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
///cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

//头部的View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 30)];
    bgView.backgroundColor=kViewBackColor;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor=[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:NormalFont];
    
    if (section == 0) {
        titleLabel.text = @"热门城市";
    }else
    {
        NSString *key = [self.suoyinArray objectAtIndex:section];
        titleLabel.text = key;
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
    if (index == 0) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
        return -1;
    }
    
    return index;
}

//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.cityArray count];
}


//每组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section == 0) {
            return 1;
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
    if (indexPath.section == 0) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>0) {
        NSArray *selectCityArr = self.cityArray[indexPath.section];
        CityModel *model = selectCityArr[indexPath.row];
        [self.myDelegate cityName:model.cityName andCityId:model.cityId];
    }
}

#pragma mark - 热门城市
- (void)hotCityAction:(UIButton *)hotCity
{
    CityModel *cityModel = self.arrayHotCity[hotCity.tag-100];
    [self.myDelegate cityName:cityModel.cityName andCityId:cityModel.cityId];
}

@end
