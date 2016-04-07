//
//  TTIChooseCityController.h
//  TTIChooseAddress
//
//  Created by Hopkins Patrick on 3/31/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^backInfoFn)(NSString * address,NSString * addressID);

@interface TTIChooseCityController : UIViewController

@property (nonatomic ,copy)backInfoFn infoFn;

@property (nonatomic,strong)NSString * openShop;

@end
