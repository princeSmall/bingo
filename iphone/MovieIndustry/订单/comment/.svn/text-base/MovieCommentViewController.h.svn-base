//
//  MovieCommentViewController.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MyOrderShopModel.h"
#import "OrderGoodsModel.h"

typedef void (^endBlock)(BOOL ok);

@interface MovieCommentViewController : BaseViewController
//店铺信息，一个店铺一个订单模型
@property (nonatomic,strong) MyOrderShopModel *shopModel;
@property (nonatomic,strong) NSDictionary * goodsModel;
@property (nonatomic,strong) NSArray *goodsModelArray;
@property (nonatomic,strong) NSString *isDetail;

@property (nonatomic,strong)endBlock block;

@property (nonatomic,strong)NSString * isList;

@end
