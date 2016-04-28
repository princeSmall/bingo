//
//  MovieGoodsDetailViewController.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 1/26/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieGoodsDetailViewController : BaseViewController

///商品ID
@property (nonatomic,copy) NSString *goodsId;
///店铺ID
@property (nonatomic,copy) NSString *shopID;

//送货方式
@property (nonatomic,strong) NSString * type;

@end
