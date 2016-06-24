//
//  TTIChooseCityController.h
//  TTIChooseAddress
//
//  Created by 童乐 Patrick on 3/31/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShippingAddressModel.h"

typedef void (^backInfoFn)(NSString * address,NSString * addressID);

@interface TTIChooseCityController : UIViewController

@property (nonatomic ,copy)backInfoFn infoFn;

@property (nonatomic,strong)NSString * openShop;

@property (nonatomic,strong)ShippingAddressModel *model;

@property (nonatomic,strong)NSString * queren;

@end
