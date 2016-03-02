//
//  MoviePersonalInfoViewController.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/21.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UserDesModel.h"


@class MovieMineInfoModel;

@interface MoviePersonalInfoViewController : UITableViewController


@property (nonatomic,strong) void(^backRefreshInfo)(BOOL needRefresh);

@property (nonatomic,strong) MovieMineInfoModel *mineModel;

@property (nonatomic,strong) UserDesModel * desModel;

@end
