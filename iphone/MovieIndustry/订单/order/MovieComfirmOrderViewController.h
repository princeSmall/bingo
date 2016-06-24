//
//  MovieComfirmOrderViewController.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "BaseViewController.h"
#import "GoodDesModel.h"


@protocol MovieComfirmOrderViewDelegate <NSObject>

- (void)payMineOrderSuccess:(BOOL)isSuccess;

@end


@interface MovieComfirmOrderViewController : BaseViewController

@property (nonatomic,assign) id<MovieComfirmOrderViewDelegate> delegate;


/** 周二抢 */
@property (nonatomic,copy) NSString *tebie;


///店铺ID
@property (nonatomic,copy) NSString * shopID;
///商品ID
@property (nonatomic,copy) NSString *goodsID;

///商品数据 从上一个试图控制器传来
@property (nonatomic,strong) NSArray * goodsInfoArray;

///是否来自购物车
@property (nonatomic,copy) NSString *isShoppingCar;

@property (nonatomic,strong) GoodDesModel * model;

@property (nonatomic,strong)NSString * goodsCount;

@property (nonatomic,strong)NSString * dataStr;

@property (nonatomic,strong)NSString *method;

@property (nonatomic,strong)NSString * type;

- (void)loadAddressMoren;
@end
