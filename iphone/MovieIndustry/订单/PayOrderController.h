//
//  PayOrderController.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodDesModel.h"

@interface PayOrderController : BaseViewController

@property (nonatomic,strong)NSDictionary * payDict;
@property (nonatomic,strong) GoodDesModel * model;
@property (nonatomic,strong) NSArray * goodsInfoArray;
@property (nonatomic,strong)NSString * goodsCount;

@property (nonatomic,strong)NSDictionary * addressDic;

@end
