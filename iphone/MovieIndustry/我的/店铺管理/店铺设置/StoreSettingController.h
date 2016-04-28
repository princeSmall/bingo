//
//  StoreSettingController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>


@protocol  StoreSettingControllerDelegate <NSObject>

- (void)settingMineStoreInfoSuccess:(BOOL)isSuccess;

@end

@interface StoreSettingController : BaseTableViewController

@property (nonatomic,assign) id<StoreSettingControllerDelegate> delegate;


@end
