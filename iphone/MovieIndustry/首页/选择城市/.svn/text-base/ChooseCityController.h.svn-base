//
//  ChooseCityController.h
//  QuLiu
//
//  Created by Shining Chen on 15/9/28.
//  Copyright © 2015年 han. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChooseCityControllerDelegate <NSObject>

-(void)cityName:(NSString *)CityName andCityId:(NSString *)cityId;

@end


@interface ChooseCityController: BaseViewController

@property (nonatomic,copy) NSString *city;

@property (nonatomic,copy) NSString *isDismis;

@property (nonatomic,weak)id <ChooseCityControllerDelegate> delegate;



@end
