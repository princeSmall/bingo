//
//  SiteViewController.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GoodDesModel.h"

@interface SiteViewController : BaseTableViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)GoodDesModel * desModel;

@end
