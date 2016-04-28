//
//  HHLocationService.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HHLocationServiceDelegate <NSObject>

- (void)locationAddressString:(NSString *)addString;

@end

@interface HHLocationService : NSObject


@property (nonatomic,weak) id <HHLocationServiceDelegate>delegate;
///开启定位服务
- (void)openLocationService;
///返回 当期的位置 ///必须先调用 openLocationService 方法

@end
